Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268093AbTCFNKR>; Thu, 6 Mar 2003 08:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268095AbTCFNKQ>; Thu, 6 Mar 2003 08:10:16 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:20938 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S268093AbTCFNKJ>; Thu, 6 Mar 2003 08:10:09 -0500
Date: Fri, 7 Mar 2003 00:19:48 +1100
From: CaT <cat@zip.com.au>
To: pekkas@netcore.fi, pavel@suse.cz, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.64 - ipv6/sleep related oops?
Message-ID: <20030306131948.GB464@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just looked through dmesg and noticed the following:

e100: eth0 NIC Link is Down
e100: eth0 NIC Link is Up 100 Mbps Full duplex
e100: eth0 NIC Link is Down
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.ISA_.EC0_._Q03] (Node c12ca154), AE_BAD_PARAMETER
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0421 [25] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.ISA_.EC0_._Q03] (Node c12ca154), AE_BAD_PARAMETER
e100: eth0 NIC Link is Up 100 Mbps Full duplex
Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c011f8e8>] __might_sleep+0x54/0x5c
 [<c0220a91>] crypto_alg_lookup+0x21/0xd0
 [<c02218e9>] crypto_alg_mod_lookup+0xd/0x34
 [<c0220c5d>] crypto_alloc_tfm+0x11/0xc0
 [<c0404cf0>] __ipv6_regen_rndid+0xa0/0x1f4
 [<c011cd1d>] wake_up_process+0xd/0x14
 [<c0404e72>] ipv6_regen_rndid+0x2e/0xc4
 [<c012ba5b>] run_timer_softirq+0x1c3/0x2d8
 [<c0404e44>] ipv6_regen_rndid+0x0/0xc4
 [<c0127441>] do_softirq+0x51/0xb0
 [<c010c3b1>] do_IRQ+0x2d1/0x2ec
 [<c0108034>] default_idle+0x0/0x34
 [<c0108034>] default_idle+0x0/0x34
 [<c010ab94>] common_interrupt+0x18/0x20
 [<c0108034>] default_idle+0x0/0x34
 [<c0108034>] default_idle+0x0/0x34
 [<c010805a>] default_idle+0x26/0x34
 [<c01080e9>] cpu_idle+0x35/0x44
 [<c0105000>] _stext+0x0/0xcc
 [<c01050c5>] _stext+0xc5/0xcc

__ipv6_regen_rndid(): too short regeneration interval; timer diabled for eth0.

There is no IPv6 stuff set on eth0 atm. (ie the system is configured for
IPv4 still as I haven't gotten around to toying with IPv6 yet)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

