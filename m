Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264521AbUDTWUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbUDTWUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbUDTWT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:19:26 -0400
Received: from [202.65.75.150] ([202.65.75.150]:58586 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S264534AbUDTVKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:10:39 -0400
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 21 Apr 2004 05:01:11 +0800
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Kconfig dependancy update for drivers/misc/ibmasm
Message-ID: <20040420210110.GD3445@bakeyournoodle.com>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
	Some weeks ago I saw this compile error posted to lkml:

---
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x435e1): In function `ibmasm_register_uart':
> : undefined reference to `register_serial'
> drivers/built-in.o(.text+0x43649): In function `ibmasm_unregister_uart':
> : undefined reference to `unregister_serial'
> make: *** [.tmp_vmlinux1] Error 1
> summer@Dolphin:~/pebble/kernel/linux-2.6.4$
---

This was created because ibmasm was set to yes BUT the 8250 was a
module.  I believe the correct (tested) fix is below.

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

Yours Tony

        linux.conf.au       http://lca2005.linux.org.au/
	Apr 18-23 2005      The Australian Linux Technical Conference!

