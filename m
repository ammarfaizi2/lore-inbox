Return-Path: <linux-kernel-owner+w=401wt.eu-S932852AbWLSRo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbWLSRo6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932859AbWLSRo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:44:58 -0500
Received: from mga06.intel.com ([134.134.136.21]:1147 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932852AbWLSRo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:44:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,187,1165219200"; 
   d="scan'208"; a="176406183:sNHT31663170"
Subject: 2.6.19-rt14 e1000 shutdown problem
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Intel
Date: Tue, 19 Dec 2006 08:54:39 -0800
Message-Id: <1166547279.28359.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

While trying out the 2.6.19.1-rt14 kernel with a 
x86_64 system with Clovertown processor, it hung when it 
was shutting down e1000 ethernet interface running the command:

/sbin/ip link set dev eth0 down

Same problem was also seen for 2.6.19.1-rt15.  The default 
kernel from your RPM was used. Sysreq was still working and 
call trace of the ip command using Sysreq-prtscr-t is listed below:

ip   D [ffff810139201040] ffff81013fe47840    0  3526 3433
(NOTLB)
 ffff81012ce75ba8 0000000000000086 0000000000000007 0000000000000297
 00000000000c4994 ffff810139201278 ffff810139201040 ffff81013fe47800
 0000005681bed269 0000000400000080 ffff81013fe47800 00000004802df143
Call Trace:
 [<ffffffff80265da0>] schedule+0xd8/0xfc
 [<ffffffff802a0bab>] flush_cpu_workqueue+0x72/0xa7
 [<ffffffff802a0e13>] flush_workqueue+0x59/0x81
 [<ffffffff802a0f79>] schedule_on_each_cpu+0xe6/0xfd
 [<ffffffff802e33ca>] filevec_add_drain_all+0x12/0x14
 [<ffffffff8030bb38>] remove_proc_entry+0xaf/0x25a
 [<ffffffff802c720d>] unregister_handler_proc+0x43/0x48
 [<ffffffff802c56c4>] free_irq+0xdd/0x117
 [<ffffffff88133101>] :e1000:e1000_free_irq+0x22/0x3b
 [<ffffffff88135c88>] :e1000:e1000_close+0x4d/0xb9
 [<ffffffff80429735>] dev_close+0x5b/0x7c
 [<ffffffff80429ab9>] dev_change_flags+0x64/0x139
 [<ffffffff8046048b>] devinet_ioctl+0x252/0x5e1
 [<ffffffff80460ac1>] inet_ioctl+0x71/0x8f
 [<ffffffff80422042>] sock_ioctl+0x1d7/0x1ff
 [<ffffffff802433b8>] do_ioctl+0x27/0x74
 [<ffffffff80231339>] vfs_ioctl+0x263/0x280
 [<ffffffff8024dfb7>] sys_ioctl+0x5f/0x82
 [<ffffffff8026042c>] tracesys+0x151/0x1c5
 [<0000003055ac6267>]   

Tim                      
