Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbULWOdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbULWOdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 09:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbULWOdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 09:33:33 -0500
Received: from av2-2-sn3.vrr.skanova.net ([81.228.9.108]:65222 "EHLO
	av2-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261246AbULWOd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 09:33:29 -0500
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: OOPS when disconnecting USB mouse while its event device is in use
From: Peter Osterlund <petero2@telia.com>
Date: 23 Dec 2004 15:33:22 +0100
Message-ID: <m3is6tythp.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.10-rc3-bk15, I get an oops if I disconnect my USB mouse
while a userspace program has the corresponding event device opened.

I don't have this problem when running 2.6.10-rc3-mm1, which I think
is because of this patch from bk-input.

#   2004/10/21 23:50:25-05:00 dtor_core@ameritech.net 
#   Input: evdev, joydev, mousedev, tsdev - remove class device and devfs
#          entry when hardware driver disconnects instead of waiting for
#          the last user to drop off. This way hardware drivers can be
#          unloaded at any time.

Maybe it would be a good idea to merge this patch before 2.6.10.


Dec 23 13:27:21 r3000 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Dec 23 13:27:21 r3000 kernel:  printing eip:
Dec 23 13:27:21 r3000 kernel: c01c77e1
Dec 23 13:27:21 r3000 kernel: *pde = 00000000
Dec 23 13:27:21 r3000 kernel: Oops: 0000 [#1]
Dec 23 13:27:21 r3000 kernel: PREEMPT 
Dec 23 13:27:21 r3000 kernel: Modules linked in: radeon snd_atiixp_modem nfsd exportfs lockd parport_pc lp parport autofs4 pcmcia sunrpc ipt_LOG ipt_limit ipt_state ipt_REJECT iptable_filter ipt_MASQUERADE iptable_nat ip_tables binfmt_misc dm_mod usbhid yenta_socket pcmcia_core ohci_hcd ehci_hcd usbcore 8139too ide_cd cdrom
Dec 23 13:27:21 r3000 kernel: CPU:    0
Dec 23 13:27:21 r3000 kernel: EIP:    0060:[<c01c77e1>]    Not tainted VLI
Dec 23 13:27:21 r3000 kernel: EFLAGS: 00210246   (2.6.10-rc3-bk15) 
Dec 23 13:27:21 r3000 kernel: EIP is at get_kobj_path_length+0x1a/0x31
Dec 23 13:27:21 r3000 kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: df95dbb8
Dec 23 13:27:21 r3000 kernel: esi: 00000001   edi: 00000000   ebp: ffffffff   esp: c9549e50
Dec 23 13:27:21 r3000 kernel: ds: 007b   es: 007b   ss: 0068
Dec 23 13:27:21 r3000 kernel: Process evdev (pid: 6278, threadinfo=c9548000 task=ceebf020)
Dec 23 13:27:21 r3000 kernel: Stack: c03b3b60 df95db94 dfb02498 df95dbb8 c01c785a df95dbb8 00000001 0000000a 
Dec 23 13:27:21 r3000 kernel:        c0228ad3 c03b3b60 df95db94 dfb02498 dfb0218c c023c758 df95dbb8 000000d0 
Dec 23 13:27:21 r3000 kernel:        c03b3b60 dfb02480 c957282a c03b3b48 c01caa54 c957282a 00000000 00000000 
Dec 23 13:27:21 r3000 kernel: Call Trace:
Dec 23 13:27:21 r3000 kernel:  [<c01c785a>] kobject_get_path+0x13/0x5f
Dec 23 13:27:21 r3000 kernel:  [<c0228ad3>] pty_write+0x51/0x5a
Dec 23 13:27:21 r3000 kernel:  [<c023c758>] class_hotplug+0x5e/0x19a
Dec 23 13:27:21 r3000 kernel:  [<c01caa54>] vsprintf+0x27/0x2b
Dec 23 13:27:21 r3000 kernel:  [<c01c84ee>] kobject_hotplug+0x2c3/0x2df
Dec 23 13:27:21 r3000 kernel:  [<c01c7b86>] kobject_del+0x18/0x2d
Dec 23 13:27:21 r3000 kernel:  [<c023cb7c>] class_device_del+0x98/0xb4
Dec 23 13:27:21 r3000 kernel:  [<c023cba8>] class_device_unregister+0x10/0x1d
Dec 23 13:27:21 r3000 kernel:  [<c026f431>] evdev_free+0x1b/0x36
Dec 23 13:27:21 r3000 kernel:  [<c026f4e6>] evdev_release+0x9a/0xc7
Dec 23 13:27:21 r3000 kernel:  [<c0153275>] __fput+0xfc/0x13c
Dec 23 13:27:21 r3000 kernel:  [<c0151b8e>] filp_close+0x49/0x7b
Dec 23 13:27:21 r3000 kernel:  [<c0151c1a>] sys_close+0x5a/0xa2
Dec 23 13:27:21 r3000 kernel:  [<c0102ee1>] sysenter_past_esp+0x52/0x75
Dec 23 13:27:21 r3000 kernel: Code: ff 85 c0 89 c3 74 ea 89 34 24 e8 ad d1 fb ff eb e0 55 bd ff ff ff ff 57 56 be 01 00 00 00 53 31 db 8b 54 24 14 8b 3a 89 e9 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e 5f 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
