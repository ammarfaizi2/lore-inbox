Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUGURhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUGURhD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 13:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUGURhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 13:37:03 -0400
Received: from univ.uniyar.ac.ru ([193.233.51.120]:4285 "EHLO
	univ.uniyar.ac.ru") by vger.kernel.org with ESMTP id S263585AbUGURhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 13:37:00 -0400
Date: Wed, 21 Jul 2004 21:36:31 +0400 (MSD)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: linux-kernel@vger.kernel.org
Subject: Wrong console driver name in 2.4.26 in /proc/devices without devfs.
Message-ID: <Pine.GSO.3.96.SK.1040721213418.6280A-100000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I am running Linux-2.4.26-ow2 (OpenWall) without devfs.

And I have seen strange thing in /proc/devices:
--- Begin ---
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 vc/%d  /* *** Here! *** */
  5 tty
  7 vcs
 10 misc
 29 fb
128 ptm
136 pts
162 raw

Block devices:
  3 ide0
 22 ide1
--- End ---

You can see following in drivers/char/console.c in con_init ():
	console_driver.magic = TTY_DRIVER_MAGIC;
	console_driver.name = "vc/%d";
	console_driver.name_base = 1;
	console_driver.major = TTY_MAJOR;

Opposite to this you can see in drivers/char/hvc_console.c in hvc_init ():
	hvc_driver.magic = TTY_DRIVER_MAGIC;
	hvc_driver.driver_name = "hvc";
#ifdef CONFIG_DEVFS_FS
	hvc_driver.name = "hvc/%d";
#else
	hvc_driver.name = "hvc";
#endif
	hvc_driver.major = HVC_MAJOR;

So should console_driver.name assignment be surrounded
with #ifdef CONFIG_DEVFS_FS? And is its name "vc"?

And do you need to assign console_driver.driver_name?

Thank you!

