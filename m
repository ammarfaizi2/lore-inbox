Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSFRMSi>; Tue, 18 Jun 2002 08:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSFRMSh>; Tue, 18 Jun 2002 08:18:37 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:33163 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317392AbSFRMSg>; Tue, 18 Jun 2002 08:18:36 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 18 Jun 2002 05:18:29 -0700
Message-Id: <200206181218.FAA08522@adam.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Various kbuild problems in 2.5.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I would like to note the following problems with the
kernel build process in 2.5.22, after applying the patch that
Kai Germaschewski posted that enabled modversions to work again.
All but the first one are spurious dependencies.


	1. doing make modversions twice results in bad .ver files, with
lines like:

#define __ver_pcmcia_get_mem_page_Rsmp_3d2ded54 smp_ba03375b
#define pcmcia_get_mem_page_Rsmp_3d2ded54       _set_ver(pcmcia_get_mem_page_Rsmp_3d2ded54)

	...which should be:

#define __ver_pcmcia_get_mem_page smp_ba03375b
#define pcmcia_get_mem_page       _set_ver(pcmcia_get_mem_page)

	2. "make bzImage" does not build a bzImage if any module fails
to compile.  Really, it should not attempt to buidl modules or even
descend into directories that contain only modules.  To build a bzImage,
I have to edit the Makefile and comment out "BUILD_MODULES:=1".

	3. make include/linux/modversios.h aborts if any .c file has
a #error or #include's a .h that is not present (for example, because
the .h is built by the process, as is the case with one scsi driver).

	4. "make -k modules" will not build perfectly buildable modules
in a directory that has a subdirectory where a compile error occurs.

	All of this used to work a couple of kernel versions ago.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
