Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVDEIiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVDEIiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDEIiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:38:46 -0400
Received: from tornado.reub.net ([60.234.136.108]:51089 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261626AbVDEIel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:34:41 -0400
Message-ID: <42524D83.1080104@reub.net>
Date: Tue, 05 Apr 2005 20:34:11 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050404)
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
References: <fa.gcqu6i7.1o6qrhn@ifi.uio.no>
In-Reply-To: <fa.gcqu6i7.1o6qrhn@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
> 
> - x86 NMI handling seems to be bust in 2.6.12-rc2.  Try using
>   `nmi_watchdog=0' if you experience weird crashes.
> 
> - The possible kernel-timer related hangs might possibly be fixed.  We
>   haven't heard yet.
> 
> - Nobody said anything about the PM resume and DRI behaviour in
>   2.6.12-rc1-mm4.  So it's all perfect now?
> 
> - Various fixes and updates.  Nothing earth-shattering.
> 
> 
> 
> Changes since 2.6.12-rc1-mm4:
> 
> 
>  bk-acpi.patch
>  bk-agpgart.patch
>  bk-cifs.patch
>  bk-cpufreq.patch
>  bk-cryptodev.patch
>  bk-driver-core.patch
>  bk-drm.patch
>  bk-drm-via.patch
>  bk-ia64.patch
>  bk-audit.patch
>  bk-input.patch
>  bk-jfs.patch
>  bk-kbuild.patch
>  bk-mtd.patch
>  bk-netdev.patch
>  bk-nfs.patch
>  bk-ntfs.patch
>  bk-scsi.patch
>  bk-watchdog.patch
> 
>  Latest versions of subsystem trees

Hrm. Something changed between the last -mm release which compiled 
through, and this one..

  CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.init.text+0x1823): In function `setup_arch':
: undefined reference to `acpi_boot_table_init'
arch/i386/kernel/built-in.o(.init.text+0x1828): In function `setup_arch':
: undefined reference to `acpi_boot_init'
make: *** [.tmp_vmlinux1] Error 1
[root@tornado linux-2.6]#

Backing out bk-acpi.patch works around it..

reuben


