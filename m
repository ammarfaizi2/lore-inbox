Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276697AbRJBV1O>; Tue, 2 Oct 2001 17:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276698AbRJBV1E>; Tue, 2 Oct 2001 17:27:04 -0400
Received: from waste.org ([209.173.204.2]:25421 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S276697AbRJBV1A>;
	Tue, 2 Oct 2001 17:27:00 -0400
Date: Tue, 2 Oct 2001 16:29:38 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: Re: /dev/random entropy calculations broken?
In-Reply-To: <20011002150233.M8954@turbolinux.com>
Message-ID: <Pine.LNX.4.30.0110021613480.19213-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001, Andreas Dilger wrote:

> > While we're on words/bytes/bits confusion, add_entropy_words() seems to
> > get called with number of bytes rather than words.
>
> Makes it that much more random, doesn't it ;-).  OK, here is a new version
> of the patch.  It clears up the parameters to the functions, and makes sure
> that we pass the right values to each.

Cool. Not sure if I like the introduction of poolbits. My personal
preference would be to s/poolwords/words/ and just use ->words*32, since
foo->foomember is a throwback to pre-ANSI compilers with a flat namespace
for structure members. Note that we don't bother prefixing tap*.

If not, at least put poolbits in the structure first...

>  static struct poolinfo {
>  	int	poolwords;
> +	int	poolbits;	/* poolwords * 32 */
>  	int	tap1, tap2, tap3, tap4, tap5;
>  } poolinfo_table[] = {
>  	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
> -	{ 2048,	1638,	1231,	819, 	411,	1 },
> +	{ 2048,	65536,	1638,	1231,	819,	411,	1 },
                ^^^^^
...because it's not as confusing comparing the polynomial in the comment
to the initializer.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

