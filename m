Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270566AbRHITk5>; Thu, 9 Aug 2001 15:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270568AbRHITks>; Thu, 9 Aug 2001 15:40:48 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:27150 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270566AbRHITkg>; Thu, 9 Aug 2001 15:40:36 -0400
Message-ID: <20010809195605.B25162@bug.ucw.cz>
Date: Thu, 9 Aug 2001 19:56:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>,
        linux-kernel@vger.kernel.org,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: shutdown on pressing the ATX power button
In-Reply-To: <865464921.20010309170338@turbolinux.com.cn> <Pine.LNX.4.33.0108081344340.753-100000@fb07-calculator.math.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.33.0108081344340.753-100000@fb07-calculator.math.uni-giessen.de>; from Sergei Haller on Wed, Aug 08, 2001 at 01:52:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> is there any way to let the system execute something by pressing the ATX
> power button (preferrable executing 'shutdown -h now', but would be nice
> if it was configurable)
> 
> I looked into the (very large) list archive but didnt find any answer.
> if it is a kind of FAQ or off topic, please point me to the place I could
> find an answer.

Try this, and put this: into inittab

# Action on special keypress (ALT-UpArrow)
kb::kbrequest:/etc/rc/rc.reboot 2 0

--- clean/drivers/acpi/events/evevent.c	Sun Jul  8 23:26:27 2001
+++ linux/drivers/acpi/events/evevent.c	Sun Jul  8 23:25:01 2001
@@ -193,6 +168,8 @@
 
 	if ((status_register & ACPI_STATUS_POWER_BUTTON) &&
 		(enable_register & ACPI_ENABLE_POWER_BUTTON)) {
+                printk ("acpi: Power button pressed!\n");
+                kill_proc (1, SIGWINCH, 1);
 		int_status |= acpi_ev_fixed_event_dispatch (ACPI_EVENT_POWER_BUTTON);
 	}
 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
