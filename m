Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTFXUTT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTFXUTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:19:19 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:53767 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262601AbTFXUTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:19:13 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200306242033.QAA27440@clem.clem-digital.net>
Subject: Re: 2.5.73 -- Uninitialised timer! (i386)
In-Reply-To: <20030624124800.72bfb98d.akpm@digeo.com> from Andrew Morton at "Jun 24, 2003 12:48: 0 pm"
To: akpm@digeo.com (Andrew Morton)
Date: Tue, 24 Jun 2003 16:33:19 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton
  > 
  > Well it beats me.  That timer is clearly initialised OK.
  > 
  > What compiler version are you using?  Can you try
  > a different one>?

Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

Only compiler currently installed.  Have four systems (3 single
processor, 1 dual) all running Debian--woody with same versions.
On the UP systems, will see several of these traces during boot.
After that, it is very seldom (0 to 3 in 12 hours). Have seen none
on the SMP system.  Recompiled one of the UP systems with SMP
enabled and no longer saw the trace during boot and post. Have
not seen this prior to 2.5.73.

  > 
  > 
  > Pete Clements <clem@clem.clem-digital.net> wrote:
  > >
  > > Quoting Andrew Morton
  > >   > >
  > >   > > FYI:
  > >   > > 
  > >   > > With 2.5.73 (i386) have picked up an 'Uninitialised timer!'
  > >   > > message with associated 'Call Trace:'. Only see this on
  > >   > > systems complied as UP.  
  > >   > 
  > >   > So what is the call trace?
  > >   > 
  > >   > make sure you have CONFIG_KALLSYMS=y
  > >   > 
  > > 
  > > They all start off with check_timer_failed, then various 
  > > subsystems.  Here is one example:
  > > 
  > > 
  > > Uninitialised timer!
  > > This is just a warning.  Your computer is OK
  > > function=0xc8866e0c, data=0x0
  > > Call Trace:
  > >  [check_timer_failed+64/76] check_timer_failed+0x40/0x4c
  > >  [_end+139703180/1070409088] fib6_run_gc+0x0/0xb4 [ipv6]
  > >  [_end+139846020/1070409088] ip6_fib_timer+0x0/0x1c [ipv6]
  > >  [mod_timer+39/144] mod_timer+0x27/0x90
  > >  [_end+139846020/1070409088] ip6_fib_timer+0x0/0x1c [ipv6]
  > >  [_end+139700888/1070409088] fib6_add+0x74/0xbc [ipv6]
  > >  [_end+139846020/1070409088] ip6_fib_timer+0x0/0x1c [ipv6]
  > >  [_end+139690360/1070409088] rt6_ins+0x28/0x38 [ipv6]
  > >  [_end+139845460/1070409088] ip6_routing_table+0x0/0x1c [ipv6]
  > >  [_end+139690546/1070409088] rt6_cow+0xaa/0xd0 [ipv6]
  > >  [_end+139690981/1070409088] ip6_route_input+0x18d/0x1cc [ipv6]
  > >  [_end+139671818/1070409088] gcc2_compiled.+0x15a/0x1cc [ipv6]
  > >  [netif_receive_skb+351/400] netif_receive_skb+0x15f/0x190
  > >  [_end+139846080/1070409088] fib6_gc_lock+0x0/0x18 [ipv6]
  > >  [process_backlog+106/256] process_backlog+0x6a/0x100
  > >  [net_rx_action+109/260] net_rx_action+0x6d/0x104
  > >  [do_softirq+90/172] do_softirq+0x5a/0xac
  > >  [do_IRQ+224/240] do_IRQ+0xe0/0xf0
  > >  [default_idle+0/44] default_idle+0x0/0x2c
  > >  [rest_init+0/28] _stext+0x0/0x1c
  > >  [common_interrupt+24/32] common_interrupt+0x18/0x20
  > >  [default_idle+0/44] default_idle+0x0/0x2c
  > >  [rest_init+0/28] _stext+0x0/0x1c
  > >  [default_idle+38/44] default_idle+0x26/0x2c
  > >  [cpu_idle+38/56] cpu_idle+0x26/0x38
  > >  [rest_init+25/28] _stext+0x19/0x1c
  > >  [start_kernel+298/304] start_kernel+0x12a/0x130
  > > 

-- 
Pete Clements 
clem@clem.clem-digital.net
