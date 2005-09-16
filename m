Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbVIPJrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbVIPJrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 05:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbVIPJrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 05:47:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161148AbVIPJru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 05:47:50 -0400
Date: Fri, 16 Sep 2005 02:47:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Roger Heflin" <rheflin@atipa.com>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Machine does not find AT keyboard with 2.6.13.1
Message-Id: <20050916024710.6a74efed.akpm@osdl.org>
In-Reply-To: <EXCHG2003lkDTM9wGmA0000084b@EXCHG2003.microtech-ks.com>
References: <EXCHG2003lkDTM9wGmA0000084b@EXCHG2003.microtech-ks.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Roger Heflin" <rheflin@atipa.com> wrote:
>
> I have an older machine that fails to find the AT keyboard.   The machine is
>  based
>  on an Intel 7501 chipset.
> 
>  Under the default fedora core 4 kernel, it found the keyboard and that
>  keyboard
>  worked in UP mode, in SMP mode the machine crashed, but that is a different
>  issue.
> 
>  Under 2.6.13.1 the machine boots under SMP and does not crash, dmesg does
>  not report
>  the keyboard being found, and the keyboard fails to work.  The .config file
>  does have
>  CONFIG_KEYBOARD_ATKBD set to Y.   The keyboard was being found was seen on
>  the default
>  fedora core 4 kernel.   There are no extra options on the boot cmdline.
> 
>  The important messages seem to be:
> 
>  Fedora Core 4 default UP kernel boot:
>  Sep 15 19:55:12 node001 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
>  Sep 15 19:55:12 node001 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
>  Sep 15 19:55:12 node001 kernel: input: AT Translated Set 2 keyboard on
>  isa0060/serio0
> 
>  New boot (2.6.13.1 smp boot)
>  Sep 15 21:12:35 node001 kernel: i8042.c: Can't read CTR while initializing
>  i8042.
> 
>  The i8042 is of course missing out of /proc/interrupts on the new boot.

That I8042_CMD_CTL_WCTR write-and-test seems to be new.  Can you try taking
it out?

--- devel/drivers/input/serio/i8042.c~a	2005-09-16 02:45:02.000000000 -0700
+++ devel-akpm/drivers/input/serio/i8042.c	2005-09-16 02:46:51.000000000 -0700
@@ -305,11 +305,6 @@ static int i8042_activate_port(struct i8
 
 	i8042_ctr |= port->irqen;
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		i8042_ctr &= ~port->irqen;
-		return -1;
-	}
-
 	return 0;
 }
 
_

