Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131338AbQJ1Ui0>; Sat, 28 Oct 2000 16:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131337AbQJ1UiQ>; Sat, 28 Oct 2000 16:38:16 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:6148 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129068AbQJ1UiK>;
	Sat, 28 Oct 2000 16:38:10 -0400
Message-Id: <200010281629.e9SGTah07672@sleipnir.valparaiso.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test10-pre6: Use of abs()
X-Mailer: MH [Version 6.8.4]
Date: Sat, 28 Oct 2000 13:29:36 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Red Hat 7.0, i686, gcc-20001027 (Yes, I know. Just to flush out bugs on
both sides).

abs() is used at least in:

arch/i386/kernel/time.c
drivers/md/raid1.c
drivers/sound/sb_ess.c

gcc warns about use of a non-declared function each time.

No definition for the function is to be found (grep over all include/ comes
up clean, except for extern definitions in asm-{mips,ppc}; ditto for lib/).
Presumably gcc is using a builtin (it doesn't show up in System.map). Is
this the desired state of affairs? Should a include/linux/stdlib.h be
added, containing (for now, to be expanded later as needed, like
include/linux/stddef.h):

#ifndef _LINUX_STDLIB_H
#define _LINUX_STDLIB_H

extern int abs(int);

#endif
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
