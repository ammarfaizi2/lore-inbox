Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131099AbQKIOnQ>; Thu, 9 Nov 2000 09:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131100AbQKIOnG>; Thu, 9 Nov 2000 09:43:06 -0500
Received: from slc359.modem.xmission.com ([166.70.2.105]:39174 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S131099AbQKIOm4>; Thu, 9 Nov 2000 09:42:56 -0500
X-From-Line: nobody Thu Nov  9 01:18:24 2000
To: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.rutgers.edu>
Subject: Q: Linux rebooting directly into linux.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2000 01:18:24 -0700
Message-ID: <m17l6deey7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have recently developed a patch that allows linux to directly boot
into another linux kernel.  With the code freeze it appears
inappropriate to submit it at this time. 

Linus in principal do you have any trouble with this kind of
functionality? 

The immediate applications of this code, are:
- Clusters can network can network boot over arbitrary network
  interfaces, and the network driver only needs to be written and
  maintained in one place.
- Multiplatform boot loaders can be written.
- The Linux kernel can be included in a boot ROM and you can still
  boot other linux kernels.
- Kernel developers can have a fast interface for booting into a
  development kernel.

The interface is designed to be simple and inflexible yet very
powerful.  To that end the code just takes an elf binary, and a
command line.  The started image also takes an environment generated
by the kernel of all of the unprobeable hardware details.

ELF was picked for it's multiplatform support and the sheer simplicity
of it's program header.  Plus you can use standard tools to generate
elf images fairly easily.  

The environment passed to a loaded image is designed to expand and
handle new data types without breaking old decoders.  They just break
because the don't support the new hardware :)

Linus the path I envision is that this code gets integrated early in
2.5.  This includes cleaning up the boot paths so all our C code has
to deal with is this new format.  Then backporting the functionality
to 2.4 and possibly 2.2.

The kernel patches can be found in:
ftp://ftp.linuxnetworx.com/pub/kexec-patches-1.0.tar.gz
(This is a patchset with 4 patches
 1 Ingo Molanar's improved apic support
 2 My enhancements upon it so we restore the apics to their boot
   state when we shut down.
 3 My 2 line patch to make certain that in smp_send_stop
   the last cpu running is the boot cpu. (Required by the MP spec...)
 4 The code to support execing a new kernel. )

The code to generate a image bootable by this new syscall is in:
ftp://ftp.linuxnetworx.com/pub/mkelfImage-1.0.tar.gz
  (This is a perl script that takes a kernel and possibly a ramdisk
   and a command line and generates an elfimage suitable to be booted
   in this new infrastructure)

Eric

p.s. Linus the code is not included inline because I don't expect it to
be included just yet.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
