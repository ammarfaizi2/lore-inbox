Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWEPVt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWEPVt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWEPVt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:49:28 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:65202 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S932180AbWEPVt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:49:27 -0400
Date: Wed, 17 May 2006 00:49:09 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: events/0 eats 100% cpu on core duo laptop
In-Reply-To: <20060516122303.48b14dc1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605170041570.16352@tassadar.physics.auth.gr>
References: <Pine.LNX.4.64.0605162002150.9606@tassadar.physics.auth.gr>
 <20060516122303.48b14dc1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 	It seems that the issue occurs as soon as the nic is brought up:

Pid: 6, comm:             events/0
EIP: 0060:[<c02e9e6f>] CPU: 0
EIP is at __gm_phy_read+0x42/0x7b
  EFLAGS: 00000293    Not tainted  (2.6.16.16 #1)
EAX: 000004e8 EBX: 00002884 ECX: 7a7cd340 EDX: e0030000
ESI: 00000003 EDI: 00002880 EBP: c1617340 DS: 007b ES: 007b
CR0: 8005003b CR2: b7fd6ccb CR3: 005b4000 CR4: 000006d0
  [<c02e9ed8>] gm_phy_read+0x30/0x5b
  [<c02ec704>] sky2_phy_task+0x31/0x129
  [<c012dffc>] run_workqueue+0x76/0xea
  [<c02ec6d3>] sky2_phy_task+0x0/0x129
  [<c012e1b2>] worker_thread+0x142/0x164
  [<c0118fe0>] default_wake_function+0x0/0x12
  [<c0118fe0>] default_wake_function+0x0/0x12
  [<c012e070>] worker_thread+0x0/0x164
  [<c01317b9>] kthread+0xb7/0xbd
  [<c0131702>] kthread+0x0/0xbd
  [<c01011a1>] kernel_thread_helper+0x5/0xb

 	The nic was not working properly at bootup (it was unable to 
detect link,gain ip from dhcp) but I have discovered that adding an ifconfig
eth0 up prior to launching dhcp worked:

sky2 eth0: enabling interface
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control tx
sky2 eth0: disabling interface
sky2 eth0: phy read timeout
sky2 eth0: enabling interface
sky2 eth0: phy read timeout
sky2 eth0: speed/duplex mismatch<6>sky2 eth0: Link is up at 100 Mbps, full 
duplex, flow control tx

 	Also when I shutdown/reboot sky2 eth0: phy read timeout messages flood
  the console for a few seconds. The nic is detected as :

sky2 v0.15 addr 0xf0000000 irq 19 Yukon-EC Ultra(0xb4) rev 2

 	Best regards,

--
============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
============================================================================
