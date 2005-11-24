Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVKXHNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVKXHNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKXHNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:13:12 -0500
Received: from outbound04.telus.net ([199.185.220.223]:4043 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751346AbVKXHNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:13:11 -0500
Message-ID: <43856925.1020704@telusplanet.net>
Date: Thu, 24 Nov 2005 00:17:57 -0700
From: Bob Gill <gillb4@telusplanet.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc2-git3 build fails at mtrr/ipi_handler undeclared
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. 
I am trying to build 2.6.15-rc2-git3, but it fails with an error:
make: *** [arch/i386/kernel] Error 2
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      arch/i386/kernel/cpu/mtrr/main.o
arch/i386/kernel/cpu/mtrr/main.c: In function `set_mtrr':
arch/i386/kernel/cpu/mtrr/main.c:225: error: `ipi_handler' undeclared 
(first use in this function)
arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier 
is reported only once
arch/i386/kernel/cpu/mtrr/main.c:225: error: for each function it 
appears in.)
make[3]: *** [arch/i386/kernel/cpu/mtrr/main.o] Error 1
make[2]: *** [arch/i386/kernel/cpu/mtrr] Error 2
make[1]: *** [arch/i386/kernel/cpu] Error 2
make: *** [arch/i386/kernel] Error 2
  CHK     include/linux/version.h
...
(vmlinuz/initial ramdisk image are not built, etc.)
....
but ipi_handler seems to be defined at line 141 in 
/arch/i386/kernel/cpu/mtrr/main.c.  However, my build script does not 
include SMP (I'm on a single cpu machine), and ipi_handler is wrapped in
#ifdef CONFIG_SMP
#endif
(my SMP build options are):
CONFIG_BROKEN_ON_SMP=y
# CONFIG_X86_BIGSMP is not set
# CONFIG_SMP is not set
CONFIG_X86_FIND_SMP_CONFIG=y
....
(The obvious solution is to change my script to CONFIG_SMP=Y, but I 
suspect there is a more elegant solution).
2.6.15-rc2 builds/runs ok with the same build script.
Please mail me directly as I'm not on the list.
TIA
Bob
