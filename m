Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbTGJB5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 21:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbTGJB4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 21:56:31 -0400
Received: from devil.servak.biz ([209.124.81.2]:9448 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S268737AbTGJB41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 21:56:27 -0400
Subject: 1394 / SBP2 OOPS on unplugging / replugging, 2.5.74-bk5
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057803062.3549.38.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 19:11:02 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.5.74-bk5 with Red Hat 9.  

I powered down my firewire CD-ROM, and then mistakenly unplugged the
(mounted) firewire hard drive data cable. 

I immediately plugged the hard drive in again, and got this:

Jul  9 19:01:35 torrey kernel: ieee1394: sbp2: Reconnected to SBP-2 device
Jul  9 19:01:35 torrey kernel: ieee1394: sbp2: sbp2_set_busy_timeout error
Jul  9 19:01:35 torrey kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
Jul  9 19:01:36 torrey kernel: ieee1394: ConfigROM quadlet transaction error for node 01:1023
Jul  9 19:01:37 torrey kernel: ieee1394: sbp2: Logged out of SBP-2 device
Jul  9 19:01:37 torrey /sbin/hotplug: no runnable /etc/hotplug/scsi_device.agent is installed
Jul  9 19:01:37 torrey /sbin/hotplug: no runnable /etc/hotplug/scsi.agent is installed
Jul  9 19:01:38 torrey kernel: ieee1394: sbp2: Reconnected to SBP-2 device
Jul  9 19:01:38 torrey kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
Jul  9 19:01:39 torrey devlabel: devlabel service started/restarted
Jul  9 19:01:57 torrey /sbin/hotplug: no runnable /etc/hotplug/scsi_device.agent is installed
Jul  9 19:01:57 torrey kernel: ieee1394: sbp2: Logged out of SBP-2 device
Jul  9 19:01:58 torrey /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Jul  9 19:01:58 torrey /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Jul  9 19:01:58 torrey /sbin/hotplug: no runnable /etc/hotplug/scsi.agent is installed
Jul  9 19:01:59 torrey devlabel: devlabel service started/restarted
Jul  9 19:02:06 torrey /etc/hotplug/ieee1394.agent: Setup sbp2 for IEEE1394 product 0x000000/0x00609e/0x010483
Jul  9 19:02:06 torrey kernel: ieee1394: sbp2: Logged into SBP-2 device
Jul  9 19:02:06 torrey kernel: ieee1394: sbp2: Node[01:1023]: Max speed [S400] - Max payload [2048]
Jul  9 19:02:06 torrey kernel:   Vendor: Maxtor 4  Model: A250J8            Rev:     
Jul  9 19:02:06 torrey kernel:   Type:   Direct-Access                      ANSI SCSI revision: 06
Jul  9 19:02:06 torrey kernel: SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
Jul  9 19:02:06 torrey kernel: sda: asking for cache data failed
Jul  9 19:02:06 torrey kernel: sda: assuming drive cache: write through
Jul  9 19:02:06 torrey kernel: Unable to handle kernel paging request at virtual address 736563d1
Jul  9 19:02:06 torrey kernel:  printing eip:
Jul  9 19:02:06 torrey kernel: ec8d1a5b
Jul  9 19:02:06 torrey kernel: *pde = 00000000
Jul  9 19:02:06 torrey kernel: Oops: 0000 [#1]
Jul  9 19:02:06 torrey kernel: CPU:    0
Jul  9 19:02:06 torrey kernel: EIP:    0060:[<ec8d1a5b>]    Not tainted
Jul  9 19:02:06 torrey kernel: EFLAGS: 00010286
Jul  9 19:02:06 torrey kernel: EIP is at scsi_device_get+0xb/0x40 [scsi_mod]
Jul  9 19:02:06 torrey kernel: eax: e7c1c4e0   ebx: c1707300   ecx: 00000001   edx: 73656369
Jul  9 19:02:06 torrey kernel: esi: 73656369   edi: e63d3ca0   ebp: e66c5a1c   esp: e66c5a1c
Jul  9 19:02:06 torrey kernel: ds: 007b   es: 007b   ss: 0068
Jul  9 19:02:06 torrey /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Jul  9 19:02:06 torrey kernel: Process knodemgrd_0 (pid: 339, threadinfo=e66c4000 task=e750b8c0)
Jul  9 19:02:06 torrey kernel: Stack: e66c5a38 ec89b329 73656369 c0213c42 c1707300 ec89b300 ec89dc80 e66c5a78 
Jul  9 19:02:06 torrey kernel:        c015272a e6457ae0 e66c5b2c 00000592 c100ded0 00000000 c02efdd4 00000000 
Jul  9 19:02:06 torrey kernel:        e66c5a7c c1707318 c02efd00 00000000 c1707300 00000001 e66c5b2c e66c5bb4 
Jul  9 19:02:06 torrey kernel: Call Trace:
Jul  9 19:02:06 torrey kernel:  [<ec89b329>] sd_open+0x29/0x100 [sd_mod]
Jul  9 19:02:06 torrey kernel:  [<c0213c42>] get_gendisk+0x22/0x40
Jul  9 19:02:06 torrey kernel:  [<ec89b300>] sd_open+0x0/0x100 [sd_mod]
Jul  9 19:02:06 torrey kernel:  [<c015272a>] do_open+0x2ea/0x320
Jul  9 19:02:06 torrey kernel:  [<c01527c5>] blkdev_get+0x65/0x70
Jul  9 19:02:06 torrey kernel:  [<c0175b54>] register_disk+0xb4/0x150
Jul  9 19:02:06 torrey kernel:  [<c0213bd1>] add_disk+0x51/0x60
Jul  9 19:02:06 torrey kernel:  [<c0213b50>] exact_match+0x0/0x10
Jul  9 19:02:06 torrey kernel:  [<c0213b60>] exact_lock+0x0/0x20
Jul  9 19:02:06 torrey kernel:  [<ec89c83b>] sd_probe+0x19b/0x260 [sd_mod]
Jul  9 19:02:06 torrey kernel:  [<c01c66af>] sprintf+0x1f/0x30
Jul  9 19:02:06 torrey kernel:  [<c020cd73>] bus_match+0x43/0x80
Jul  9 19:02:06 torrey kernel:  [<c020cdff>] device_attach+0x4f/0x90
Jul  9 19:02:06 torrey kernel:  [<c020cfb3>] bus_add_device+0x63/0xb0
Jul  9 19:02:06 torrey kernel:  [<c020b65f>] device_add+0xcf/0x100
Jul  9 19:02:06 torrey kernel:  [<ec8d7690>] scsi_device_release+0x0/0x20 [scsi_mod]
Jul  9 19:02:06 torrey kernel:  [<ec8d7794>] scsi_device_register+0xe4/0x180 [scsi_mod]
Jul  9 19:02:06 torrey kernel:  [<ec8d6c4b>] scsi_add_lun+0x2cb/0x390 [scsi_mod]
Jul  9 19:02:07 torrey kernel:  [<ec8d6db7>] scsi_probe_and_add_lun+0xa7/0x120 [scsi_mod]
Jul  9 19:02:07 torrey kernel:  [<ec8d6f35>] scsi_add_device+0x35/0x50 [scsi_mod]
Jul  9 19:02:07 torrey /sbin/hotplug: no runnable /etc/hotplug/scsi.agent is installed
Jul  9 19:02:07 torrey kernel:  [<ec8aaa09>] sbp2_start_device+0x219/0x3e0 [sbp2]
Jul  9 19:02:07 torrey kernel:  [<ec8aa7b3>] sbp2_start_ud+0xa3/0xe0 [sbp2]
Jul  9 19:02:07 torrey kernel:  [<ec8aa482>] sbp2_probe+0x32/0x40 [sbp2]
Jul  9 19:02:07 torrey kernel:  [<c020cd73>] bus_match+0x43/0x80
Jul  9 19:02:07 torrey kernel:  [<c020cdff>] device_attach+0x4f/0x90
Jul  9 19:02:07 torrey kernel:  [<c020cfb3>] bus_add_device+0x63/0xb0
Jul  9 19:02:07 torrey kernel:  [<c020b65f>] device_add+0xcf/0x100
Jul  9 19:02:07 torrey kernel:  [<ec8c57e8>] nodemgr_process_unit_directory+0x188/0x490 [ieee1394]
Jul  9 19:02:07 torrey kernel:  [<ec8c5cd2>] nodemgr_process_root_directory+0x1e2/0x1f0 [ieee1394]
Jul  9 19:02:07 torrey kernel:  [<ec8c5fbe>] nodemgr_process_config_rom+0x8e/0xc0 [ieee1394]
Jul  9 19:02:07 torrey kernel:  [<ec8c5273>] nodemgr_create_node+0x153/0x1e0 [ieee1394]
Jul  9 19:02:07 torrey kernel:  [<ec8c6416>] nodemgr_node_probe_one+0xe6/0xf0 [ieee1394]
Jul  9 19:02:07 torrey kernel:  [<ec8c6571>] nodemgr_node_probe+0x111/0x120 [ieee1394]
Jul  9 19:02:07 torrey kernel:  [<ec8c6878>] nodemgr_host_thread+0x118/0x180 [ieee1394]
Jul  9 19:02:07 torrey kernel:  [<ec8c6760>] nodemgr_host_thread+0x0/0x180 [ieee1394]
Jul  9 19:02:07 torrey kernel:  [<c0109139>] kernel_thread_helper+0x5/0xc
Jul  9 19:02:07 torrey kernel: 
Jul  9 19:02:07 torrey kernel: Code: 8b 42 68 8b 40 44 8b 00 85 c0 74 0b 83 38 02 74 19 ff 80 a0 
Jul  9 19:02:07 torrey devlabel: devlabel service started/restarted


-- 
Torrey Hoffman <thoffman@arnor.net>

