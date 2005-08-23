Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVHWLc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVHWLc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVHWLc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:32:59 -0400
Received: from tornado.reub.net ([202.89.145.182]:22979 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932136AbVHWLc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:32:58 -0400
Message-ID: <430B0964.8060502@reub.net>
Date: Tue, 23 Aug 2005 23:32:52 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050822)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm2
References: <20050822213021.1beda4d5.akpm@osdl.org>
In-Reply-To: <20050822213021.1beda4d5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/08/2005 4:30 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm2/
> 
> - Various updates.  Nothing terribly noteworthy.

Yup, seems to be generally good...

Noticed this in the log earlier tonight:

Aug 23 19:44:51 tornado kernel: hub 5-0:1.0: port 1 disabled by hub (EMI?), 
re-enabling...
Aug 23 19:44:51 tornado kernel: usb 5-1: USB disconnect, address 2
Aug 23 19:44:51 tornado kernel: drivers/usb/class/usblp.c: usblp0: removed
Aug 23 19:44:51 tornado kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Aug 23 19:44:51 tornado kernel:  printing eip:
Aug 23 19:44:51 tornado kernel: c01ccef2
Aug 23 19:44:51 tornado kernel: *pde = 00000000
Aug 23 19:44:51 tornado kernel: Oops: 0000 [#1]
Aug 23 19:44:51 tornado kernel: SMP
Aug 23 19:44:51 tornado kernel: last sysfs file: 
/devices/pci0000:00/0000:00:1f.3/i2c-0/name
Aug 23 19:44:51 tornado kernel: Modules linked in: nfsd exportfs lockd eeprom 
sunrpc ipv6 iptable_filter binfmt_misc reiser4 zlib_de
flate zlib_inflate dm_mod video thermal processor fan button ac tpm_nsc 
i2c_i801 sky2 e100 sr_mod
Aug 23 19:44:51 tornado kernel: CPU:    1
Aug 23 19:44:51 tornado kernel: EIP:    0060:[<c01ccef2>]    Not tainted VLI
Aug 23 19:44:51 tornado kernel: EFLAGS: 00010286   (2.6.13-rc6-mm2)
Aug 23 19:44:51 tornado kernel: EIP is at _raw_spin_lock+0x7/0x73
Aug 23 19:44:51 tornado kernel: eax: 00000000   ebx: 00000000   ecx: c1a60658 
   edx: c1a63e24
Aug 23 19:44:51 tornado kernel: esi: 00000000   edi: c0382400   ebp: f7c55e98 
   esp: f7c55e90
Aug 23 19:44:51 tornado kernel: ds: 007b   es: 007b   ss: 0068
Aug 23 19:44:51 tornado kernel: Process khubd (pid: 109, threadinfo=f7c54000 
task=c192b030)
Aug 23 19:44:51 tornado kernel: Stack: f7c58a8c 00000000 f7c55ea0 c0312219 
f7c55eb0 c030feb7 f7c58ae8 f7c58a48
Aug 23 19:44:51 tornado kernel:        f7c55ec4 c0217e73 f7c58a48 f7d134ec 
00000040 f7c55ed0 c0217ec0 f7c58a48
Aug 23 19:44:51 tornado kernel:        f7c55edc c0217814 f7c58a48 f7c55eec 
c0216ad2 f7c58a48 f7c58a14 f7c55ef8
Aug 23 19:44:51 tornado kernel: Call Trace:
Aug 23 19:44:51 tornado kernel:  [<c01039c3>] show_stack+0x94/0xca
Aug 23 19:44:51 tornado kernel:  [<c0103b6c>] show_registers+0x15a/0x1ea
Aug 23 19:44:51 tornado kernel:  [<c0103d8a>] die+0x108/0x183
Aug 23 19:44:51 tornado kernel:  [<c031295a>] do_page_fault+0x1ea/0x63d
Aug 23 19:44:51 tornado kernel:  [<c0103693>] error_code+0x4f/0x54
Aug 23 19:44:51 tornado kernel:  [<c0312219>] _spin_lock+0x8/0xa
Aug 23 19:44:51 tornado kernel:  [<c030feb7>] klist_remove+0x10/0x2c
Aug 23 19:44:51 tornado kernel:  [<c0217e73>] __device_release_driver+0x41/0x65
Aug 23 19:44:51 tornado kernel:  [<c0217ec0>] device_release_driver+0x29/0x39
Aug 23 19:44:51 tornado kernel:  [<c0217814>] bus_remove_device+0x52/0x60
Aug 23 19:44:51 tornado kernel:  [<c0216ad2>] device_del+0x2e/0x5d
Aug 23 19:44:51 tornado kernel:  [<c0216b0c>] device_unregister+0xb/0x15
Aug 23 19:44:51 tornado kernel:  [<c0275d67>] usb_disconnect+0x115/0x15c
Aug 23 19:44:51 tornado kernel:  [<c0276b85>] hub_port_connect_change+0x54/0x399
Aug 23 19:44:51 tornado kernel:  [<c027713e>] hub_events+0x274/0x3b2
Aug 23 19:44:51 tornado kernel:  [<c0277296>] hub_thread+0x1a/0xdf
Aug 23 19:44:51 tornado kernel:  [<c012fba7>] kthread+0x99/0x9d
Aug 23 19:44:51 tornado kernel:  [<c01010b5>] kernel_thread_helper+0x5/0xb
Aug 23 19:44:51 tornado kernel: Code: 00 00 00 8b 0d a8 62 36 c0 e9 61 ff ff 
ff f3 90 31 c0 86 07 84 c0 0f 8e 79 ff ff ff 83 c4 18 5
b 5e 5f 5d c3 55 89 e5 56 53 89 c3 <81> 78 04 ad 4e ad de 75 2d be 00 e0 ff ff 
21 e6 8b 06 39 43 0c

reuben

