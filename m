Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUFUTtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUFUTtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 15:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266438AbUFUTtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 15:49:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:34752 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266435AbUFUTth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 15:49:37 -0400
X-Authenticated: #21910825
Message-ID: <40D73BA2.5080703@gmx.net>
Date: Mon, 21 Jun 2004 21:48:50 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
CC: LKML <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] new device support for forcedeth.c second try
References: <C064BF1617D93B4B83714E38C4653A6E0BD11BCF@mail-sc-10.nvidia.com> <40D71CBB.4090009@gmx.net> <40D73040.5010106@ThinRope.net>
In-Reply-To: <40D73040.5010106@ThinRope.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> 
> # modprobe -r forcedeth; ntp_check; modprobe forcedeth; ntp_check; dmesg
> -c; ntp_check; sleep 10; ntp_check
> 22 Jun 03:48:56 ntpdate[8310]: adjust time server 192.168.1.100 offset
> 0.000057 sec
> 22 Jun 03:48:57 ntpdate[8366]: adjust time server 192.168.1.100 offset
> 0.000057 sec
> eth1: phy init failed to autoneg.
> eth1: no link during initialization.
> eth1: no IPv6 routers present
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
> PCI: Setting latency timer of device 0000:00:04.0 to 64
> eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
> bad: scheduling while atomic!
> [<c03222fc>] schedule+0x47c/0x490
> [<c013920f>] __get_free_pages+0x1f/0x40
> [<c03227a3>] schedule_timeout+0x63/0xc0
> [<c0124b10>] process_timeout+0x0/0x10
> [<c0124eef>] msleep+0x1f/0x30
> [<e1f031b4>] phy_reset+0x64/0xc0 [forcedeth]
> [<e1f032a8>] phy_init+0x98/0x320 [forcedeth]
> [<e1f04b12>] nv_open+0x282/0x5d0 [forcedeth]
> [<c02bc4eb>] dev_open+0xcb/0x100
> [<c02c01d4>] dev_mc_upload+0x24/0x50
> [<c02bd9f1>] dev_change_flags+0x51/0x120
> [<c02bc375>] dev_load+0x25/0x70
> [<c02f93c6>] devinet_ioctl+0x246/0x560
> [<c02fb8fe>] inet_ioctl+0x5e/0xa0
> [<c02b4d09>] sock_ioctl+0xf9/0x2b0
> [<c01643fd>] sys_ioctl+0x10d/0x290
> [<c0106087>] syscall_call+0x7/0xb
> 
> eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
> 22 Jun 03:48:57 ntpdate[8406]: adjust time server 192.168.1.100 offset
> 0.000056 sec
> 22 Jun 03:49:07 ntpdate[8436]: adjust time server 192.168.1.100 offset
> 0.000067 sec
> 
> This time the trace is reproducible every time. This patch and the
> kmsgdump patch are the only ones applied to a stock 2.6.7
> Plugging a proper cable, just hides the three lines /^eth1:/

It seems that msleep is not the way to go here. I have to find a way to
move the PHY reset out of line.

> Please tell me if I can do something else to help debugging.

Does the driver work for you when a cable is plugged in? Please test
normal network traffic.

Thanks,
Carl-Daniel
-- 
http://www.hailfinger.org/
