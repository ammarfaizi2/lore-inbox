Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUGSJ1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUGSJ1r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 05:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUGSJ1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 05:27:47 -0400
Received: from hosting-24.75.rev.fr.colt.net ([213.41.75.24]:17345 "EHLO
	lastinfos.com") by vger.kernel.org with ESMTP id S264884AbUGSJ1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 05:27:40 -0400
Message-ID: <40FB93FE.90308@ovibes.net>
Date: Mon, 19 Jul 2004 11:27:26 +0200
From: Sebastien ESTIENNE <sebest@ovibes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040629
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.7 -> page allocation failure. order:1, mode:0x20 (netfilter?)
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i have some "swapper: page allocation failure. order:1, mode:0x20"
followed by kernel message,

the hardware is a dell poweredge 1750
the kernel is a 2.6.7 vanilla

here for a dmesg
http://213.41.75.25/kernel/dmesg.txt

swapper: page allocation failure. order:1, mode:0x20
 [<c013d770>] __alloc_pages+0x2da/0x34a
 [<c013d805>] __get_free_pages+0x25/0x3f
 [<c0140e28>] kmem_getpages+0x2b/0xdc
 [<c0141bfc>] kfree_skbmem+0x24/0x2c
 [<c0141c5d>] cache_grow+0xe5/0x2a4
 [<c0141f8a>] cache_grow+0x146/0x2a4
 [<c0295917>] cache_alloc_refill+0x1cf/0x29f
 [<c014262a>] __kmalloc+0x85/0x8c
 [<c02681f1>] tcp_transmit_skb+0x411/0x68a
 [<c0296621>] alloc_skb+0x47/0xe0
 [<c026875e>] tcp_write_xmit+0x16d/0x2d6
 [<c01da1ac>] skb_copy+0x33/0xde
 [<c026ca5b>] copy_from_user+0x42/0x6e
 [<c028ac94>] skb_checksum_help+0x52/0x136
 [<e094fb79>] ip_nat_fn+0x269/0x27a [iptable_nat]
 [<e094fcb3>] ip_nat_local_fn+0x7b/0xaa [iptable_nat]
 [<c028708e>] tcp_sendmsg+0x509/0x10f7
 [<c0121872>] tasklet_action+0x65/0xae
 [<c01065da>] apic_timer_interrupt+0x1a/0x20
 [<c02ad977>] dst_output+0x0/0x29
 [<c028708e>] inet_sendmsg+0x4d/0x59
 [<c026498f>] dst_output+0x0/0x29
 [<c0276a40>] sock_aio_write+0xbd/0xdd
 [<c015902c>] do_sync_write+0x8b/0xb7
 [<c01da1ac>] nf_iterate+0x71/0xa2
 [<c028708e>] copy_from_user+0x42/0x6e
 [<c0159140>] vfs_write+0xe8/0x119
 [<c0159216>] sys_write+0x42/0x63
 [<c0105beb>] syscall_call+0x7/0xb




the config file and other info of the kernel is here (.config, cpuinfo, 
modules etc)
http://213.41.75.25/kernel/

the problems seems related to netfilter, these messages appeared when i 
runned apache bench on localhost

here is the list of loaded modules:
af_packet 21512 0 - Live 0xe0990000
ipt_TOS 6144 12 - Live 0xe0973000
ipt_REJECT 9728 4 - Live 0xe0984000
ipt_pkttype 5504 4 - Live 0xe0944000
ipt_LOG 9984 9 - Live 0xe0949000
ipt_state 5760 9 - Live 0xe097a000
ipt_multiport 5888 0 - Live 0xe0903000
ipt_conntrack 6144 0 - Live 0xe0900000
iptable_mangle 6400 1 - Live 0xe0970000
ip_nat_irc 7664 0 - Live 0xe096d000
ip_nat_tftp 7024 0 - Live 0xe096a000
ip_nat_ftp 8432 0 - Live 0xe0966000
iptable_nat 25636 3 ip_nat_irc,ip_nat_tftp,ip_nat_ftp, Live 0xe094d000
ip_conntrack_irc 74544 1 ip_nat_irc, Live 0xe0930000
ip_conntrack_tftp 7088 0 - Live 0xe090f000
ip_conntrack_ftp 75184 1 ip_nat_ftp, Live 0xe091c000
ip_conntrack 33804 9 
ipt_state,ipt_conntrack,ip_nat_irc,ip_nat_tftp,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_tftp,ip_conntrack_ftp, 
Live 0xe0912000
iptable_filter 6400 1 - Live 0xe08cb000
ip_tables 20352 10 
ipt_TOS,ipt_REJECT,ipt_pkttype,ipt_LOG,ipt_state,ipt_multiport,ipt_conntrack,iptable_mangle,iptable_nat,iptable_filter, 
Live 0xe08f7000
rtc 15304 0 - Live 0xe089c000
tg3 86148 0 - Live 0xe08cf000
sg 33440 0 - Live 0xe08ac000
ide_cd 40864 0 - Live 0xe08a1000

thanx for your help
