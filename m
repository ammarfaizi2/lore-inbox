Return-Path: <linux-kernel-owner+w=401wt.eu-S932867AbXASCzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbXASCzt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 21:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbXASCzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 21:55:49 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:62032 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864AbXASCzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 21:55:48 -0500
X-Greylist: delayed 3608 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 21:55:48 EST
Date: Thu, 18 Jan 2007 17:55:28 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: [BUG] 2.6.20-rc4-mm1: Panic in e1000_write_vfta_82543()
In-reply-to: <20070119011740.GA7658@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Message-id: <45B02510.7050604@intel.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <20070119011740.GA7658@us.ibm.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sukadev Bhattiprolu wrote:
> I get following panic on 2.6.20-rc4-mm1 on a 2-cpu AMD Opteron system.
> 
> Same basic config file seems to work with 2.6.20-rc2-mm1 on this same
> system. Have not tried -rc3-mm1 yet.
> 
> Attached are config file and "lspci -vv" output. Let me know if you need
> more info.
> 
> Suka
> 
> ---
> 
> [  168.925840] Freeing unused kernel memory: 320k freed
>  * INIT: version 2.86 booting
>  * Starting basic networking...                                          [ ok ]
>  * Starting kernel event manager...                                      [ ok ]
>  * Loading hardware drivers...                                           [ ok ]
>  * Starting PCMCIA services... * PCMCIA not present
>  * Loading manual drivers...                                             [ ok ]
> [  171.575122] Unable to handle kernel paging request at ffffc20100ec55fc RIP:
> [  171.584632]  [<ffffffff804a9858>] e1000_write_vfta_82543+0x58/0xd0
> [  171.614833] PGD 114e067 PUD 0
> [  171.633943] Oops: 0000 [1] PREEMPT SMP
> [  171.654614] last sysfs file: /devices/pci0000:00/0000:00:06.0/0000:01:06.0/host0/target0:0:0/0:0:0:0/rev
> [  171.698158] CPU 1
> [  171.698161] Modules linked in:
> [  171.698164] Pid: 2173, comm: ifconfig Not tainted 2.6.20-rc4-mm1 #1
>  * Checking root[  171.698166] RIP: 0010:[<ffffffff804a9858>]  [<ffffffff804a9858>] e1000_write_vfta_82543+0x58/0xd0
>  file system...[  171.698171] RSP: 0018:ffff81007dfc5cf8  EFLAGS: 00010286
> [  171.698174] RAX: ffffc20100ec55fc RBX: ffff81003e4c8948 RCX: 0000000000000000
> /dev/shm/root: clean, 662056/2443200 files, 3121107/4883752 bloc[  171.698176] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff81003e4c8948
> ks
>                                                                          [ ok ]
> [  171.698178] RBP: 0000000000000000 R08: 0000000000000010 R09: 0000000000000000
> [  171.698181] R10: 0000000000000002 R11: ffffffff804a9800 R12: ffffc20000ec0000
> [  171.698183] R13: 00000000fffffffc R14: 0000000000000000 R15: ffff81003e4c8000
>  * Setting up LVM Volume Groups...[  171.698186] FS:  00002ab17ce3f6d0(0000) GS:ffff81007f0b0bc0(0000) knlGS:0000000000000000
> [  171.698188] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  171.698191] CR2: ffffc20100ec55fc CR3: 000000007d828000 CR4: 00000000000006e0
> [  171.698194] Process ifconfig (pid: 2173, threadinfo ffff81007dfc4000, task ffff81007dd957e0)
> [  171.698196] Stack:  0000000000008000 ffff81003e4c8680 ffffc20000ec0000 ffff81003e4c8000
> [  171.698202]  00007fff2dfba960 ffffffff804c103d ffff81003e4c8680 0000000000000000
> [  171.698205]  ffff81003e4c8680 0000000000000000 0000000000000000 ffffffff804c3195
> [  171.698208] Call Trace:
> [  171.698216]  [<ffffffff804c103d>] e1000_vlan_rx_register+0x1dd/0x210
> [  171.698219]  [<ffffffff804c3195>] e1000_up+0x35/0x4b0
> [  171.698222]  [<ffffffff804c3724>] e1000_open+0x74/0x100
> [  171.698227]  [<ffffffff805626fe>] dev_open+0x3e/0xa0
> [  171.698230]  [<ffffffff8056184f>] dev_change_flags+0x6f/0x160
> [  171.698234]  [<ffffffff805a5174>] devinet_ioctl+0x2d4/0x6e0
> [  171.698238]  [<ffffffff803f7e01>] __up_read+0x21/0xb0
> [  171.698243]  [<ffffffff8055664c>] sock_ioctl+0x1fc/0x230
> [  171.698247]  [<ffffffff8029dc0f>] do_ioctl+0x2f/0xa0
> [  171.698249]  [<ffffffff8029df3b>] vfs_ioctl+0x2bb/0x2f0
> [  171.698252]  [<ffffffff8029dfb9>] sys_ioctl+0x49/0x80
> [  171.698256]  [<ffffffff805e375d>] error_exit+0x0/0x84
> [  171.698259]  [<ffffffff802098be>] system_call+0x7e/0x83
> [  171.698261]
> [  171.698262]
> [  171.698262] Code: 44 8b 20 e8 30 7e 00 00 83 bb 94 01 00 00 03 75 3c 83 e5 01
> [  171.698268] RIP  [<ffffffff804a9858>] e1000_write_vfta_82543+0x58/0xd0
> [  171.698273]  RSP <ffff81007dfc5cf8>
> [  171.698274] CR2: ffffc20100ec55fc
> [  171.698276]  <6>EXT3 FS on sda1, internal journal

Hi,

I believe this is one of the bugs that is fixed in the patch that I sent monday. Please 
try again with the patch applied to your tree and re-test. Thanks. I didn't see Andrew 
merge the patch yet.

see: http://lkml.org/lkml/2007/1/16/226

I can mail the patch if you can't find it. Just ping me privately.

Cheers,

Auke
