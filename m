Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTGTOv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 10:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTGTOv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 10:51:29 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:13235 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S266807AbTGTOvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 10:51:02 -0400
Message-ID: <081701c34ed0$5be60070$64ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Tried to run 2.6.0-test1
Date: Mon, 21 Jul 2003 00:03:57 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, I cannot cope with the volume in this mailing list.
If anyone volunteers to help and/or if anyone has questions,
please e-mail me directly.

On Red Hat 9 without Qt, make xconfig wouldn't run.
Make menuconfig ran.  Compilation ran.
During make modules_install, there were warnings about
undefined symbols for a bunch of wireless LAN card modules.
But at least the thing ran.
It boots, it keeps the screen nearly blank during booting,
then X comes up and the thing runs.
During shutdown, the screen returns to the same nearly blank display
that it had during booting.  I have to guess when it's safe to shut
off the power.  But in between startup and shutdown, it runs.
On Red Hat 9.

Then I moved to SuSE 8.1 and tried configuring a few more options.

On SuSE 8.1, make xconfig ran.  Just before the xconfig windows
appeared, these warnings appeared in the terminal window:
  ./scripts/kconfig/qconf arch/i386/Kconfig
  boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'
  #
  # using defaults found in arch/i386/defconfig
  #
  arch/i386/defconfig:68: trying to assign nonexistent symbol X86_SSE2
  arch/i386/defconfig:544: trying to assign nonexistent symbol NET_PCMCIA_RADIO
  arch/i386/defconfig:663: trying to assign nonexistent symbol INTEL_RNG
Maybe one of these provides a clue about wireless LAN card modules.

Compilation starts, but this is weird:
    AS      arch/i386/boot/setup.o
  /tmp/ccZht1mp.s: Assembler messages:
  /tmp/ccZht1mp.s:1903: Warning: value 0x37ffffff truncated to 0x37ffffff
That's some truncation, eh?

These look troublesome though:
    CC [M]  drivers/mtd/nftlcore.o
  drivers/mtd/nftlcore.c: In function `NFTL_foldchain':
  drivers/mtd/nftlcore.c:354: warning: passing arg 7 of pointer to function
    makes pointer from integer without a cast
  drivers/mtd/nftlcore.c:358: warning: passing arg 7 of pointer to function
    makes pointer from integer without a cast
  drivers/mtd/nftlcore.c:363: warning: passing arg 7 of pointer to function
    makes pointer from integer without a cast
  drivers/mtd/nftlcore.c: In function `nftl_writeblock':
  drivers/mtd/nftlcore.c:632: warning: passing arg 7 of pointer to function
    makes pointer from integer without a cast
  drivers/mtd/nftlcore.c: In function `nftl_readblock':
  drivers/mtd/nftlcore.c:696: warning: passing arg 7 of pointer to function
    makes pointer from integer without a cast
    CC [M]  drivers/mtd/nftlmount.o
  drivers/mtd/nftlmount.c: In function `find_boot_record':
  drivers/mtd/nftlmount.c:220: warning: passing arg 7 of pointer to function
    makes pointer from integer without a cast

