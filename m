Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUAUIep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 03:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUAUIep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 03:34:45 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:27111 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S262126AbUAUIej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 03:34:39 -0500
Date: Wed, 21 Jan 2004 10:31:23 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Valdis Kletnieks <valdis@turing-police.cc.vt.edu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.1-mm5 - oops during network initialization
In-Reply-To: <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro>
References: <20040120000535.7fb8e683.akpm@osdl.org> 
 <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004, Valdis Kletnieks wrote:

I can confirm I get this also.

> (linux-net people, please cc: on replies, am only on lkml)
>
> Under 2.6.1-mm4, at boot I'd get the following:
>
> Jan 20 10:00:46 turing-police kernel: Initializing IPsec netlink socket
> Jan 20 10:00:46 turing-police kernel: NET: Registered protocol family 1
> Jan 20 10:00:46 turing-police kernel: NET: Registered protocol family 10
> Jan 20 10:00:46 turing-police kernel: IPv6 over IPv4 tunneling driver
> Jan 20 10:00:46 turing-police kernel: NET: Registered protocol family 17
> Jan 20 10:00:46 turing-police kernel: NET: Registered protocol family 15
> Jan 20 10:00:46 turing-police kernel: RAMDISK: Compressed image found at block 0
>
> and the initrd would kick off and we'd be happy.
>
> Under 2.6.1-mm5, I get this: (hand-copied..
>
> NET: Registered protocol family 10
> Unable to handle kernel NULL pointer dereference at virtual address 00000068
>  printing eip:
> c01186f9
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> CPU: 0
> EIP: 0060:[<c01180f9>]  Not tainted VLI
> EFLAGS: 0010217
> EIP is at do_page_fault+0x53/0x4b2
> eax: cfe84000 ebx: cfe86000 ecx: 0000007b edx: 00000000
> esi: 00000000 edi: 00000000 ebp: cfe84048 esp: cfe8405c
> ds: 007b es: 007b ss: 0068
> process ksoftirqd/0 (pid:2, threadinfo=cfe82000 task=cff81310
> stack: 00000000 00000068 00000000 00000000 00000000 00030001 00000000 00000000
>        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> call trace:
>
> (I had to stick a 'for (;;);' into the code at this point to keep it from scrolling off the
> screen - was do_page_fault and 2 other routines in a loop over and over again).
>
> So it's choking somewhere in IPv6 init.  Only change I can spot in -mm5 in that
> area is ipv6-sysctl-oops-fix.patch but I'm not seeing how that one can *cause* this oops.
>
> For the record, built *without* regparm-3, with the Fedora gcc-3.3.2-5 compiler.
>
> IPv6-related .config:
>
> CONFIG_IPV6=y
> CONFIG_IPV6_PRIVACY=y
> CONFIG_INET6_AH=y
> CONFIG_INET6_ESP=y
> CONFIG_INET6_IPCOMP=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
>
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_IP6_NF_QUEUE is not set
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_LIMIT=m
> CONFIG_IP6_NF_MATCH_MAC=m
> CONFIG_IP6_NF_MATCH_RT=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_MULTIPORT=m
> CONFIG_IP6_NF_MATCH_OWNER=m
> CONFIG_IP6_NF_MATCH_MARK=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_AHESP=m
> CONFIG_IP6_NF_MATCH_LENGTH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_LOG=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_TARGET_MARK=m
> CONFIG_XFRM=y
> CONFIG_XFRM_USER=y
>
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=y
>
> I'll play binary-search on the IPv6 config options, see if one of them is
> involved, but that will have to wait for morning....
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
