Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268169AbUHTPYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268169AbUHTPYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267243AbUHTPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:24:10 -0400
Received: from newnelson.SEDSystems.ca ([192.107.131.3]:56883 "EHLO
	newnelson.sedsystems.ca") by vger.kernel.org with ESMTP
	id S268169AbUHTPW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:22:58 -0400
Message-ID: <41261744.5000403@sedsystems.ca>
Date: Fri, 20 Aug 2004 09:22:44 -0600
From: Robert Hancock <hancock@sedsystems.ca>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: riffel@sedsystems.ca
Subject: Linux 2.4.20 (Red Hat 9) oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We saw the following oops from an IBM eServer X-Series 345 machine with 2 
physical CPUs (4 logical, due to HyperThreading) running a 2.4.20-31.9 kernel 
(Red Hat 9) that boots via PXE over the network. The machine was still up 
afterwards, however the process that was killed (mnob_task) is probably the most 
important one running on the machine.

We have about 25 machines that run the same basic configuration, this happened 
on one of them a few weeks ago and as far as I know none of these have oopsed 
before or since.

BTW, the reason it shows Tainted is because the Rocketport driver for a serial 
card in these machines used to use insmod -f always in its initialization script 
, before I changed the script to not do so. The aic module listed is the driver 
for an audio card of our own design and which we wrote the driver for; it's 
GPLed and available if needed, however I'm doubtful that it's involved. The 
stack trace doesn't seem to involve it, so I think it would have to be randomly 
corrupting memory somehow, which seems unlikely given that we've seen no other 
stability-related problems on the machines with these cards.

Mainly what I am wondering is whether this is some random 
hardware/memory-related fault or something, or whether it's a bug that someone 
has seen before and which could occur again.

Any insight would be appreciated. If possible please CC me on replies, as I'm 
not subscribed to the list on this address.

Unable to handle kernel paging request at virtual address ffffff92
  printing eip:
c03c9263
*pde = 00003067
*pte = 00000000
Oops: 0002
aic rocket e1000 keybdev mousedev hid input usb-ohci usbcore
CPU:    3
EIP:    0060:[<c03c9263>]    Tainted: GF
EFLAGS: 00010206

EIP is at pid_hash [kernel] 0xf2a3 (2.4.20-31.9pxe)
eax: 00000000   ebx: c03c9263   ecx: 00000001   edx: 08152ee0
esi: 08152ee8   edi: dea9c268   ebp: 0000007c   esp: de449d20
ds: 0068   es: 0068   ss: 0068
Process mnob_task (pid: 22317, stackpage=de449000)
Stack: dea9c224 08152eac 0000007c c01fca1f 08152eac dea9c22c 0000007c 00000000
        de449d54 00000000 de448000 00000000 00000000 00000000 de449e1c dea9c224
        e7690b80 00000084 c022f71b dea9c22c de449ec4 00000000 0000007c de449e30
Call Trace:   [<c01fca1f>] csum_partial_copy_fromiovecend [kernel] 0x1bf
(0xde449d2c))
[<c022f71b>] udp_getfrag [kernel] 0x4b (0xde449d68))
[<c0212829>] ip_build_xmit [kernel] 0x269 (0xde449d88))
[<c020cbdb>] ip_route_output_key [kernel] 0x3b (0xde449d9c))
[<c022fae2>] udp_sendmsg [kernel] 0x272 (0xde449dc0))
[<c022f6d0>] udp_getfrag [kernel] 0x0 (0xde449dc8))
[<c0237712>] inet_sendmsg [kernel] 0x42 (0xde449e5c))
[<c01f6b88>] sock_sendmsg [kernel] 0x78 (0xde449e70))
[<c01f7d73>] sys_sendto [kernel] 0xe3 (0xde449eb4))
[<c015cf1c>] pipe_write [kernel] 0x1bc (0xde449f58))
[<c01f86d9>] sys_socketcall [kernel] 0x199 (0xde449f80))
[<c01098bf>] system_call [kernel] 0x33 (0xde449fc0))


Code: c0 60 92 3c c0 68 92 3c c0 68 92 3c c0 70 92 3c c0 70 92 3c

-- 
Robert Hancock
Programmer
SED Systems
Email: hancock@sedsystems.ca
