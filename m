Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWGWQZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWGWQZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 12:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWGWQZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 12:25:09 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:36028 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751168AbWGWQZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 12:25:07 -0400
Date: Sun, 23 Jul 2006 18:08:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ricknu-0@student.ltu.se
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
In-Reply-To: <1153669750.44c39a7607a30@portal.student.luth.se>
Message-ID: <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr>
References: <1153341500.44be983ca1407@portal.student.luth.se>
 <1153669750.44c39a7607a30@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hopefully it is now ready for a "real" patch, whom adds bool to all
>arches. If there is no comments on this one, it will be sent about
>tomorrow night (GMT).

--- a/drivers/block/DAC960.h
+++ b/drivers/block/DAC960.h
@@ -71,7 +71,7 @@ #define DAC690_V2_PciDmaMask	0xfffffffff
   Define a Boolean data type.
 */
 
-typedef enum { false, true } __attribute__ ((packed)) boolean;
+typedef bool boolean;
 
 
 /*

Looks good. (I know found out what this is good for. Eventually, all booleans
in the source of DAC960 et al. should be changed to just 'bool' but that's
another patch's job.)

Looks good, except for the "all arches" thing. You only seem to add it
to i386:

>--- a/include/asm-i386/types.h
>+++ b/include/asm-i386/types.h
>@@ -1,6 +1,8 @@
> #ifndef _I386_TYPES_H
> #define _I386_TYPES_H
> 
>+typedef _Bool bool;
>+
> #ifndef __ASSEMBLY__
> 
> typedef unsigned short umode_t;


>+#undef false
>+#undef true
>+
>+enum {
>+	false	= 0,
>+	true	= 1
>+};
>+
>+#define false false
>+#define true true 

Can someone please tell me what advantage 'define true true' is going to
bring, besides than being able to '#ifdef true'?



Jan Engelhardt
-- 
