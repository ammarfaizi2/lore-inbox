Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUJFMz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUJFMz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269250AbUJFMz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:55:57 -0400
Received: from iua-mail.upf.es ([193.145.55.10]:60316 "EHLO iua-mail.upf.es")
	by vger.kernel.org with ESMTP id S269010AbUJFMzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:55:52 -0400
Date: Wed, 6 Oct 2004 14:55:46 +0200
From: Maarten de Boer <mdeboer@iua.upf.es>
To: linux-kernel@vger.kernel.org
Subject: Badness in enable_irq with 2.6.9-rc3-mm2-vp-t1
Message-Id: <20041006145546.1a611d27.mdeboer@iua.upf.es>
Organization: IUA-MTG
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.4.9; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MTG-MailScanner: Found to be clean
X-MTG-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-2.599, required 5, autolearn=disabled,
	BAYES_00 -2.60)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(Please Cc: me on reply - I am not on the list)

I decided to give the voluntary preempt patch a try, but I ran into some
problems. I share them with you, hoping to contribute in some way to the
process.

I decided to build my kernel the Debian way (make-kpkg), with the config
file from the 2.6.8 package as a starting point. In order to get it to
build, I had to disable:
CONFIG_SCSI_ADVANSYS
CONFIG_DVB_BT8XX
CONFIG_DRM_GAMMA
and set
CONFIG_4KSTACKS=y

When booting the new kernel, problems occur with the ethernet device
(e100), and, not surprisingly, networking fails. Any idea? The IRQ 177
looks rather strange to me...

Maarten

Oct  6 14:22:59 mtg62 kernel: requesting new irq thread for IRQ177...
Oct  6 14:22:59 mtg62 kernel: Badness in enable_irq at kernel/irq/manage.c:111
Oct  6 14:22:59 mtg62 kernel:  [enable_irq+259/272] enable_irq+0x103/0x110
Oct  6 14:22:59 mtg62 kernel:  [pg0+543215970/1069945856] e100_up+0x162/0x210 [e100]
Oct  6 14:22:59 mtg62 kernel:  [pg0+543212944/1069945856] e100_intr+0x0/0x140 [e100]
Oct  6 14:22:59 mtg62 kernel:  [pg0+543220636/1069945856] e100_open+0x2c/0x80 [e100]
Oct  6 14:22:59 mtg62 kernel:  [dev_open+133/160] dev_open+0x85/0xa0
Oct  6 14:22:59 mtg62 kernel:  [dev_mc_upload+36/80] dev_mc_upload+0x24/0x50
Oct  6 14:22:59 mtg62 kernel:  [dev_change_flags+83/304] dev_change_flags+0x53/0x130
Oct  6 14:22:59 mtg62 kernel:  [dev_load+37/112] dev_load+0x25/0x70
Oct  6 14:22:59 mtg62 kernel:  [devinet_ioctl+635/1712] devinet_ioctl+0x27b/0x6b0
Oct  6 14:22:59 mtg62 kernel:  [inet_ioctl+102/176] inet_ioctl+0x66/0xb0
Oct  6 14:22:59 mtg62 kernel:  [sock_ioctl+217/656] sock_ioctl+0xd9/0x290
Oct  6 14:22:59 mtg62 kernel:  [sys_ioctl+234/592] sys_ioctl+0xea/0x250
Oct  6 14:22:59 mtg62 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  6 14:22:59 mtg62 kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Oct  6 14:22:59 mtg62 kernel: IRQ#177 thread started up.