Oh, and then compilation of modules aborts:
    CC [M]  drivers/mtd/devices/doc2000.o
  drivers/mtd/devices/doc2000.c: In function `DoC2k_init':
  drivers/mtd/devices/doc2000.c:567: warning: assignment from incompatible
    pointer type
  drivers/mtd/devices/doc2000.c:568: warning: assignment from incompatible
    pointer type
    CC [M]  drivers/mtd/devices/docprobe.o
    CC [M]  drivers/mtd/devices/docecc.o
    CC [M]  drivers/mtd/devices/slram.o
    CC [M]  drivers/mtd/devices/blkmtd.o
  drivers/mtd/devices/blkmtd.c:52:25: linux/iobuf.h: No such file or directory
  drivers/mtd/devices/blkmtd.c: In function `blkmtd_readpage':
  drivers/mtd/devices/blkmtd.c:219: warning: implicit declaration of function
    `alloc_kiovec'
  drivers/mtd/devices/blkmtd.c:236: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:239: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:240: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:241: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:242: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:243: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:265: warning: implicit declaration of function
    `brw_kiovec'
  drivers/mtd/devices/blkmtd.c:267: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:268: warning: implicit declaration of function
    `free_kiovec'
  drivers/mtd/devices/blkmtd.c:169: warning: unused variable `b'
  drivers/mtd/devices/blkmtd.c: In function `write_queue_task':
  drivers/mtd/devices/blkmtd.c:323: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:351: `KIO_MAX_SECTORS' undeclared (first use
    in this function)
  drivers/mtd/devices/blkmtd.c:351: (Each undeclared identifier is reported
    only once
  drivers/mtd/devices/blkmtd.c:351: for each function it appears in.)
  drivers/mtd/devices/blkmtd.c:369: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:370: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:382: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:384: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:392: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:393: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c:407: dereferencing pointer to incomplete type
  drivers/mtd/devices/blkmtd.c: In function `blkmtd_erase':
  drivers/mtd/devices/blkmtd.c:527: warning: unused variable `b'
  drivers/mtd/devices/blkmtd.c: In function `blkmtd_read':
  drivers/mtd/devices/blkmtd.c:640: warning: unused variable `b'
  drivers/mtd/devices/blkmtd.c: In function `blkmtd_write':
  drivers/mtd/devices/blkmtd.c:713: parse error before "e3"
  drivers/mtd/devices/blkmtd.c:712: warning: unused variable `b'
  drivers/mtd/devices/blkmtd.c: At top level:
  drivers/mtd/devices/blkmtd.c:932: parse error before "cleanup_blkmtd"
  drivers/mtd/devices/blkmtd.c:933: warning: return type defaults to `int'
  drivers/mtd/devices/blkmtd.c:1021: parse error before "calc_erase_regions"
  drivers/mtd/devices/blkmtd.c:1022: warning: return type defaults to `int'
  drivers/mtd/devices/blkmtd.c:1047: parse error before "__init"
  drivers/mtd/devices/blkmtd.c:1047: warning: type defaults to `int' in
    declaration of `__init'
  drivers/mtd/devices/blkmtd.c:1047: warning: data definition has no type
    or storage class
  drivers/mtd/devices/blkmtd.c:1050: parse error before "init_blkmtd"
  drivers/mtd/devices/blkmtd.c:1051: warning: return type defaults to `int'
  drivers/mtd/devices/blkmtd.c: In function `init_blkmtd':
  drivers/mtd/devices/blkmtd.c:1199: structure has no member named `module'
  drivers/mtd/devices/blkmtd.c:1060: warning: unused variable `b'
  drivers/mtd/devices/blkmtd.c: At top level:
  drivers/mtd/devices/blkmtd.c:1269: warning: type defaults to `int' in
    declaration of `module_init'
  drivers/mtd/devices/blkmtd.c:1269: warning: parameter names (without
    types) in function declaration
  drivers/mtd/devices/blkmtd.c:1269: warning: data definition has no type
    or storage class
  drivers/mtd/devices/blkmtd.c:1270: warning: type defaults to `int' in
    declaration of `module_exit'
  drivers/mtd/devices/blkmtd.c:1270: warning: parameter names (without
    types) in function declaration
  drivers/mtd/devices/blkmtd.c:1270: warning: data definition has no type
    or storage class
  make[3]: *** [drivers/mtd/devices/blkmtd.o] Error 1
  make[2]: *** [drivers/mtd/devices] Error 2
  make[1]: *** [drivers/mtd] Error 2
  make: *** [drivers] Error 2
  
OK, I made menuconfig again and removed some MTD stuff.  It made but
it wouldn't boot.  The screen was blank for the entire boot process
(after grub selected the kernel to boot).  After a while I pressed
Ctrl-Alt-Del and rebooted my old kernel.
/var/log/messages includes this:
  Jul 20 22:10:20 diamondpana kernel: Loaded 28312 symbols from
    /boot/System.map-2.6.0-test1.
  Jul 20 22:10:20 diamondpana kernel: Symbols match kernel version 2.6.0.
  Jul 20 22:10:20 diamondpana kernel: No module symbols loaded -
    kernel modules not enabled.
Huh???  What about these lines in .config:
  CONFIG_MODULES=y
  CONFIG_MODULE_UNLOAD=y
  CONFIG_MODULE_FORCE_UNLOAD=y
  CONFIG_OBSOLETE_MODPARM=y
  # CONFIG_MODVERSIONS is not set
  CONFIG_KMOD=y
And this output to ls /lib/modules/2.6.0-test1:
  build        modules.generic_string  modules.parportmap  modules.usbmap
  kernel       modules.ieee1394map     modules.pcimap
  modules.dep  modules.isapnpmap       modules.pnpbiosmap
What does the thing need in order to use modules?
Is this the reason why the screen is completely blank during the boot
process instead of only mostly blank?  Is it the reason why X doesn't
come up?  By the way there are also no tones from PCMCIA during the
boot process so I'm pretty sure it's also not recognizing my LAN card,
but when I reboot my old kernel then PCMCIA recognizes the LAN card
just fine during booting.

Oh... the README says:
   - Make sure you have gcc 2.95.3 available.
Unfortunately I only have gcc 3.2 available.  Sigh.
But I think that was the same on Red Hat 9, probably.

So what does the thing need in order to recognize its modules?
