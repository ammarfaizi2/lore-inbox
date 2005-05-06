Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVEFPXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVEFPXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 11:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEFPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 11:23:43 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:11475 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261242AbVEFPXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 11:23:30 -0400
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cbf07e669ed84066a0bc366ca254123b@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: PPC uImage build not reporting correctly
Date: Fri, 6 May 2005 10:23:05 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

Tom pointed me at you to look at a makefile issue with 
arch/ppc/boot/images/Makefile.  When I do the following:

$ make uImage
   CHK     include/linux/version.h
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   UIMAGE  arch/ppc/boot/images/uImage
Image Name:   Linux-2.6.12-rc3
Created:      Fri May  6 10:19:28 2005
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    993322 Bytes = 970.04 kB = 0.95 MB
Load Address: 0x00000000
Entry Point:  0x00000000
   Image: arch/ppc/boot/images/uImage not made

The issue is that the file arch/ppc/boot/images/uImage does exit (the 
'not made' is not correct).

$(obj)/uImage: $(obj)/vmlinux.gz
         $(Q)rm -f $@
         $(call if_changed,uimage)
         @echo '  Image: $@' $(if $(wildcard $@),'is ready','not made')

It seems the $(wildcard $@) expands at the start of the rule.  Any 
ideas?

- kumar 

