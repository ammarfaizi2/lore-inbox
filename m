Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265068AbUELAX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265068AbUELAX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUELAMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:12:43 -0400
Received: from hera.kernel.org ([63.209.29.2]:27830 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265088AbUELAIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:08:16 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Date: Wed, 12 May 2004 00:07:44 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c7rpsg$ghd$1@terminus.zytor.com>
References: <20040503230911.GE7068@logos.cnet> <200405042253.11133@WOLK> <40982AC6.5050208@eyal.emu.id.au> <20040506121302.GI9636@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1084320464 16942 127.0.0.1 (12 May 2004 00:07:44 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 12 May 2004 00:07:44 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040506121302.GI9636@fs.tum.de>
By author:    Adrian Bunk <bunk@fs.tum.de>
In newsgroup: linux.dev.kernel
> > >
> > >yep. Either we backport WARN_ON ;) or simply do the attached.
> > >
> > >--- old/drivers/net/tg3.c	2004-05-04 14:30:22.000000000 +0200
> > >+++ new/drivers/net/tg3.c	2004-05-04 14:49:58.000000000 +0200
> > >@@ -51,6 +51,10 @@
> > > #define TG3_TSO_SUPPORT	0
> > > #endif
> > > 
> > >+#ifndef WARN_ON
> > >+#define	WARN_ON(x)	do { } while (0)
> > >+#endif
> > 
> > Related but off topic. Do people find the ab#define	WARN_ON(x)
> > a macro acceptable? The fact is that not mentioning 'x' means any
> > side-effects are not executed, meaning the author must take special
> > care when using this macro.
> >...
> 
> Do not use code with side effects in BUG_ON and WARN_ON.
> 

Why not use the much simpler:

#ifndef WARN_ON
# define WARN_ON(x) ((void)(x))
#endif

Preserves side effects and everything.

	-hpa
