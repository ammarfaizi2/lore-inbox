Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264781AbSJOSmt>; Tue, 15 Oct 2002 14:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264827AbSJOSmt>; Tue, 15 Oct 2002 14:42:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:23773 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264781AbSJOSms>;
	Tue, 15 Oct 2002 14:42:48 -0400
Subject: [PATCH] compile fix for dmi_scan.c in 2.4.bk-current
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Oct 2002 11:40:53 -0700
Message-Id: <1034707253.19093.174.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, 
	Saw you've inc'ed the EXTRAVERSION in bk, so I figured I should send
this fix to you before you mailed out pre11.

I'm not sure if its the "proper" fix, but solves:

arch/i386/kernel/kernel.o: In function `fix_broken_hp_bios_irq9':
arch/i386/kernel/kernel.o(.text.init+0x3601): undefined reference to
`broken_hp_bios_irq9'
arch/i386/kernel/kernel.o(.text.init+0x3614): undefined reference to
`broken_hp_bios_irq9'

thanks
-john

PS: agpgart seems broken as well, but I don't normally build w/ it, so
I'll leave the fix to someone who knows what they're doing.


--- 1.26/arch/i386/kernel/dmi_scan.c    Thu Oct 10 16:12:50 2002
+++ edited/arch/i386/kernel/dmi_scan.c  Tue Oct 15 00:55:36 2002
@@ -492,7 +492,7 @@
 static __init int fix_broken_hp_bios_irq9(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_PCI
-       extern int broken_hp_bios_irq9;
+       int broken_hp_bios_irq9;
        if (broken_hp_bios_irq9 == 0)
        {
                broken_hp_bios_irq9 = 1;


