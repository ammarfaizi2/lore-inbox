Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUC2Xo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUC2Xo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:44:26 -0500
Received: from [202.65.75.150] ([202.65.75.150]:4993 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S263183AbUC2XoY (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:44:24 -0500
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Tue, 30 Mar 2004 07:36:53 +0800
To: J <summer@computerdatasafe.com.au>
Cc: Linux-Kernel@vger.kernel.org
Subject: [PATCH] Re: 2.6.4 Build problem
Message-ID: <20040329233653.GQ3445@bakeyournoodle.com>
Mail-Followup-To: J <summer@computerdatasafe.com.au>,
	Linux-Kernel@vger.kernel.org
References: <200403300623.51990.acpi@computerdatasafe.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403300623.51990.acpi@computerdatasafe.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 06:23:51AM +0800, J wrote:
> I did this:
> untar ... # unpack 2.2.2

I guess you meant 2.6.2 :)

<snip>
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x435e1): In function `ibmasm_register_uart':
> : undefined reference to `register_serial'
> drivers/built-in.o(.text+0x43649): In function `ibmasm_unregister_uart':
> : undefined reference to `unregister_serial'
> make: *** [.tmp_vmlinux1] Error 1
> summer@Dolphin:~/pebble/kernel/linux-2.6.4$

those symbols are exported from the 8250 driver, so in the shortterm use
*config to set that to y and you should be happy.

I don't know it it's correct but it seems to me that there should be a
kbuild dependancy here.

################################################################################
--- 2.6.4.clean/drivers/misc/Kconfig	2004-03-11 17:57:23.000000000 +1100
+++ 2.6.4.noconfig/drivers/misc/Kconfig	2004-03-30 09:32:07.000000000 +1000
@@ -6,7 +6,7 @@
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
-	depends on X86
+	depends on X86 && SERIAL_8250
 	default n
 	---help---
 	  This option enables device driver support for in-band access to the
################################################################################

Yours Tony

        linux.conf.au       http://lca2005.linux.org.au/
	Apr 18-23 2005      The Australian Linux Technical Conference!

