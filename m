Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWGVRTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWGVRTw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWGVRTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:19:52 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:21417 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750974AbWGVRTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:19:51 -0400
Message-ID: <1153588759.44c25e17dd274@portal.student.luth.se>
Date: Sat, 22 Jul 2006 19:19:19 +0200
From: ricknu-0@student.ltu.se
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC][PATCH] A generic boolean (version 3)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153524422.44c162c65c21b@portal.student.luth.se> <Pine.LNX.4.61.0607221057050.8381@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607221057050.8381@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Jan Engelhardt <jengelh@linux01.gwdg.de>:

> >+++ b/drivers/block/DAC960.h
> >@@ -71,7 +71,7 @@ #define DAC690_V2_PciDmaMask	0xfffffffff
> >   Define a Boolean data type.
> > */
> > 
> >-typedef enum { false, true } __attribute__ ((packed)) boolean;
> >+typedef bool boolean;
> > 
> Probably I missed some mail, but why can't we just have typedef _Bool bool?
> Like below?

Because it defines bool in include/asm/types.h, then "all" files will have the
bool-type. But because DAC960.h calles it boolean I just typedefed the new
bool-type to "boolean". Then if this gets into -mm or linus-tree, I/we can start
to clean up all the code using booleans. After all, there is also BOOL and
BOOLEAN but they are not effected by this change.

> 
> >+++ b/include/asm-i386/types.h
> >@@ -1,6 +1,13 @@
> > #ifndef _I386_TYPES_H
> > #define _I386_TYPES_H
> > 
> >+#if __GNUC__ >= 3
> >+typedef _Bool bool;
> >+#else
> >+#warning You compiler doesn't seem to support boolean types, will set
> 'bool' as
> >an 'unsigned int'
> >+typedef unsigned int bool;
> >+#endif
> >+
> > #ifndef __ASSEMBLY__
> > 
> > typedef unsigned short umode_t;
> >--- a/include/linux/stddef.h
> >+++ b/include/linux/stddef.h
> >@@ -10,6 +10,17 @@ #else
> > #define NULL ((void *)0)
> > #endif
> > 
> >+#undef false
> >+#undef true
> 
> Wasnot this supposed to go away?

#undef or enum?
There has not been any #undef's before, and enum I think is better. This since
Jeff showed it could be combined with the #define for the cpp's sake.

> 
> >+
> >+enum {
> >+	false	= 0,
> >+	true	= 1
> >+};
> >+
> >+#define false false
> >+#define true true 
> >+
> > #undef offsetof
> > #ifdef __compiler_offsetof
> > #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
> >
> 
> Jan Engelhardt

/Richard Knutsson
