Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbTKUJvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 04:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbTKUJvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 04:51:50 -0500
Received: from ns.sws.net.au ([61.95.69.3]:57606 "EHLO ns.sws.net.au")
	by vger.kernel.org with ESMTP id S264347AbTKUJvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 04:51:47 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: de2104x tulip driver bug in 2.6.0-test9
Date: Fri, 21 Nov 2003 20:51:32 +1100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311212051.32352.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

00:14.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip Pass 3] (rev 11)

Above is the lspci output for my PCI Ethernet card.  Below is what happens 
when I try to boot 2.6.0-test9.  2.4.x kernels have been working well on the 
same card for a long time, so the hardware seems basically OK.

Configuring network interfaces... eth0: set link BNC
 eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef09,0xfffff7fd,0xffff0006
 eth0:    set mode 0x7ffc0000, set sia 0xef09,0xf7fd,0x6
 eth0: timeout expired stopping DMA
 ------------[ cut here ]------------
 kernel BUG at drivers/net/tulip/de2104x.c:926!
 invalid operand: 0000 [#1]
 CPU:    0
 EIP:    0060:[<d08a7f4c>]    Not tainted
 EFLAGS: 00010006
 EIP is at de_set_media+0x1c/0x140 [de2104x]
 eax: fc200100   ebx: cf172200   ecx: c02c6770   edx: d089f000
 esi: cf172200   edi: 00000000   ebp: cf021e50   esp: cf021e44
 ds: 007b   es: 007b   ss: 0068
 Process ethtool (pid: 478, threadinfo=cf020000 task=cfb0ccc0)
 Stack: cf172200 000008c3 00000000 cf021e84 d08a8fb6 cf172200 cf172200 
cf172200
        fffff73c 00000000 00000000 00000000 ffffffea cf020000 00000001 
00000000
        cf021e9c d08a9104 cf172200 cf021eb0 cf021eb0 cf172000 cf021eec 
c0224368
 Call Trace:
  [<d08a8fb6>] __de_set_settings+0x186/0x200 [de2104x]
  [<d08a9104>] de_set_settings+0x24/0x50 [de2104x]
  [<c0224368>] ethtool_set_settings+0x68/0x90
  [<c019e4fa>] capable+0x1a/0x40
  [<c022587b>] dev_ethtool+0xab/0x220
  [<c0223766>] dev_ioctl+0x156/0x350
  [<c02613b7>] inet_ioctl+0xb7/0xd0
  [<c021ae31>] sock_ioctl+0xf1/0x280
  [<c015eac2>] sys_ioctl+0x112/0x280
  [<c0109169>] sysenter_past_esp+0x52/0x79

 Code: 0f 0b 9e 03 04 99 8a d0 f6 86 a4 05 00 00 01 74 0a c7 42 58
  <7>eth0: tx err, status 0x7fffb178
 note: ethtool[478] exited with preempt_count 1
 bad: scheduling while atomic!
 Call Trace:
  [<c0118189>] schedule+0x5b9/0x5c0
  [<c013f1a3>] unmap_page_range+0x33/0x60
  [<c013f3c3>] unmap_vmas+0x1f3/0x240
  [<c01430a5>] exit_mmap+0x65/0x180
  [<c0119aaa>] mmput+0x6a/0xc0
  [<c011d938>] do_exit+0x128/0x410
  [<c0109cc0>] do_invalid_op+0x0/0xa0
  [<c0109a74>] die+0xc4/0xd0
  [<c0109d54>] do_invalid_op+0x94/0xa0
  [<d08a7f4c>] de_set_media+0x1c/0x140 [de2104x]
  [<c01d5ae7>] poke_blanked_console+0x57/0x70
  [<c01d4f4d>] vt_console_print+0x22d/0x310
  [<c011bcd5>] __call_console_drivers+0x55/0x60
  [<c011bdac>] call_console_drivers+0x5c/0x100
  [<c010942d>] error_code+0x2d/0x40
  [<d08a7f4c>] de_set_media+0x1c/0x140 [de2104x]
  [<d08a8fb6>] __de_set_settings+0x186/0x200 [de2104x]
  [<d08a9104>] de_set_settings+0x24/0x50 [de2104x]
  [<c0224368>] ethtool_set_settings+0x68/0x90
  [<c019e4fa>] capable+0x1a/0x40
  [<c022587b>] dev_ethtool+0xab/0x220
  [<c0223766>] dev_ioctl+0x156/0x350
  [<c02613b7>] inet_ioctl+0xb7/0xd0
  [<c021ae31>] sock_ioctl+0xf1/0x280
  [<c015eac2>] sys_ioctl+0x112/0x280
  [<c0109169>] sysenter_past_esp+0x52/0x79


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

