Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281473AbRKHF5A>; Thu, 8 Nov 2001 00:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281474AbRKHF4t>; Thu, 8 Nov 2001 00:56:49 -0500
Received: from mail016.syd.optusnet.com.au ([203.2.75.176]:18091 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S281473AbRKHF4g>; Thu, 8 Nov 2001 00:56:36 -0500
Date: Thu, 8 Nov 2001 16:56:31 +1100
From: Andrew Pam <xanni@glasswings.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipchains.o dependencies problem from 1999 (!) returns in 2.4.14 kernel
Message-ID: <20011108165631.P673@kira.glasswings.com.au>
In-Reply-To: <20011108125851.K673@kira.glasswings.com.au> <20011107.213534.83623888.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107.213534.83623888.davem@redhat.com>; from davem@redhat.com on Wed, Nov 07, 2001 at 09:35:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 09:35:34PM -0800, David S. Miller wrote:
>    From: Andrew Pam <xanni@glasswings.com.au>
>    Date: Thu, 8 Nov 2001 12:58:51 +1100
> 
>    In the 2.4.14 kernel, I get the following dependency problems with ipchains.o:
>    
>    [root@TekTih root]# depmod -ae
>    depmod: *** Unresolved symbols in /lib/modules/2.4.14+ext3/kernel/net/ipv4/netfilter/ipchains.o
>    depmod:         netlink_kernel_create
>    depmod:         netlink_broadcast
>    
>    Note that this happens regardless of the setting of CONFIG_NETLINK and
>    CONFIG_NETLINK_DEV, whether "n", "m" or "y".
> 
> Something is wrong with your modutils then.
> 
> Because net/netsyms.c exports netlink_kernel_create when
> CONFIG_NETLINK is set.  It is impossible for the symbol to be
> unresolved if you are turning on CONFIG_NETLINK.
> 
> Franks a lot,
> David S. Miller
> davem@redhat.com

On Thu, 08 Nov 2001 13:55:39 +1100,
Keith Owens <kaos@ocs.com.au> wrote:

> Works for me with your config.  At a guess, you have been bitten by the
> broken kernel Makefiles - http://www.tux.org/lkml/#s8-8

Sure enough, that's what it turned out to be.  I replied:

> Yep, that's cured it!  Is this one of the things fixed by kbuild 2.5?
> If so, when will it actually be in the Linus tarballs?

Cheers,
	Andrew
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/sc/                   Manager, Serious Cybernetics
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
