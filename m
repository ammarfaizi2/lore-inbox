Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272430AbTHIQdf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272432AbTHIQdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:33:32 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:16505
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272430AbTHIQdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:33:19 -0400
Date: Sat, 9 Aug 2003 12:33:17 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 Make defconfig or menuconfig - unchoosables
Message-Id: <20030809123317.720b30d9.seanlkml@rogers.com>
In-Reply-To: <20030809182429.094de20b.lista1@telia.com>
References: <20030809182429.094de20b.lista1@telia.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.102.213.108] using ID <seanlkml@rogers.com> at Sat, 9 Aug 2003 12:33:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 18:24:29 +0200
Voluspa <lista1@telia.com> wrote:

> 
> Looking for the fabled but hard to locate "ikconfig":
> 

Hi there..

    For some reason this is the only piece that has not made it
into the mainline.  I'm not sure who's shepherding this through
but i've attached the outstanding patch.

Cheers,
Sean


diff -urN -X dontdiff linux-1.5/init/Kconfig linux-2.5-osdl/init/Kconfig
--- linux-2.5/init/Kconfig	2003-07-14 09:36:04.000000000 -0700
+++ linux-2.5-osdl/init/Kconfig	2003-07-14 09:52:16.000000000 -0700
@@ -109,6 +109,31 @@
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config IKCONFIG
+	bool "Kernel .config support"
+	---help---
+	  This option enables the complete Linux kernel ".config" file 
+	  contents, information on compiler used to build the kernel, 
+	  kernel running when this kernel was built and kernel version 
+	  from Makefile to be saved in kernel. It provides documentation 
+	  of which kernel options are used in a running kernel or in an 
+	  on-disk kernel.  This information can be extracted from the kernel 
+	  image file with the script scripts/extract-ikconfig and used as 
+	  input to rebuild the current kernel or to build another kernel. 
+	  It can also be extracted from a running kernel by reading 
+	  /proc/ikconfig/config and /proc/ikconfig/built_with, if enabled. 
+	  /proc/ikconfig/config will list the configuration that was used 
+	  to build the kernel and /proc/ikconfig/built_with will list 
+	  information on the compiler and host machine that was used to 
+	  build the kernel.
+
+config IKCONFIG_PROC
+	bool "Enable access to .config through /proc/ikconfig"
+	depends on IKCONFIG
+	---help---
+	  This option enables access to kernel configuration file and build
+	  information through /proc/ikconfig.
+
 
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"

