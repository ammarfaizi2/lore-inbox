Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbULHN1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbULHN1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbULHN1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:27:07 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:59087 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261208AbULHN1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:27:01 -0500
Date: Wed, 8 Dec 2004 14:26:57 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: jamal <hadi@cyberus.ca>, Robert Olsson <Robert.Olsson@data.slu.se>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, P@draigBrady.com
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041208132657.GB5036@soohrt.org>
References: <20041206205305.GA11970@soohrt.org> <20041207211035.GA20286@quickstop.soohrt.org> <1102480318.1050.16.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1102480318.1050.16.camel@jzny.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal wrote:
> On Tue, 2004-12-07 at 16:10, Karsten Desler wrote:
> > I totally forgot to mention: There are approximately 100k concurrent
> > flows.
> 
> ;-> Aha. That would make a huge difference. I know of noone
> who has actually done this level of testing. I have tried upto about 50K
> flows myself in early 2.6.x and was eventually compute bound.
> Really try compiling out totaly iptables/netfilter - it will make a
> difference.

Unfortunately I need netfilter (for now, I haven't had time to look into
replacing the rules with tc yet).

> You may also want to try something like LC trie algorithm that Robert
> and co are playing with to see if it makes a difference with this many
> flows.

On a scale of one to ten, one being "will crash on the first packet",
five being "will allow moderate load, but is probably going to crash
under high load" and ten being "rock stable" how would the patch be rated?
The announcement doesn't look too promising:
| Locking.
| Not yet done.

Also when looking at the profiles, fib_* isn't showing up at (not even
near) the top. Testworthy none the less?

ip route|wc -l:
40

profile:
     4 fib_validate_source                        0.0064
    39 fib_semantic_match                         0.1875
[...]
    76 ipt_route_hook                             1.5833
   219 __kmalloc                                  1.7109
   985 e1000_clean_tx_irq                         1.8107
   157 kmem_cache_alloc                           1.9625
   405 skb_release_data                           2.5312
   633 eth_type_trans                             2.6375
   394 handle_IRQ_event                           3.5179
  1017 __kfree_skb                                3.9727
   989 alloc_skb                                  4.1208
  1645 ip_route_input                             4.6733
  5128 ipt_do_table                               6.1635
  1678 e1000_intr                                 6.9917
   289 _read_unlock_bh                           18.0625
   616 _read_lock_bh                             19.2500
   418 _spin_lock                                26.1250
  2076 e1000_irq_enable                          43.2500
   881 _spin_unlock_irqrestore                   55.0625
 96895 default_idle                             1513.9844

Cheers,
 Karsten
