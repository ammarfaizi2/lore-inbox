Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVKHQXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVKHQXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVKHQXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:23:42 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:35333 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932407AbVKHQXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:23:41 -0500
Date: Wed, 9 Nov 2005 00:23:05 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       hpa@zytor.com, autofs@linux.kernel.org
Subject: Re: [PATCH 15/25] autofs: move ioctl32 to autofs{,4}/root.c
In-Reply-To: <Pine.LNX.4.63.0511072355560.2069@donald.themaw.net>
Message-ID: <Pine.LNX.4.63.0511090020110.3099@donald.themaw.net>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
 <20051105162716.551500000@b551138y.boeblingen.de.ibm.com>
 <Pine.LNX.4.63.0511061407160.2621@donald.themaw.net> <200511071136.19087.arnd@arndb.de>
 <Pine.LNX.4.63.0511072355560.2069@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Ian Kent wrote:

> >  
> > > Its been a while since I trawled through the compat ioctl code (please 
> > > point me to the right place) but with this change I think that the 
> > > AUTOFS_IOC_SETTIMEOUT32 is redundant. Consider a conditional define for 
> > > AUTOFS_IOC_SETTIMEOUT in include/linux/auto_fs.h instead. Both autofs and 
> > > autofs4 use that definition.
> > 
> > The point here is that the two are different on 64 bit platforms, since
> > sizeof (int) != sizeof (long). You also can't do
> > 
> > switch (cmd) {
> > case AUTOFS_IOC_SETTIMEOUT32:
> > case AUTOFS_IOC_SETTIMEOUT:
> > 	return do_stuff();
> > }
> > 
> > because then gcc would complain about duplicate case targets on 32 bit
> > targets.
> 
> I was thinking that if the module was compiled for 64bit then the 64bit 
> definition would prevail and visa versa.
> 
> eg. In the include file.
> 
> #ifdef COMPAT_IOCTL
> #define AUTOFS_IOC_SETTIMEOUT(..., unsigned int)
> #else
> #define AUTOFS_IOC_SETTIMEOUT(...,unsigned long)
> #endif
> 
> I think I'm going to have to investigate further following the 
> implementation.

Yes. I see now, stupid suggestion.

> 
> > 
> > If you are sure you don't need the BKL, then you should also replace
> > ".ioctl = ..." with ".unlocked_ioctl = ...".
> 
> Yep. I'll check and amend it later.
> After all it will be part of the module then.

Yep. I'll do that.

Ian

