Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbULHLTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbULHLTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 06:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbULHLTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 06:19:22 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:12452 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261185AbULHLTR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 06:19:17 -0500
Date: Wed, 8 Dec 2004 12:18:32 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>,
       Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041208111832.GA13592@mail.muni.cz>
References: <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041202231837.GB15185@mail.muni.cz> <20041202161839.736352c2.akpm@osdl.org> <20041203121129.GC27716@mail.muni.cz> <41B6343A.9060601@cyberone.com.au> <20041207225932.GB12030@mail.muni.cz> <41B63738.2010305@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41B63738.2010305@cyberone.com.au>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 10:05:28AM +1100, Nick Piggin wrote:
> If you are able to test 2.6.10-rc3, that would be nice.

No better. min_free_kb is set by default to 3831 but I can still reproduce this:

swapper: page allocation failure. order:0, mode:0x20
 [<c0135472>] __alloc_pages+0x1b7/0x35b
 [<c013563b>] __get_free_pages+0x25/0x3f
 [<c0138725>] kmem_getpages+0x21/0xc9
 [<c0139253>] alloc_slabmgmt+0x55/0x5f
 [<c01393d2>] cache_grow+0xab/0x14d
 [<c01395f0>] cache_alloc_refill+0x17c/0x221
 [<c0139932>] __kmalloc+0x85/0x8c
 [<c02f49e9>] alloc_skb+0x47/0xe0
 [<c0294b97>] e1000_alloc_rx_buffers+0x44/0xe3
 [<c029489a>] e1000_clean_rx_irq+0x18e/0x447
 [<c02f4c37>] __kfree_skb+0x83/0x107
 [<c029447b>] e1000_clean+0x51/0xca
 [<c02fabbe>] net_rx_action+0x77/0xf6
 [<c011b8f7>] __do_softirq+0xb7/0xc6
 [<c0104979>] do_softirq+0x4a/0x59
 =======================
 [<c012f909>] irq_exit+0x3a/0x3c
 [<c0104875>] do_IRQ+0x4d/0x6a
 [<c0102ed6>] common_interrupt+0x1a/0x20
 [<c010050e>] default_idle+0x0/0x2c
 [<c0100537>] default_idle+0x29/0x2c
 [<c01005ac>] cpu_idle+0x3f/0x58
 [<c043fa20>] start_kernel+0x14c/0x165
 [<c043f4bd>] unknown_bootoption+0x0/0x1ab


-- 
Luká¹ Hejtmánek
