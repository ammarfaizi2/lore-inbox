Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUIVOOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUIVOOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUIVOOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:14:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265773AbUIVONh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:13:37 -0400
Date: Wed, 22 Sep 2004 10:13:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net, rusty@rustcorp.com.au, torvalds@osdl.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
In-Reply-To: <Pine.LNX.4.61.0409221556010.14486@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.53.0409221005260.25803@chaos.analogic.com>
References: <1095721742.5886.128.camel@bach> <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
 <1095803902.1942.211.camel@bach> <20040922003646.3a84f4c5.Ballarin.Marc@gmx.de>
 <20040921153600.2e732ea6.davem@davemloft.net> <20040922013516.753044db.Ballarin.Marc@gmx.de>
 <4150C448.5040604@trash.net> <20040922153707.2cc1d886.Ballarin.Marc@gmx.de>
 <Pine.LNX.4.61.0409221556010.14486@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Jesper Juhl wrote:

> On Wed, 22 Sep 2004, Marc Ballarin wrote:
>
> > Date: Wed, 22 Sep 2004 15:37:07 +0200
> > From: Marc Ballarin <Ballarin.Marc@gmx.de>
> > To: Patrick McHardy <kaber@trash.net>
> > Cc: davem@davemloft.net, rusty@rustcorp.com.au, torvalds@osdl.org,
> >     netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
> >
> > On Wed, 22 Sep 2004 02:16:08 +0200
> > Patrick McHardy <kaber@trash.net> wrote:
> >
> > > Fixed by this patch.
> >
> > Yes, works fine. Does this mean that ipchains was broken for a while, but
> > no one complained?
> >
> > Anyway, here is another trivial patch against -bk7 that adds runtime
> > warnings. IMO most users are going to miss compile time warnings, or
> > won't even compile kernels themselves.
> >
>
> I like having runtime info as well as a compile time warning, but maybe
> the message should mention that iptables is staying and people should
> migrate??
>
> > +	printk(KERN_WARNING
> > +		"Warning: ipchains is obsolete, and will be removed soon!\n");
> > +
>
> Perhaps something like this instead:
>
> "Warning: ipchains is obsolete, and will be removed soon. Please migrate to iptables."
>
>
> --
> Jesper Juhl

FYI. I just migrated to iptables. The code downloaded from the Debian
site did not compile cleanly, but enough worked to make most of the
shared libraries and the iptables executable.

The total time to do everything was slightly under 2 hours.

The errors from the distribution are:


cc -O2 -Wall -Wunused -I/usr/src/linux-2.4.26/include -Iinclude/ -DNETFILTER_VERSION=\"1.2.6a\"  -fPIC -o extensions/libipt_ECN_sh.o -c extensions/libipt_ECN.c
extensions/libipt_ECN.c: In function `parse':
extensions/libipt_ECN.c:51: `IPT_ECN_OP_REMOVE' undeclared (first use in this function)
extensions/libipt_ECN.c:51: (Each undeclared identifier is reported only once
extensions/libipt_ECN.c:51: for each function it appears in.)
extensions/libipt_ECN.c: In function `print':
extensions/libipt_ECN.c:82: `IPT_ECN_OP_REMOVE' undeclared (first use in this function)
extensions/libipt_ECN.c:83: warning: unreachable code at beginning of switch statement
extensions/libipt_ECN.c: In function `save':
extensions/libipt_ECN.c:99: `IPT_ECN_OP_REMOVE' undeclared (first use in this function)
extensions/libipt_ECN.c:100: warning: unreachable code at beginning of switch statement

make: [extensions/libipt_ECN_sh.o] Error 1 (ignored)
ld -shared -o extensions/libipt_ECN.so extensions/libipt_ECN_sh.o
ld: cannot open extensions/libipt_ECN_sh.o: No such file or directory
make: [extensions/libipt_ECN.so] Error 1 (ignored)


ip6tables.o: In function `addr_to_host':
ip6tables.o(.text+0x4d8): undefined reference to `getnameinfo'
ip6tables.o: In function `parse_hostnetworkmask':
ip6tables.o(.text+0x731): undefined reference to `in6addr_any'
ip6tables.o: In function `print_firewall':
ip6tables.o(.text+0x19e7): undefined reference to `in6addr_any'
collect2: ld returned 1 exit status
make: [ip6tables] Error 1 (ignored)


The build command was:

#
#!/bin/sh
#
#make pending-patches KERNEL_DIR=/usr/src/linux-`uname -r`
make -i  KERNEL_DIR=/usr/src/linux-`uname -r`


The pending patches resulted in many rejects but the kernel
was virgin 2.4.26.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

