Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbTBRWOD>; Tue, 18 Feb 2003 17:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268073AbTBRWOD>; Tue, 18 Feb 2003 17:14:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62225 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268071AbTBRWOB>; Tue, 18 Feb 2003 17:14:01 -0500
Date: Tue, 18 Feb 2003 23:24:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Toshiba keyboard workaroun
Message-ID: <20030218222402.GG21974@atrey.karlin.mff.cuni.cz>
References: <mailman.1045603384.24857.linux-kernel2news@redhat.com> <200302182213.h1IMDKX31357@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302182213.h1IMDKX31357@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> First, formatting does not respect the original code. Pavel, please,
> I do not care what crap you write in softsuspend, but this is a

Do you like this better?

								Pavel
PS: Oh, and, what crap in swsusp are you talking about?

--- clean/drivers/char/keyboard.c	2003-02-15 18:51:18.000000000 +0100
+++ linux/drivers/char/keyboard.c	2003-02-18 23:20:33.000000000 +0100
@@ -1020,6 +1041,26 @@
 	struct tty_struct *tty;
 	int shift_final;
 
+        /*
+         * Fix for Toshiba Satellites. Toshiba's like to repeat 
+	 * "key down" event for A in combinations like shift-A.
+	 * Thanx to Andrei Pitis <pink@roedu.net>.
+         */
+        static int prev_scancode = 0;
+        static int stop_jiffies = 0;
+
+        /* new scancode, trigger delay */
+        if (keycode != prev_scancode)
+		stop_jiffies = jiffies;
+        else 
+		if (time_after(jiffies, stop_jiffies + HZ/10))
+			prev_scancode = -1;
+        else {
+		printk( "Keyboard glitch detected, ignoring keypress\n" );
+		return;
+	}
+        prev_scancode = keycode;
+
 	if (down != 2)
 		add_keyboard_randomness((keycode << 1) ^ down);
 

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
