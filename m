Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423072AbWJSRcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423072AbWJSRcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423100AbWJSRcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:32:47 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:13574 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1423083AbWJSRcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:32:45 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: jt@hpl.hp.com
Subject: Re: 2.6.19-rc2-mm1 // errors in verify_redzone_free()
Date: Thu, 19 Oct 2006 19:33:21 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
References: <20061016230645.fed53c5b.akpm@osdl.org> <20061019100342.4e4895fb.akpm@osdl.org> <20061019171727.GA9350@bougret.hpl.hp.com>
In-Reply-To: <20061019171727.GA9350@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191933.22320.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > The wireless ioctls are still blowing up?  I thought we'd fixed that,
> > or is this something new?
>
> 	Do you know which driver the user is using ? Is it an
> in-kernel driver, or an out-of-kernel driver ?
> 	Thanks !

The wifi card is Cabletron Entersys Roamabout and the driver is an orinoco 
driver that comes with vanilla kernel. Here is what lsmod says:

orinoco_cs             14340  1 
orinoco                38932  1 orinoco_cs
hermes                  6784  2 orinoco_cs,orinoco
pcmcia                 32176  5 orinoco_cs
firmware_class          8448  1 pcmcia
yenta_socket           24204  6 
rsrc_nonstatic         11776  1 yenta_socket
pcmcia_core            35616  4 orinoco_cs,pcmcia,yenta_socket,rsrc_nonstatic

And these are the relevant syslog lines:

orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin 
<proski@gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin 
<proski@gnu.org>, et al)
pcmcia: registering new device pcmcia1.0
eth0: Hardware identity 0001:0001:0004:0000
eth0: Station identity  001f:0001:0008:0048
eth0: Firmware determined as Lucent/Agere 8.72
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:E0:63:82:2D:3F
eth0: Station name "HERMES I"
eth0: ready
eth0: orinoco_cs at 1.0, irq 3, io 0x0100-0x013f
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f4e410>] 0xb7f4e410
 =======================
dd20cb64: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f4e410>] 0xb7f4e410
 =======================
dd20cb64: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f96410>] 0xb7f96410
 =======================
dd20cab4: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f96410>] 0xb7f96410
 =======================
dd20cab4: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f8a410>] 0xb7f8a410
 =======================
dd20cab4: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f8a410>] 0xb7f8a410
 =======================
dd20cab4: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
eth0: New link status: Connected (0001)
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7fa2410>] 0xb7fa2410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f2c410>] 0xb7f2c410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f2c410>] 0xb7f2c410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7eef410>] 0xb7eef410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7eef410>] 0xb7eef410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
slab error in verify_redzone_free(): cache `size-32': memory outside object 
was overwritten
 [<c0103765>] dump_trace+0x1c1/0x1f1
 [<c01037af>] show_trace_log_lvl+0x1a/0x30
 [<c0103ed8>] show_trace+0x12/0x14
 [<c0103f7b>] dump_stack+0x19/0x1b
 [<c0158357>] __slab_error+0x26/0x28
 [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
 [<c0158bb0>] kfree+0x54/0xa5
 [<c037fba4>] ioctl_standard_call+0x187/0x2a1
 [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
 [<c03763d4>] dev_ioctl+0x1fd/0x372
 [<c036b080>] sock_ioctl+0x34/0x1e8
 [<c0167a92>] do_ioctl+0x22/0x71
 [<c0167b36>] vfs_ioctl+0x55/0x29b
 [<c0167daf>] sys_ioctl+0x33/0x50
 [<c0102ff5>] sysenter_past_esp+0x56/0x79
 [<b7f59410>] 0xb7f59410
 =======================
dde2ac98: redzone 1:0x170fc2a5, redzone 2:0x170fc200.


	Mariusz Kozlowski
