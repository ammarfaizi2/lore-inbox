Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUDLUnN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUDLUnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:43:13 -0400
Received: from ms-smtp-02-qfe0.socal.rr.com ([66.75.162.134]:48355 "EHLO
	ms-smtp-02-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S263089AbUDLUmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:42:54 -0400
Date: Mon, 12 Apr 2004 13:15:24 -0700
From: Andrew Vasquez <praka@users.sourceforge.net>
To: linux-kernel@vger.kernel.org, sam@ravnborg.org
Cc: Marcus Hartig <m.f.h@web.de>
Subject: Re: 2.6.5-mm4
Message-ID: <20040412201524.GA31684@praka.local.home>
Reply-To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Mail-Followup-To: Andrew Vasquez <praka@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, sam@ravnborg.org,
	Marcus Hartig <m.f.h@web.de>
References: <407AEBB0.1050305@web.de> <20040412195636.GB12665@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412195636.GB12665@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.5-rc3-mm3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Sam Ravnborg wrote:

> On Mon, Apr 12, 2004 at 09:19:12PM +0200, Marcus Hartig wrote:
> > Hello,
> > 
> > patch: "kbuild-external-module-support" ?
> > 
> > brakes nicely my nVidia driver for installation at stage 2. Happy easter 
> > gift. No setting of KBUILD_EXTMOD or editing the install script helps, 
> > nice job.
> Please provide me with more info.
> I gooled a bit after some NVIDIA src - but I stopped when I had
> to accept some NVIDIA stuff.
> 
> The purpose is to provide good support for external modules.
> If it breaks things I need to find out why - and see where to fix it.
> 
> I would not be suprised if NVIDIA (and wmware for that matter) takes some
> assumptions which it should not. But I need to find out why it break,
> and for that I need more information!
> 
> So please provide me with the following information:
> 1) Exact log when it goes wrong
> 2) Pointer to or copy of the relevant files
> 

I maintain the qla2xxx driver and have been noticing some build
problems also.  I typically do most compiling and editing of the
driver outside of the kernel tree, i.e. my make command usually takes
on the form:

	-bash-2.05b# make -C /usr/src/linux-2.6.5-mm3 SUBDIRS=$PWD modules
	make: Entering directory `/usr/src/linux-2.6.5-mm3'
	*** Warning: Overriding SUBDIRS on the command line can cause
	***          inconsistencies
	make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/ql2300.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/ql2300_fw.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_os.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_init.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_mbx.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_iocb.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_isr.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_gs.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_dbg.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_sup.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_rscn.o
	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2xxx.o
	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2300.o
	  Building modules, stage 2.
	  MODPOST
	*** Warning: "fc_release_transport"
	[/root/Drivers/8.x/80000b12-pre14/qla2xxx.ko] undefined!
	*** Warning: "fc_attach_transport"
	[/root/Drivers/8.x/80000b12-pre14/qla2xxx.ko] undefined!
	  CC      /root/Drivers/8.x/80000b12-pre14/qla2300.mod.o
	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2300.ko
	  CC      /root/Drivers/8.x/80000b12-pre14/qla2xxx.mod.o

With 2.6.5-mm4 a similar command fails with:

	-bash-2.05b# make -C /usr/src/linux-2.6.5-mm4 SUBDIRS=$PWD modules
	make: Entering directory `/usr/src/linux-2.6.5-mm4'
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/ql2300.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/ql2300_fw.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_os.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_init.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_mbx.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_iocb.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_isr.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_gs.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_dbg.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_sup.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_rscn.o
	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2xxx.o
	/bin/sh: line 1:
	/root/Drivers/8.x/80000b12-pre14/.tmp_versions/qla2xxx.mod: No such
	file or directory
	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2300.o
	/bin/sh: line 1:
	/root/Drivers/8.x/80000b12-pre14/.tmp_versions/qla2300.mod: No such
	file or directory
	  HOSTCC  /root/Drivers/8.x/80000b12-pre14/extras/qla_nvr
	  Building modules, stage 2.
	make: Leaving directory `/usr/src/linux-2.6.5-mm4'

I've even tried the 'M=...' syntax documented in the Makefile:

	-bash-2.05b# make -C /usr/src/linux-2.6.5-mm4 M=$PWD modules
	make: Entering directory `/usr/src/linux-2.6.5-mm4'
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/ql2300.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/ql2300_fw.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_os.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_init.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_mbx.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_iocb.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_isr.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_gs.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_dbg.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_sup.o
	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_rscn.o
	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2xxx.o
	/bin/sh: line 1:
	/root/Drivers/8.x/80000b12-pre14/.tmp_versions/qla2xxx.mod: No such
	file or directory
	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2300.o
	/bin/sh: line 1:
	/root/Drivers/8.x/80000b12-pre14/.tmp_versions/qla2300.mod: No such
	file or directory
	  HOSTCC  /root/Drivers/8.x/80000b12-pre14/extras/qla_nvr
	  Building modules, stage 2.
	make: Leaving directory `/usr/src/linux-2.6.5-mm4'

So, what am I missing?  I can provide other logs if needed, just tell
me what you need.

Thanks,
Andrew Vasquez
QLogic Corporation

