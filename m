Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288092AbSA0PvG>; Sun, 27 Jan 2002 10:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288112AbSA0Pu5>; Sun, 27 Jan 2002 10:50:57 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:49040 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S288092AbSA0Puk>; Sun, 27 Jan 2002 10:50:40 -0500
Message-ID: <3C542134.3040205@wanadoo.fr>
Date: Sun, 27 Jan 2002 16:48:04 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: ext2 fs corruption and usb devices
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.18-pre7 hopefully solves the systematic freeze i meet with 
2.4.18-pre6 when dropping my ADSL usb connection.

2.4.18-pre6 freezes when rmmoding usb-uhci inside an ADSL disconnect 
script. The last entries in log is :
usb.c: USB disconnect on device 1
usb.c: USB disconnect on device 2

sysrq remains responsive but doesn't avoid the need for fscking to 
correct many i_blocks size, block bitmap differences... on the ext2 root fs.

running ksymoops on sysrq <p> gives this :
Pid: 285,comm: rmmod
EIP: 0010:[<c0140754>] CPU: 0 EFLAGS: 00000246 Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 00000000 EBX: cf81f3ac ECX: cf81f3ac EDX: cf81f3ac
ESI: cf983cec EDI: d08a38a0 EPB: ffffffff DS: 0018 ES: 0018
CR0: 8005003b CR2: 0805d077 CR3: 0f697000 CR4: 000006d0
Call Trace: [<d08b959c>] [<d089ea1d>] [<d089f871>] [<c01bad38>] [<c01280fd>]
[<d08b99c0>] [<d08b8173>] [<c01147a0>] [<d08b9580>] [<d08b959c>] 
[<d08a363c>]
[<d0899baa>] [<d0899c02>] [<d08a363c>] [<d0899bdf>] [<d08aa1a0>] 
[<d08a8916>]
[<c017b4df>] [<d08a8e36>] [<d08aa1a0>] [<c01160d3>] [<c0115477>] 
[<c0106b0b>]
Warning (Oops_read): Code line not seen, dumping what data is available

 >>EIP; c0140754 <inode_change_ok+24/128>   <=====
Trace; d08b959c <[speedtch]udsl_usb_driver+1c/40>
Trace; d089ea1c <[usbcore]free_inode+7c/84>
Trace; d089f870 <[usbcore]usbdevfs_remove_device+30/d8>
Trace; c01bad38 <free_atm_dev+4/50>
Trace; c01280fc <kfree+16c/1c8>
Trace; d08b99c0 <[speedtch].bss.start+0/be>
Trace; d08b8172 <[speedtch]udsl_usb_disconnect+86/98>
Trace; c01147a0 <release_console_sem+8/7c>
Trace; d08b9580 <[speedtch]udsl_usb_driver+0/40>
Trace; d08b959c <[speedtch]udsl_usb_driver+1c/40>
Trace; d08a363c <[usbcore]hub_driver+1c/40>
Trace; d0899baa <[usbcore]usb_disconnect+92/104>
Trace; d0899c02 <[usbcore]usb_disconnect+ea/104>
Trace; d08a363c <[usbcore]hub_driver+1c/40>
Trace; d0899bde <[usbcore]usb_disconnect+c6/104>
Trace; d08aa1a0 <[usb-uhci]uhci_pci_driver+0/3e>
Trace; d08a8916 <[usb-uhci]uhci_pci_remove+2a/c8>
Trace; c017b4de <pci_request_regions+15e/160>
Trace; d08a8e36 <[usb-uhci]uhci_hcd_cleanup+a/32>
Trace; d08aa1a0 <[usb-uhci]uhci_pci_driver+0/3e>
Trace; c01160d2 <sys_get_kernel_syms+25a/278>
Trace; c0115476 <sys_delete_module+82/1b0>
Trace; c0106b0a <system_call+32/38>

with 2.4.18-pre7 the landing is soft :
usb.c: USB disconnect on device 1
usb.c: USB disconnect on device 2
usb.c: USB bus 1 deregistered
usb.c: deregistering driver Alcatel SpeedTouch USB
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub

with 2.5.3-pre5 as well :
usb.c: USB disconnect on device 1
usb.c: USB disconnect on device 2
usb.c: USB bus 1 deregistered
usb.c: deregistering driver Alcatel SpeedTouch USB
usb.c: deregistering driver usbfs
usb.c: usb_hub_thread exiting
usb.c: deregistering driver hub


Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

