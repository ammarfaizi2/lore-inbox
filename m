Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWGIEev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWGIEev (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 00:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWGIEev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 00:34:51 -0400
Received: from xenotime.net ([66.160.160.81]:34275 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964969AbWGIEeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 00:34:50 -0400
Date: Sat, 8 Jul 2006 21:37:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: mreuther@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: Compile Error on 2.6.17-mm6
Message-Id: <20060708213734.a204a044.rdunlap@xenotime.net>
In-Reply-To: <20060708204448.6914aaf9.akpm@osdl.org>
References: <200607072222.31586.mreuther@umich.edu>
	<20060708174347.76391c7b.akpm@osdl.org>
	<20060708203424.281400d2.rdunlap@xenotime.net>
	<20060708204448.6914aaf9.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006 20:44:48 -0700 Andrew Morton wrote:

> On Sat, 8 Jul 2006 20:34:24 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > On Sat, 8 Jul 2006 17:43:47 -0700 Andrew Morton wrote:
> > 
> > > On Fri, 7 Jul 2006 22:22:16 -0400
> > > Matt Reuther <mreuther@umich.edu> wrote:
> > > 
> > > > Here is the error:
> > > >   CHK     include/linux/compile.h
> > > >   UPD     include/linux/compile.h
> > > >   CC      init/version.o
> > > >   LD      init/built-in.o
> > > >   LD      .tmp_vmlinux1
> > > > arch/i386/kernel/built-in.o(.text+0xe282): In function 
> > > > `cpu_request_microcode':
> > > > arch/i386/kernel/microcode.c:544: undefined reference to `request_firmware'
> > > > arch/i386/kernel/built-in.o(.text+0xe304):arch/i386/kernel/microcode.c:573: 
> > > > undefined reference to `release_firmware'
> > > 
> > > CONFIG_FW_LOADER=m
> > > CONFIG_MICROCODE=y
> > > 
> > > So
> > > 
> > > config MICROCODE
> > > 	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
> > > 	depends on FW_LOADER
> > > 
> > > is not sufficient.  There's a fix for this, but I cannot remember what it
> > > is.  Help.
> > 
> > That 1-line depends patch fixes the problem for me (on x86-64,
> > but they are the same in this area).
> > 
> 
> What patch is that?

My -mm6 does not have "depends on FW_LOADER" like you wrote above,
so I thought that you had added that 1-line as a patch.



From: Randy Dunlap <rdunlap@xenotime.net>

MICROCODE needs FW_LOADER functions.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/Kconfig   |    1 +
 arch/x86_64/Kconfig |    1 +
 2 files changed, 2 insertions(+)

--- linux-2617-mm6.orig/arch/x86_64/Kconfig
+++ linux-2617-mm6/arch/x86_64/Kconfig
@@ -159,6 +159,7 @@ config X86_GOOD_APIC
 
 config MICROCODE
 	tristate "/dev/cpu/microcode - Intel CPU microcode support"
+	depends on FW_LOADER
 	---help---
 	  If you say Y here the 'File systems' section, you will be
 	  able to update the microcode on Intel processors. You will
--- linux-2617-mm6.orig/arch/i386/Kconfig
+++ linux-2617-mm6/arch/i386/Kconfig
@@ -399,6 +399,7 @@ config X86_REBOOTFIXUPS
 
 config MICROCODE
 	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
+	depends on FW_LOADER
 	---help---
 	  If you say Y here and also to "/dev file system support" in the
 	  'File systems' section, you will be able to update the microcode on



---
