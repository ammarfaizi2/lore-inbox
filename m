Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWGISQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWGISQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 14:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWGISQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 14:16:34 -0400
Received: from mail.gmx.de ([213.165.64.21]:56996 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932260AbWGISQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 14:16:34 -0400
X-Authenticated: #14349625
Subject: 2.6.18-rc1-mm1:  /sys/class/net/ethN becoming symlink befuddled
	/sbin/ifup
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 20:22:09 +0200
Message-Id: <1152469329.9254.15.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

As $subject says, up-to-date SuSE 10.0 /sbin/ifup became confused...

-[pid  8191] lstat64("/sys/class/net/eth1", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
-[pid  8191] lstat64("/sys/block/eth1", 0xafec0f9c) = -1 ENOENT (No such file or directory)

...and wandered off into lala-land.

It used to do...

+[pid  8905] lstat64("/sys/class/net/eth1", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
+[pid  8905] readlink("/sys/class/net/eth1/device", "../../../devices/pci0000:00/0000:00:1e.0/0000:02:09.0", 255) = 53
+[pid  8905] readlink("/sys/class/net/eth1/device", "../../../devices/pci0000:00/0000:00:1e.0/0000:02:09.0", 255) = 53

...and made working network interface.

	-Mike

