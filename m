Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276746AbRJBW3Y>; Tue, 2 Oct 2001 18:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276747AbRJBW3O>; Tue, 2 Oct 2001 18:29:14 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:53501 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276746AbRJBW3C>; Tue, 2 Oct 2001 18:29:02 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 2 Oct 2001 16:28:44 -0600
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: Re: /dev/random entropy calculations broken?
Message-ID: <20011002162844.Q8954@turbolinux.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Theodore Y. Ts'o" <tytso@MIT.EDU>
In-Reply-To: <20011002150233.M8954@turbolinux.com> <Pine.LNX.4.30.0110021613480.19213-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0110021613480.19213-100000@waste.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2001  16:29 -0500, Oliver Xymoron wrote:
> Cool. Not sure if I like the introduction of poolbits. My personal
> preference would be to s/poolwords/words/ and just use ->words*32, since
> foo->foomember is a throwback to pre-ANSI compilers with a flat namespace
> for structure members. Note that we don't bother prefixing tap*.

I added poolbits because we were doing poolwords * 32 all the time in the
commonly called functions credit_entropy_store() and batch_entropy_process()).
I don't really care either way, except that it makes the code easier to read.

We could always do the following (hackish, but makes code more readable):

#define POOLBITS	poolwords*32
#define POOLBYTES 	poolwords*4

> If not, at least put poolbits in the structure first...
> 
> >  static struct poolinfo {
> >  	int	poolwords;
> > +	int	poolbits;	/* poolwords * 32 */
> >  	int	tap1, tap2, tap3, tap4, tap5;
> >  } poolinfo_table[] = {
> >  	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
> > -	{ 2048,	1638,	1231,	819, 	411,	1 },
> > +	{ 2048,	65536,	1638,	1231,	819,	411,	1 },
>                 ^^^^^
> ...because it's not as confusing comparing the polynomial in the comment
> to the initializer.

Sorry, I didn't notice that the poolwords was also part of the polynomial.
I'll wait a while before reposting in case of more comments (Ted has been
silent thus far).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

