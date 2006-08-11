Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030651AbWHKCQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030651AbWHKCQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 22:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030663AbWHKCQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 22:16:14 -0400
Received: from pool-72-66-192-75.ronkva.east.verizon.net ([72.66.192.75]:59846
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030651AbWHKCQN (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 22:16:13 -0400
Message-Id: <200608110215.k7B2FQPu006243@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: 2.6.18-rc3-mm2 - BUG in rt6_lookup() from ipv6_del_addr()
In-Reply-To: Your message of "Sun, 06 Aug 2006 03:08:09 PDT."
             <20060806030809.2cfb0b1e.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155262526_2846P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 22:15:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155262526_2846P
Content-Type: text/plain; charset=us-ascii

On Sun, 06 Aug 2006 03:08:09 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/

After applying the patch that Patrick McHardy pointed me at, it lived
longer.  However, I'm now seeing problems at system shutdown (or anytime
you try to 'ifdown ethX' where ethX has an IPv6 address attached to it):

[  196.346000] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000014
[  196.347000]  printing eip:
[  196.348000] c032c436
[  196.348000] *pde = 00000000
[  196.349000] Oops: 0000 [#1]
[  196.349000] 4K_STACKS PREEMPT 
[  196.349000] last sysfs file: /class/net/eth1/address
[  196.349000] Modules linked in: thermal sony_acpi processor fan button battery ac nfnetlink i8k floppy nvram orinoco_cs orinoco hermes pcmcia firmware_class ohci1394 ieee1394 intel_agp agpgart iTCO_wdt yenta_socket rsrc_nonstatic pcmcia_core rtc
[  196.349000] CPU:    0
[  196.349000] EIP:    0060:[<c032c436>]    Not tainted VLI
[  196.349000] EFLAGS: 00010246   (2.6.18-rc3-mm2 #4) 
[  196.349000] EIP is at rt6_lookup+0x47/0x83
[  196.349000] eax: 00000000   ebx: 00000000   ecx: 00000005   edx: 00000000
[  196.349000] esi: e8b25c98   edi: e8b25c20   ebp: e8b25c78   esp: e8b25c20
[  196.349000] ds: 007b   es: 007b   ss: 0068
[  196.349000] Process ip (pid: 2511, ti=e8b25000 task=effb0aa0 task.ti=e8b25000)
[  196.349000] Stack: 00000005 00000000 000080fe 00000000 00000000 00000000 00000000 00000000 
[  196.349000]        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
[  196.349000]        00000000 00000000 00000000 00000008 eb6e98c8 e8b25ca8 e8b25cb4 c0327c04 
[  196.349000] Call Trace:
[  196.349000]  [<c0327c04>] ipv6_del_addr+0x2ef/0x3a7
[  196.349000]  [<c0327d3f>] inet6_addr_del+0x83/0xbb
[  196.349000]  [<c0327dd6>] inet6_rtm_deladdr+0x5f/0x6b
[  196.349000]  [<c02da097>] rtnetlink_rcv_msg+0x1b3/0x1d6
[  196.349000]  [<c02e011c>] netlink_run_queue+0x5a/0xc6
[  196.349000]  [<c02d9e9d>] rtnetlink_rcv+0x29/0x42
[  196.349000]  [<c02e0576>] netlink_data_ready+0x12/0x49
[  196.349000]  [<c02df518>] netlink_sendskb+0x1c/0x4d
[  196.349000]  [<c02dfea0>] netlink_unicast+0x1c4/0x1d0
[  196.349000]  [<c02e0557>] netlink_sendmsg+0x274/0x281
[  196.349000]  [<c02ca57e>] sock_sendmsg+0xeb/0x106
[  196.349000]  [<c02cad99>] sys_sendto+0xbe/0xdc
[  196.349000]  [<c02cb522>] sys_socketcall+0xfb/0x186
[  196.349000]  [<c0102849>] sysenter_past_esp+0x56/0x79
[  196.349000] DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x79
[  196.349000] Leftover inexact backtrace:
[  196.349000]  [<c01036c7>] show_stack_log_lvl+0x8c/0x97
[  196.349000]  [<c010381f>] show_registers+0x14d/0x1de
[  196.349000]  [<c0103a5b>] die+0x1ab/0x26d
[  196.349000]  [<c0352205>] do_page_fault+0x3f8/0x4c5
[  196.349000]  [<c0351271>] error_code+0x39/0x40
[  196.349000]  [<c0327c04>] ipv6_del_addr+0x2ef/0x3a7
[  196.349000]  [<c0327d3f>] inet6_addr_del+0x83/0xbb
[  196.349000]  [<c0327dd6>] inet6_rtm_deladdr+0x5f/0x6b
[  196.349000]  [<c02da097>] rtnetlink_rcv_msg+0x1b3/0x1d6
[  196.349000]  [<c02e011c>] netlink_run_queue+0x5a/0xc6
[  196.349000]  [<c02d9e9d>] rtnetlink_rcv+0x29/0x42
[  196.349000]  [<c02e0576>] netlink_data_ready+0x12/0x49
[  196.349000]  [<c02df518>] netlink_sendskb+0x1c/0x4d
[  196.349000]  [<c02dfea0>] netlink_unicast+0x1c4/0x1d0
[  196.349000]  [<c02e0557>] netlink_sendmsg+0x274/0x281
[  196.349000]  [<c02ca57e>] sock_sendmsg+0xeb/0x106
[  196.349000]  [<c02cad99>] sys_sendto+0xbe/0xdc
[  196.349000]  [<c02cb522>] sys_socketcall+0xfb/0x186
[  196.349000]  [<c0102849>] sysenter_past_esp+0x56/0x79
[  196.349000] Code: eb ff 89 5d a8 8d 45 b0 b9 10 00 00 00 89 f2 e8 c9 e0 eb ff 31 d2 83 7d 08 00 0f 95 c2 b9 ad cc 32 c0 89 f8 e8 47 7c 01 00 89 c3 <66> 83 7b 14 00 74 2d 8b 43 04 85 c0 7f 21 68 c4 19 37 c0 68 99 
[  196.349000] EIP: [<c032c436>] rt6_lookup+0x47/0x83 SS:ESP 0068:e8b25c20

The unlucky 'ip' process then gets a SIGSEGV and dies while holding a lock
of some sort, so later 'ip' processes get hung in 'D' state.

Checking the lkml and netdev archives didn't find any useful hits for
'ipv6_addr_rel'...

--==_Exmh_1155262526_2846P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE2+g+cC3lWbTT17ARAiWYAJ47vEdJ+r0SUW3GA3AK4VVUI11HDACfUOxB
aDPKlwLBrqeXzQ7eHePSDOM=
=Oyw7
-----END PGP SIGNATURE-----

--==_Exmh_1155262526_2846P--
