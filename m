Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUIQFBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUIQFBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268455AbUIQFBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:01:46 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:49064 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268406AbUIQFBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:01:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/3] New input patches
Date: Thu, 16 Sep 2004 23:58:27 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409162358.27678.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have some more input patches that I would like you to review:

01-libps2.patch
        - move common code from atkbd and psmouse into one place, create
          ps2dev structure that should be used to build drivers for hardware
          attached to a PS/2 port.
          I think that command processing is now race free - instead of using
          bit operations on flags the ps2_command and ps2_send_byte simply
          take serio->lock (via serio_pause/continue_rx). Since serio->lock
          is also taken by interrupt handler anyway it gives us desired
          serialization. As wakeup routines take a spinlock as well and
          spinlock is guaranteed to be a barrier we should not miss wake up
          events either.

02-serio-pin-driver.patch
        - Add drv_sem to serio structure and implement serio_[un]pin_driver()
          functions. The main purpose is to pin a driver bound to serio port
          when accessing driver's data from sysfs attribute handler; otherwise
          other thread could unbind/unload driver in a middle of processing.

03-atkbd-sysfs-attr.patch
        - Export extra, scroll, set, softrepeat and softraw atkbd properties
          via sysfs and allow them to be controlled at run time, independently
          for each keyboard.

Now that Linus pulled all pending changes the patches should apply cleanly to
all trees (his, yours and Andrew's). 

Please let me know if they are ok and I will push them into my bkbits tree.

Thanks!

-- 
Dmitry
