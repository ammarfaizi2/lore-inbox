Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVBWR2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVBWR2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 12:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVBWR1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 12:27:43 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51396 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261507AbVBWR11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 12:27:27 -0500
Message-Id: <200502231727.j1NHRPGH028335@laptop11.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: Ignored return value of __clear_user in fs/binfmt_elf.c?
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 23 Feb 2005 14:27:24 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 23 Feb 2005 14:27:25 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine is sparc64, bk of today, gcc-3.4.2-6.fc3 (Aurora Corona). First 2.6
I try to build here, so it might be something known.

Build fails due to -Werror with:

include/asm/uaccess.h: In function `load_elf_binary':
arch/sparc64/kernel/../../../fs/binfmt_elf.c:811: warning: ignoring return value of `__clear_user', declared with attribute warn_unused_result

Around line 811 of fs/binfmt_elf.c I see:

                             /*
                              * This bss-zeroing can fail if the ELF file
                              * specifies odd protections.  So we don't check                                * the return value
                              */
                              (void)clear_user((void __user *)elf_bss +
                                                      load_bias, nbyte);

so presumably this discarding is OK here...

I wonder why an explicit (void) cast is not considered "use" by the
compiler. But then again, explicitly throwing away isn't really "use"...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
