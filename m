Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbUKFB3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUKFB3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUKFB3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:29:17 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:5286 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261280AbUKFB3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:29:13 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm3: modprobe oopses [x86]
Date: Sat, 6 Nov 2004 02:23:26 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411060223.26516.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modprobe ohci1394 leads to:

Unable to handle kernel paging request at virtual address e0c00000
printing eip:
*pde=00000000
Oops: 0002 [ #1]
PREEMPT
Modules linked in: ehci_hcd uhci_hcd usbcore rtc
CPU: 0
EIP: 0060:[<c0137d8d>] Not tainted VLI
EFLAGS: 00010216 (2.6.10-rc1-mm1)
EIP is at load_module+0x51d/0xb60
eax: 00000000 ebx: e0b91000 ecx: 0000ef8d edx: 0004be34
esi: 0004be34 edi: e0c00000 ebp: e0bf0000 esp: dfdddf0c
ds: 007b es: 007b ss: 0068
Process modprobe (pid: 490, threadinfo=dfddd000 task=df978560)
Stack: 0004be34 e0b91000 e0bd38cc e0bd37a0 c0318ca4 df7228d8 df7228cc
       00000000 0005e000 00000000 c0151656 c152b280 df1fdbe0 e0bd3480 00000016
       00000000 00000011 00000000 0000000c 00000000 00000019 00000014 00000000
Call Trace:
[<c0151656>] do_mmap_pgoff+0x586/0x7d0
[<c0138423>] sys_init_module+0x53/0x220
[<c0106181>] sysenter_past_esp+0x52/0x71
Code: 00 00 89 04 24 e8 d4 ef fd ff 85 c0 89 c5 0f 84 a1 01 00 00 8b 7c 24 38 
8b b7 80 00 00 00 89 c7 8b 44 24 20 89 f1 89 f2 c1 e9 02 <f3> ab f6 c2 02 74 
02 66 ab f6 c2 01 74 01 aa 8b 4c 24 38 8b 41

Turning off firewire allows the boot process to proceed a bit further, to hang 
after a similar oops when loading snd-intel8x0:

Unable to handle kernel paging request at virtual address e0c00000
 printing eip:
c02e886a
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: soundcore psmouse pcmcia yenta_socket pcmcia_core af_packet 
ehci_hcd uhci_hcd usbcore video thermal processor fan button battery 
asus_acpi ac rtc
CPU:    0
EIP:    0060:[<c02e886a>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-0.rc1.2ark)
EIP is at __lock_text_end+0xb67/0x1056
eax: 00000000   ebx: 000112a8   ecx: 000022a8   edx: b7fff2a8
esi: b7ffd000   edi: e0c00000   ebp: 00000000   esp: dfb70ed0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 997, threadinfo=dfb70000 task=de4a9060)
Stack: 00000000 000022a8 df428ca0 00000163 dfb70ee4 00000000 e0bf1000 c01dd192
       e0bf1000 b7fee000 000112a8 e0bf1000 fffffff2 00000000 c0137928 e0bf1000
       b7fee000 000112a8 df822e34 de563f10 df68285c df68287c df682874 df822e34
Call Trace:
 [<c01dd192>] copy_from_user+0x42/0x70
 [<c0137928>] load_module+0xb8/0xb60
 [<c0151656>] do_mmap_pgoff+0x586/0x7d0
 [<c0138423>] sys_init_module+0x53/0x220
 [<c0106181>] sysenter_past_esp+0x52/0x71
Code: 88 00 51 50 31 c0 f3 aa 58 59 e9 a1 47 ef ff 01 c1 e9 f3 47 ef ff 8d 4c 
88 00 e9 ea 47 ef ff 01 c1 eb 04 8d 4c 88 00 51 50 31 c0 <f3> aa 58 59 e9 55 
48 ef ff b8 f2 ff ff ff e9 bf a2 ef ff ba f2
