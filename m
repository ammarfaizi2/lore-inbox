Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTE1VPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTE1VPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:15:10 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:53776 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261159AbTE1VPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:15:01 -0400
Date: Wed, 28 May 2003 17:27:08 -0400
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: ppp problems in 2.5.69-bk14 - devfs related?
In-reply-to: <20030528125503.GA2745@bittwiddlers.com>
To: Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1054589229.f149f8@bittwiddlers.com>
Message-id: <20030528212708.GA11432@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
References: <Pine.LNX.4.44.0305211051100.22168-100000@bad-sports.com>
 <20030528125503.GA2745@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My oops output is just marginally different under 2.5.70-bk2.
Unfortunately, I don't seem to have a /proc/ksyms so I don't know what
to point ksymoops to.  I can make this one happen over and over by
just running pppd.  It does not kill the system but it does make it
rather unuseable.


CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
devfs_mk_cdev: could not append to parent for ppp
failed to register PPP device (-17)
Unable to handle kernel paging request at virtual address e0927c80
c015a226
*pde = 0162e067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c015a226>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: dcdb7a00   ebx: e0927c80   ecx: 0000006c   edx: da17df24
esi: 00000000   edi: 00006c00   ebp: dcdb7a00   esp: da17ded8
ds: 007b   es: 007b   ss: 0068
Stack: c015e070 ddc2f940 00000000 c015a12f dcdb7a00 c022ee80 00006c00 dcdb7a00 
       00000000 c015a110 000000ff 00000000 00000000 00000000 defde200 c0159fb2 
       defe3400 00006c00 da17df24 00000000 defde200 ffffffed db6cb500 defe1f00 
Call Trace:
 [<c015e070>] do_lookup+0x30/0xb0
 [<c015a12f>] exact_lock+0xf/0x20
 [<c022ee80>] kobj_lookup+0xe0/0x170
 [<c015a110>] exact_match+0x0/0x10
 [<c0159fb2>] chrdev_open+0xe2/0x150
 [<c019e3d0>] devfs_open+0xb0/0xd0
 [<c0150a20>] dentry_open+0x110/0x1a0
 [<c0150908>] filp_open+0x68/0x70
 [<c0150cdb>] sys_open+0x5b/0x90
 [<c010b14f>] syscall_call+0x7/0xb
Code: 83 3b 02 74 41 ff 83 00 01 00 00 89 04 24 e8 57 c4 06 00 85 


>>EIP; c015a226 <cdev_get+16/60>   <=====

>>eax; dcdb7a00 <__crc_scsi_get_command+e98e4/386137>
>>ebx; e0927c80 <__crc_elv_queue_empty+7279d/135f59>
>>edx; da17df24 <__crc_sock_rfree+2f6ef9/3b231c>
>>ebp; dcdb7a00 <__crc_scsi_get_command+e98e4/386137>
>>esp; da17ded8 <__crc_sock_rfree+2f6ead/3b231c>

Trace; c015e070 <do_lookup+30/b0>
Trace; c015a12f <exact_lock+f/20>
Trace; c022ee80 <kobj_lookup+e0/170>
Trace; c015a110 <exact_match+0/10>
Trace; c0159fb2 <chrdev_open+e2/150>
Trace; c019e3d0 <devfs_open+b0/d0>
Trace; c0150a20 <dentry_open+110/1a0>
Trace; c0150908 <filp_open+68/70>
Trace; c0150cdb <sys_open+5b/90>
Trace; c010b14f <syscall_call+7/b>

Code;  c015a226 <cdev_get+16/60>
00000000 <_EIP>:
Code;  c015a226 <cdev_get+16/60>   <=====
   0:   83 3b 02                  cmpl   $0x2,(%ebx)   <=====
Code;  c015a229 <cdev_get+19/60>
   3:   74 41                     je     46 <_EIP+0x46>
Code;  c015a22b <cdev_get+1b/60>
   5:   ff 83 00 01 00 00         incl   0x100(%ebx)
Code;  c015a231 <cdev_get+21/60>
   b:   89 04 24                  mov    %eax,(%esp,1)
Code;  c015a234 <cdev_get+24/60>
   e:   e8 57 c4 06 00            call   6c46a <_EIP+0x6c46a>
Code;  c015a239 <cdev_get+29/60>
  13:   85 00                     test   %eax,(%eax)


1 warning and 1 error issued.  Results may not be reliable.

-- 
  Matthew Harrell                          Artificial Intelligence is no
  Bit Twiddlers, Inc.                       match for natural stupidity
  mharrell@bittwiddlers.com     
