Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUIKNDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUIKNDd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 09:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUIKNDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 09:03:32 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:21172 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S268144AbUIKNDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 09:03:30 -0400
Message-ID: <4142F7A0.4020001@tuxnetwork.de>
Date: Sat, 11 Sep 2004 15:03:28 +0200
From: Bjoern Brauel <bjoern@tuxnetwork.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Major XFS problems...
References: <20040908123524.GZ390@unthought.net> <4142E3EB.3080308@pointblue.com.pl>
In-Reply-To: <4142E3EB.3080308@pointblue.com.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for the sake of it, I'm experiencing SMP+XFS+NFS problems as well. 
See the oops below. It does not need alot of stress on the server to 
trigger the oops. The filesystem is running on a Raid5 3Ware7506 array, 
distro is FC2, kernel 2.6.9-rc1.

 B.

---cut---
Unable to handle kernel paging request at virtual address 64c17165
 printing eip:
c014221b
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: sg sr_mod binfmt_misc vmnet vmmon parport_pc lp 
parport rfcomm l2cap bluetooth nfsd exportfs lockd sunrpc ipv6 
iptable_filter ip_tables e1000 st ide_scsi ohci1394 ieee1394 uhci_hcd 
ehci_hcd usbcore
CPU:    1
EIP:    0060:[<c014221b>]    Tainted: P   VLI
EFLAGS: 00010086   (2.6.9-rc1)
EIP is at kfree+0x3d/0x6d
eax: 00000001   ebx: 64c17165   ecx: f8a98560   edx: c17164f9
esi: f8b284dc   edi: 00000282   ebp: f7825100   esp: f6c9bdd4
ds: 007b   es: 007b   ss: 0068
Process rpc.mountd (pid: 1753, threadinfo=f6c9a000 task=f6ffb870)
Stack: f8a985c0 00000001 f7825100 f6c9be90 00000001 f8a87e1a f8b284dc 
c1bfa140
       f8a88432 f7825100 f8a985c0 00000000 f8a99778 f6c9bf58 f6e4c760 
f6c9bec0
       4142f814 f8a8807e f6c9be90 00000001 00000032 f6c9be40 f6c9be44 
f6c9be48
Call Trace:
 [<f8a87e1a>] ip_map_put+0x45/0x71 [sunrpc]
 [<f8a88432>] ip_map_lookup+0x260/0x2f9 [sunrpc]
 [<f8a8807e>] ip_map_parse+0x19c/0x24f [sunrpc]
 [<c0148c03>] do_anonymous_page+0x143/0x179
 [<c0148c9c>] do_no_page+0x63/0x2c2
 [<c0149114>] handle_mm_fault+0x105/0x189
 [<c01193fa>] do_page_fault+0x141/0x511
 [<c0234e28>] copy_from_user+0x42/0x6e
 [<f8a8b18d>] cache_write+0xb2/0xca [sunrpc]
 [<f8a8b0db>] cache_write+0x0/0xca [sunrpc]
 [<c01571af>] vfs_write+0xb0/0x119
 [<c01572e9>] sys_write+0x51/0x80
 [<c0105f91>] sysenter_past_esp+0x52/0x71
Code: 18 85 f6 74 36 9c 5f fa 8b 15 10 a6 48 c0 8d 86 00 00 00 40 c1 e8 
0c c1 e0 05 8b 54 02 18 b8 00 e0 ff ff 21 e0 8b 40 10 8b 1c 82 <8b> 03 
3b 43 04 73 19 89 74 83 10 83 03 01 57 9d 8b 5c 24 08 8b

