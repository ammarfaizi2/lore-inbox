Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbTCRJEz>; Tue, 18 Mar 2003 04:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbTCRJEz>; Tue, 18 Mar 2003 04:04:55 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:21136 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262290AbTCRJEs>; Tue, 18 Mar 2003 04:04:48 -0500
Date: Tue, 18 Mar 2003 20:16:01 +1100
From: CaT <cat@zip.com.au>
To: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       pekkas@netcore.fi
Subject: 2.5.65: sleeping function called from illegal context
Message-ID: <20030318091601.GE504@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if there was a fix produced for this, but this bug is still
present in 2.5.56:

kernel: eth0: no IPv6 routers present
kernel: Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
kernel: Call Trace:
kernel:  [__might_sleep+84/92] __might_sleep+0x54/0x5c
kernel:  [crypto_alg_lookup+33/208] crypto_alg_lookup+0x21/0xd0
kernel:  [crypto_alg_mod_lookup+13/52] crypto_alg_mod_lookup+0xd/0x34
kernel:  [crypto_alloc_tfm+17/192] crypto_alloc_tfm+0x11/0xc0
kernel:  [__ipv6_regen_rndid+160/500] __ipv6_regen_rndid+0xa0/0x1f4
kernel:  [wake_up_process+13/20] wake_up_process+0xd/0x14
kernel:  [ipv6_regen_rndid+46/196] ipv6_regen_rndid+0x2e/0xc4
kernel:  [run_timer_softirq+241/324] run_timer_softirq+0xf1/0x144
kernel:  [ipv6_regen_rndid+0/196] ipv6_regen_rndid+0x0/0xc4
kernel:  [do_softirq+81/176] do_softirq+0x51/0xb0
kernel:  [do_IRQ+244/272] do_IRQ+0xf4/0x110
kernel:  [default_idle+0/52] default_idle+0x0/0x34
kernel:  [default_idle+0/52] default_idle+0x0/0x34
kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
kernel:  [default_idle+0/52] default_idle+0x0/0x34
kernel:  [default_idle+0/52] default_idle+0x0/0x34
kernel:  [default_idle+38/52] default_idle+0x26/0x34
kernel:  [cpu_idle+53/68] cpu_idle+0x35/0x44
kernel:  [rest_init+0/92] _stext+0x0/0x5c
kernel:  [rest_init+85/92] _stext+0x55/0x5c
kernel: 
kernel: __ipv6_regen_rndid(): too short regeneration interval; timer diabled for eth0.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of Regime of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

