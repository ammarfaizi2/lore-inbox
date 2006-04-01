Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWDAJSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWDAJSu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 04:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWDAJSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 04:18:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750892AbWDAJSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 04:18:49 -0500
Date: Sat, 1 Apr 2006 11:18:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Athanasius <link@miggy.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, coreteam@netfilter.org
Cc: netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: netfilter: IP_NF_CONNTRACK_NETLINK=y, IP_NF_NAT=m compile error
Message-ID: <20060401091847.GC28310@stusta.de>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <20060328163932.GJ28030@miggy.org> <20060331170916.GL28030@miggy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331170916.GL28030@miggy.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 06:09:16PM +0100, Athanasius wrote:
> On Tue, Mar 28, 2006 at 05:39:32PM +0100, Athanasius wrote:
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > net/built-in.o(.text+0x7c990): In function `ctnetlink_parse_nat_proto':
> > : undefined reference to `ip_nat_proto_find_get'
> > net/built-in.o(.text+0x7c9b2): In function `ctnetlink_parse_nat_proto':
> > : undefined reference to `ip_nat_proto_put'
> > net/built-in.o(.text+0x7d695): In function `ctnetlink_change_conntrack':
> > : undefined reference to `ip_nat_setup_info'
> > net/built-in.o(.text+0x7da9f): In function `ctnetlink_create_conntrack':
> > : undefined reference to `ip_nat_setup_info'
> > make: *** [.tmp_vmlinux1] Error 1
> ...
> > CONFIG_IP_NF_TARGET_TCPMSS=m
> > CONFIG_IP_NF_NAT=m
> > CONFIG_IP_NF_NAT_NEEDED=y
> > CONFIG_IP_NF_TARGET_MASQUERADE=m
> 
> ...
> 
>   It looks like the problem was that "CONFIG_IP_NF_NAT=m".  I changed
> this to 'y' and things look to be compiling fine now.
>...

First of all thanks for your report.

More exactly, it's the combination CONFIG_IP_NF_CONNTRACK_NETLINK=y, 
CONFIG_IP_NF_NAT=m.

Can someone who understands the netfilter dependencies please look into 
this bug?

It's present in both 2.6.16.1 and 2.6.16-mm2.
 
> -Ath

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

