Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267096AbUBFADZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267100AbUBFADZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:03:25 -0500
Received: from agminet04.oracle.com ([141.146.126.231]:238 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S267096AbUBFADF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:03:05 -0500
Message-ID: <4022D99D.5080504@oracle.com>
Date: Fri, 06 Feb 2004 01:02:37 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: update on Cisco VPN 403B: non-fatal oops on 2.6.2-mm1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still cvpnd goes in __down and never comes back, but 2.6.2-mm1
  has insmod segfaulting and provides a small trace... perhaps
  someone at Cisco reads this, perhaps someone on lkml spots
  something... anyway ;)


Base distro is a RedHat9.


Starting /usr/local/bin/vpnclient: cisco_ipsec: no version for "struct_module" found: kernel tainted.
cisco_ipsec: no version magic, tainting kernel.
cisco_ipsec: module license 'Proprietary' taints kernel.
Unable to handle kernel paging request at virtual address 24510000
  printing eip:
c026de91
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c026de91>]    Tainted: PF  VLI
EFLAGS: 00010246
EIP is at register_netdev+0x1a/0x78
eax: 00002525   ebx: 24510000   ecx: c04079c0   edx: fa94de44
esi: 24510000   edi: fa94de44   ebp: f6a4dfa0   esp: f6a4df6c
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 1720, threadinfo=f6a4c000 task=f6b226b0)
Stack: c03c22d0 fa948e44 fa8fe782 fa9202c0 f6a4df94 f6a4dfa0 fa8fe775 0804a008
        00000000 c03b00f4 fa948e20 fa94dc00 c03c22b8 f6a4c000 c0130ec1 00000001
        00000000 40023000 42132920 0000036b f6a4c000 c0347b82 40023000 00058051
Call Trace:
  [<fa8fe782>] init_module+0x62/0x8c [cisco_ipsec]
  [<fa8fe775>] init_module+0x55/0x8c [cisco_ipsec]
  [<c0130ec1>] sys_init_module+0x11c/0x234
  [<c0347b82>] sysenter_past_esp+0x43/0x65

Code: 66 c7 43 54 02 10 8b 7c 24 04 8b 1c 24 83 c4 08 c3 83 ec 08 89 1c 24 89 74 24 04 89 c3 89 de e8 f6 c2 07 00 b8 25 00 00 00 88 c4 <ac> 38 e0 74 09 84 c0 75 f7 be 01 00 00 00 89 f0 48 85 c0 74 0f
  /etc/init.d/vpnclient_init: line 140:  1720 Segmentation fault      /sbin/insmod ${PC}/${VPNMOD}
Failed (insmod)
Cisco Systems VPN Client Version 4.0.3 (B)
Copyright (C) 1998-2003 Cisco Systems, Inc. All Rights Reserved.
Client Type(s): Linux
Running on: Linux 2.6.2-mm1 #1 Thu Feb 5 11:42:16 CET 2004 i686

FATAL: Module cipsec0 not found.
<7>request_module: failed /sbin/modprobe -- cipsec0. error = 256


Thanks,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

