Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTDMUFE (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 16:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTDMUFE (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 16:05:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25547 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261895AbTDMUFD (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 16:05:03 -0400
Date: Sun, 13 Apr 2003 22:16:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.67-mm2: multiple definition of `ipip_err'
Message-ID: <20030413201643.GP9640@fs.tum.de>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030412180852.77b6c5e8.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
>...
>  linus.patch
> 
>  Latest -bk
>...

The following compile error seems to come from Linus' tree:

<--  snip  -->

...
   ld -m elf_i386  -r -o net/ipv4/built-in.o net/ipv4/utils.o 
net/ipv4/route.o net/ipv4/inetpeer.o net/ipv4/protocol.o 
net/ipv4/ip_input.o net/ipv4/ip_fragment.o net/ipv4/ip_forward.o 
net/ipv4/ip_options.o net/ipv4/ip_output.o net/ipv4/ip_sockglue.o 
net/ipv4/tcp.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o 
net/ipv4/tcp_timer.o net/ipv4/tcp_ipv4.o net/ipv4/tcp_minisocks.o 
net/ipv4/tcp_diag.o net/ipv4/raw.o net/ipv4/udp.o net/ipv4/arp.o 
net/ipv4/icmp.o net/ipv4/devinet.o net/ipv4/af_inet.o net/ipv4/igmp.o 
net/ipv4/sysctl_net_ipv4.o net/ipv4/fib_frontend.o 
net/ipv4/fib_semantics.o net/ipv4/fib_hash.o net/ipv4/proc.o 
net/ipv4/fib_rules.o net/ipv4/ip_nat_dumb.o net/ipv4/ipmr.o 
net/ipv4/ipip.o net/ipv4/ip_gre.o net/ipv4/syncookies.o net/ipv4/ah.o 
net/ipv4/esp.o net/ipv4/ipcomp.o net/ipv4/ipconfig.o 
net/ipv4/netfilter/built-in.o net/ipv4/xfrm4_policy.o 
net/ipv4/xfrm4_state.o net/ipv4/xfrm4_input.o net/ipv4/xfrm4_tunnel.o
net/ipv4/xfrm4_tunnel.o(.text+0x700): In function `ipip_err':
: multiple definition of `ipip_err'
net/ipv4/ipip.o(.text+0x400): first defined here
ld: Warning: size of symbol `ipip_err' changed from 179 to 34 in 
net/ipv4/xfrm4_tunnel.o
make[2]: *** [net/ipv4/built-in.o] Error 1

<--  snip  -->


Besides the ipip_err that was already in net/ipv4/ipip.c there's now a 
second one in net/ipv4/xfrm4_tunnel.c .


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

