Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTFLUgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264988AbTFLUgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:36:41 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:60561 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264987AbTFLUgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:36:35 -0400
Date: Thu, 12 Jun 2003 15:50:18 -0400
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: [OOPS] 2.5.70-bk15: sbp2: oops on unplug, replug
Message-ID: <20030612195018.GU4695@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not absolutely sure who is reponsible for what when a drive is left
mounted and you disconnect it. As far as I know, the sbp2 layer tells
the scsi layer to remove the device, so I'm of the opinion that sbp2 did
what it is supposed to, and the scsi layer needs to handle this better
down to the VFS.

I'd need to understand a bit better about why it oopses when plugged
back in. So far I have not had any problems with connecting and
disconnecting drives. I'll have to do some testing.

> Unable to handle kernel NULL pointer dereference at virtual address 0000004c
>  printing eip:
> e88caaae
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<e88caaae>]    Not tainted
> EFLAGS: 00010286
> EIP is at scsi_device_get+0xe/0x40 [scsi_mod]
> eax: 00000000   ebx: c1740900   ecx: 00000001   edx: e68f2b60
> esi: e68f2b60   edi: e6dd54e0   ebp: e68a5a20   esp: e68a5a20
> ds: 007b   es: 007b   ss: 0068
> Process knodemgrd_0 (pid: 350, threadinfo=e68a4000 task=e75f00c0)
> Stack: e68a5a3c e88b3319 e68f2b60 c02117a2 c1740900 e88b32f0 e88b5c60 e68a5a7c 
>        c0151fba e51f9ba0 e68a5b30 e66cdf18 c0118bcc e68a5a7c 00000046 e7fedc30 
>        00000001 c1740918 c0118d9a 00000000 c1740900 00000001 e68a5b30 e68a5bb8 
> Call Trace:

Maybe I'm just not used to reading these new dumps, but where does the
oops actually occur in the list below? I'm used to seeing ksymoops's
"<---" marker.

>  [<e88b3319>] sd_open+0x29/0xf0 [sd_mod]
>  [<c02117a2>] get_gendisk+0x22/0x40
>  [<e88b32f0>] sd_open+0x0/0xf0 [sd_mod]
>  [<e88b5c60>] +0x0/0x100 [sd_mod]
>  [<c0151fba>] do_open+0x2ea/0x320
>  [<c0118bcc>] schedule+0x19c/0x340
>  [<c0118d9a>] default_wake_function+0x2a/0x30
>  [<c0152055>] blkdev_get+0x65/0x70
>  [<c0175004>] register_disk+0xb4/0x150
>  [<c0211731>] add_disk+0x51/0x60
>  [<c02116b0>] exact_match+0x0/0x10
>  [<c02116c0>] exact_lock+0x0/0x20
>  [<e88b47c3>] sd_probe+0x1a3/0x260 [sd_mod]
>  [<e88b5bc4>] +0x4/0x70 [sd_mod]
>  [<c020baf3>] bus_match+0x43/0x80
>  [<e88b5bc4>] +0x4/0x70 [sd_mod]
>  [<e88b5bf4>] +0x34/0x70 [sd_mod]
>  [<e88d8d1c>] scsi_bus_type+0x5c/0xe8 [scsi_mod]
>  [<c020bb7f>] device_attach+0x4f/0x90
>  [<e88b5bc4>] +0x4/0x70 [sd_mod]
>  [<e88d8cc0>] scsi_bus_type+0x0/0xe8 [scsi_mod]
>  [<c020bd33>] bus_add_device+0x63/0xb0
>  [<c020ae1f>] device_add+0xcf/0x100
>  [<e88d0720>] scsi_device_release+0x0/0x20 [scsi_mod]
>  [<e88d8cc0>] scsi_bus_type+0x0/0xe8 [scsi_mod]
>  [<e88d0824>] scsi_device_register+0xe4/0x180 [scsi_mod]
>  [<e88d2758>] +0x4b8/0xc00 [scsi_mod]
>  [<e88cfbae>] scsi_add_lun+0x1be/0x3a0 [scsi_mod]
>  [<e88cfe36>] scsi_probe_and_add_lun+0xa6/0x120 [scsi_mod]
>  [<e88cffb5>] scsi_add_device+0x35/0x50 [scsi_mod]
>  [<e88a39f9>] sbp2_start_device+0x219/0x3d0 [sbp2]
>  [<e88a37a3>] sbp2_start_ud+0xa3/0xe0 [sbp2]
>  [<e88a3472>] sbp2_probe+0x32/0x40 [sbp2]
>  [<e88a876c>] sbp2_driver+0xc/0x70 [sbp2]
>  [<c020baf3>] bus_match+0x43/0x80
>  [<e88a876c>] sbp2_driver+0xc/0x70 [sbp2]
>  [<e88a879c>] sbp2_driver+0x3c/0x70 [sbp2]
>  [<e88c885c>] ieee1394_bus_type+0x5c/0x100 [ieee1394]
>  [<c020bb7f>] device_attach+0x4f/0x90
>  [<e88a876c>] sbp2_driver+0xc/0x70 [sbp2]
>  [<e88c8800>] ieee1394_bus_type+0x0/0x100 [ieee1394]
>  [<c020bd33>] bus_add_device+0x63/0xb0
>  [<c020ae1f>] device_add+0xcf/0x100
>  [<e88c867c>] nodemgr_dev_template_ud+0xbc/0xc0 [ieee1394]
>  [<e88be768>] nodemgr_process_unit_directory+0x188/0x490 [ieee1394]
>  [<e88c1199>] +0x289/0x330 [ieee1394]
>  [<e88bec52>] nodemgr_process_root_directory+0x1e2/0x1f0 [ieee1394]
>  [<e88bef3e>] nodemgr_process_config_rom+0x8e/0xc0 [ieee1394]
>  [<e88c873c>] nodemgr_dev_template_ne+0xbc/0xc0 [ieee1394]
>  [<e88be203>] nodemgr_create_node+0x153/0x1e0 [ieee1394]
>  [<e88bf376>] nodemgr_node_probe_one+0xe6/0xf0 [ieee1394]
>  [<e88bf4c4>] nodemgr_node_probe+0x104/0x110 [ieee1394]
>  [<e88bf7b8>] nodemgr_host_thread+0x118/0x180 [ieee1394]
>  [<e88bf6a0>] nodemgr_host_thread+0x0/0x180 [ieee1394]
>  [<c010912d>] kernel_thread_helper+0x5/0x18
> 
> Code: 8b 40 4c 8b 00 85 c0 74 0b 83 38 02 74 19 ff 80 a0 00 00 00 
>  
> 
> -- 
> Torrey Hoffman <thoffman@arnor.net>
> 

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
