Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUGHMAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUGHMAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbUGHMAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:00:37 -0400
Received: from ltgp.iram.es ([150.214.224.138]:33665 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S264610AbUGHMAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:00:24 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 8 Jul 2004 13:55:11 +0200
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: tom st denis <tomstdenis@yahoo.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040708115511.GA4391@iram.es>
References: <20040707184737.GA25357@infradead.org> <20040707185340.42091.qmail@web41112.mail.yahoo.com> <20040708093249.GC32629@iram.es> <20040708111521.GK12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708111521.GK12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 12:15:21PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jul 08, 2004 at 11:32:50AM +0200, Gabriel Paubert wrote:
> 
> > Yes, I know and I use BK. But given the fact that you insult me for 
> > better knowing C rules than you, I'm seriously considering switch 
> > to subversion or arch instead.
> > 
> > Argh, I've mentioned BK. There should be a Goldwin's law equivalent
> > for BitKeeper on lkml ;-)
> 
> Godwin, surely?

Right, should have looked the name up.

> 
> Anyway, if you think that suckversion authors knew C...  Try to read their
> decoder/parser/whatever you call the code handling the data stream obtained
> from other end of connection.  _Especially_ when it comes to signedness
> (of integers, mostly).

I did not read it, neither did I read BitKeeper's code for 
obvious reasons.

> 
> > - the aforementioned fgetc/getc/getchar issues.
> 
> ... have nothing to do with char; getc() has more legitimate return values
> than char can represent.  

Only one more, unless I missed something.

> No matter whether it's signed or unsigned, if
> you have
> 	... char c;
> 	...
> 	c = getc();
> you have a bug - Dirichlet Principle bites you anyway.

Indeed, but unfortunately you don't hit the problem with 
pure ASCII on x86. That's one of the reasons for which 
a lot of code ported to archs where char is unsigned by
default is simply compiled with -fsigned-char instead of 
correcting the bugs. 

The remaining case (char 0xff) is infrequent, at least 
for Latin-[19] encodings in the languages I know, and 
never happens with UTF-8 AFAICT. 

Heck, even the 2.4 ppc kernel is compiled with 
-fsigned-char, for $DEITY's sake. 

	Regards,
	Gabriel

