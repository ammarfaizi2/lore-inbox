Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284638AbRLIXaU>; Sun, 9 Dec 2001 18:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284645AbRLIXaB>; Sun, 9 Dec 2001 18:30:01 -0500
Received: from hermes.toad.net ([162.33.130.251]:64973 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S284638AbRLIX3t>;
	Sun, 9 Dec 2001 18:29:49 -0500
Subject: USB not processing APM suspend event properly?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Dec 2001 18:31:05 -0500
Message-Id: <1007940667.930.6.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following syslog fragment shows what happens when
I suspended earlier today.  The USB subsystem disconnected
my USB mouse, but then tried (twice) to reconnect it again
while the apm driver was still processing the suspend.  The
attempts to reconnect failed.  I presume there is something
wrong with this picture.  Does this indicate a bug in
USB power management?

(The repeated "received system suspend notify" messages are
there because I have apm debug messages switch on, and I
am using a ThinkPad, which generates repeated suspend
events.)

Dec  9 17:38:27 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:27 thanatos kernel: usb.c: USB disconnect on device 4
Dec  9 17:38:27 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:27 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:27 thanatos kernel: hub.c: USB new device connect on
bus1/1, assigned device number 5
Dec  9 17:38:28 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:30 thanatos last message repeated 2 times
Dec  9 17:38:30 thanatos kernel: usb_control/bulk_msg: timeout
Dec  9 17:38:30 thanatos kernel: usb.c: USB device not accepting new
address=5 (error=-110)
Dec  9 17:38:31 thanatos kernel: hub.c: USB new device connect on
bus1/1, assigned device number 6
Dec  9 17:38:31 thanatos kernel: apm: setting state busy
Dec  9 17:38:31 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:33 thanatos last message repeated 2 times
Dec  9 17:38:34 thanatos kernel: usb_control/bulk_msg: timeout
Dec  9 17:38:34 thanatos kernel: usb.c: USB device not accepting new
address=6 (error=-110)
Dec  9 17:38:34 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:35 thanatos kernel: apm: received system suspend notify
Dec  9 17:38:36 thanatos kernel: apm: setting state busy


