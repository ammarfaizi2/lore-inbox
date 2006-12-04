Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760171AbWLDAgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760171AbWLDAgx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760172AbWLDAgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 19:36:53 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:17121 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1760171AbWLDAgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 19:36:53 -0500
Message-ID: <45736D9E.7060506@garzik.org>
Date: Sun, 03 Dec 2006 19:36:46 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: drivers/atm throws weird build "error"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running "make allmodconfig" on current linux-2.6.git top of tree on 
x86-64, I see the following when beginning a drivers/atm compile:

> make -f scripts/Makefile.build obj=drivers/atm
> include/asm/byteorder.h:5:28: error: linux/compiler.h: No such file or directory

However, the build continues just fine.

Here's the full KBUILD_VERBOSE=1 section in question:

>   gcc -Wp,-MD,drivers/ata/.pata_triflex.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.1.1/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os  -march=k8 -m64 -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks -Wno-sign-compare -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -fstack-protector -fstack-protector-all -fno-omit-frame-pointer -fno-optimize-sibling-calls -fasynchronous-unwind-tables -g  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign   -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(pata_triflex)"  -D"KBUILD_MODNAME=KBUILD_STR(pata_triflex)" -c -o drivers/ata/.tmp_pata_triflex.o drivers/ata/pata_triflex.c
>   gcc -Wp,-MD,drivers/ata/.ata_generic.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.1.1/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os  -march=k8 -m64 -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks -Wno-sign-compare -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -fstack-protector -fstack-protector-all -fno-omit-frame-pointer -fno-optimize-sibling-calls -fasynchronous-unwind-tables -g  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign   -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(ata_generic)"  -D"KBUILD_MODNAME=KBUILD_STR(ata_generic)" -c -o drivers/ata/.tmp_ata_generic.o drivers/ata/ata_generic.c
> make -f scripts/Makefile.build obj=drivers/atm
> include/asm/byteorder.h:5:28: error: linux/compiler.h: No such file or directory
>    rm -f drivers/atm/built-in.o; ar rcs drivers/atm/built-in.o
>   gcc -Wp,-MD,drivers/atm/.zatm.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.1.1/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os  -march=k8 -m64 -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks -Wno-sign-compare -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -fstack-protector -fstack-protector-all -fno-omit-frame-pointer -fno-optimize-sibling-calls -fasynchronous-unwind-tables -g  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign   -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(zatm)"  -D"KBUILD_MODNAME=KBUILD_STR(zatm)" -c -o drivers/atm/.tmp_zatm.o drivers/atm/zatm.c

Regards,

	Jeff


