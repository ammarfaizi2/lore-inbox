Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWDRN56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWDRN56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWDRN56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:57:58 -0400
Received: from mail1-new.vianetworks.nl ([212.61.9.28]:53519 "EHLO
	mail1-new.vianetworks.nl") by vger.kernel.org with ESMTP
	id S932079AbWDRN56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:57:58 -0400
Message-ID: <4444F060.1090503@vianetworks.nl>
Date: Tue, 18 Apr 2006 15:57:52 +0200
From: Axel Scheepers <ascheepers@vianetworks.nl>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: ascheepers@vianetworks.nl
Subject: oops at reboot/shutdown in device_shutdown
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi All,

I don't know if this is the right list to report this, if not excuse me
for posting.
Since kernel 2.6.16 I experience panics on reboot/shutdown in
device_shutdown on my dell laptop (pentium-m).

I've fixed this by commenting all references to device_shutdown in
kernel/sys.c which solves the problem for me, strange thing however is
that this machine is the only one I can reproduce this, both a dual
athlon and several pentium III machines run fine with the latest 2.6.16.7

Here's the patch to fix it in case someone else experiences the same
problems but I wonder what could cause this and if disabling
device_shutdown as I did could cause any problems?
(I'm not subscribed to this list, please Cc me)

Patch:
- --- sys.c       2006-04-18 15:55:09.858532000 +0200
+++ ../linux/kernel/sys.c       2006-04-18 15:10:22.768255500 +0200
@@ -394,7 +394,9 @@
 {
        notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
        system_state = SYSTEM_RESTART;
+        /* don't shutdown devices
        device_shutdown();
+        */
 }

 /**
@@ -445,7 +447,9 @@
        notifier_call_chain(&reboot_notifier_list,
                (state == SYSTEM_HALT)?SYS_HALT:SYS_POWER_OFF, NULL);
        system_state = state;
+        /* don't shutdown devices
        device_shutdown();
+        */
 }
 /**
  *     kernel_halt - halt the system

- --- [snip] ---


Kind regards,

Axel Scheepers


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFERPBgvOFCXiGjP+ARAmGbAJ9tCuRYDXX02GB2i8+mGKD6Lism4gCfaBUo
kjbteBLY0PCt1+pMLne4X3I=
=T42q
-----END PGP SIGNATURE-----
