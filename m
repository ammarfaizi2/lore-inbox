Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUGVJEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUGVJEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUGVJEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:04:16 -0400
Received: from univ.uniyar.ac.ru ([193.233.51.120]:48383 "EHLO
	univ.uniyar.ac.ru") by vger.kernel.org with ESMTP id S266846AbUGVJCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:02:55 -0400
Date: Thu, 22 Jul 2004 13:02:12 +0400 (MSD)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: linux-kernel@vger.kernel.org
Subject: [BUG?] Console driver name in 2.4.26 in /proc/devices without devfs.
Message-ID: <Pine.GSO.3.96.SK.1040722125802.1156A-100000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I am running Linux-2.4.26 without devfs.

And I see this in /proc/devices:

Character devices:
...
  4 vc/%d
...

You can see following in drivers/char/console.c in con_init ():
	console_driver.magic = TTY_DRIVER_MAGIC;
	console_driver.name = "vc/%d";
	console_driver.name_base = 1;
	console_driver.major = TTY_MAJOR;

I suggest:
	console_driver.magic = TTY_DRIVER_MAGIC;
#ifdef CONFIG_DEVFS_FS
	console_driver.name = "vc/%d";
#else
	console_driver.name = "vc";
#endif
	console_driver.name_base = 1;
	console_driver.major = TTY_MAJOR;

Thank you!

