Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277142AbRJIGPE>; Tue, 9 Oct 2001 02:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277726AbRJIGOz>; Tue, 9 Oct 2001 02:14:55 -0400
Received: from rj.sgi.com ([204.94.215.100]:13756 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S277142AbRJIGOo>;
	Tue, 9 Oct 2001 02:14:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: torvalds@transmeta.com, arjanv@redhat.com, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA RAID breaks modular IDE compile 
In-Reply-To: Your message of "Mon, 08 Oct 2001 23:59:39 CST."
             <200110090559.f995xd923187@vindaloo.ras.ucalgary.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Oct 2001 16:15:04 +1000
Message-ID: <27982.1002608104@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001 23:59:39 -0600, 
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
>  Hi, all. In 2.4.11-pre6, the ATA RAID code breaks compiling IDE as a
>module: I get duplicate "init_module" symbols. I don't even have
>ATA RAID enabled!

Yeuch!  Who defined ide-mod-objs in terms of $(export-objs) and why?
Fix against 2.4.11-pre6.

Index: 11-pre6.1/drivers/ide/Makefile
--- 11-pre6.1/drivers/ide/Makefile Tue, 09 Oct 2001 11:09:32 +1000 kaos (linux-2.4/E/b/44_Makefile 1.1.2.3.1.1 644)
+++ 11-pre6.1(w)/drivers/ide/Makefile Tue, 09 Oct 2001 16:13:01 +1000 kaos (linux-2.4/E/b/44_Makefile 1.1.2.3.1.1 644)
@@ -75,7 +75,7 @@ obj-$(CONFIG_BLK_DEV_ATARAID_HPT)	+= hpt
 
 ide-obj-$(CONFIG_PROC_FS)		+= ide-proc.o
 
-ide-mod-objs		:= $(export-objs) $(ide-obj-y)
+ide-mod-objs		:= ide.o ide-features.o $(ide-obj-y)
 ide-probe-mod-objs	:= ide-probe.o ide-geometry.o
 
 include $(TOPDIR)/Rules.make

