Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbREOUti>; Tue, 15 May 2001 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261494AbREOUt3>; Tue, 15 May 2001 16:49:29 -0400
Received: from coruscant.franken.de ([193.174.159.226]:40454 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S261482AbREOUtS>; Tue, 15 May 2001 16:49:18 -0400
Date: Sun, 13 May 2001 19:39:56 -0300
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
Message-ID: <20010513193956.P26722@corellia.laforge.distro.conectiva>
In-Reply-To: <3AF4720F.35574FDD@candelatech.com> <15092.32371.139915.110859@pizda.ninka.net> <3AF49617.1B3C48AF@candelatech.com> <15092.37426.648280.631914@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <15092.37426.648280.631914@pizda.ninka.net>; from davem@redhat.com on Sat, May 05, 2001 at 04:52:18PM -0700
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Sweetmorn, the 58th day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 04:52:18PM -0700, David Miller wrote:

>  > No idea, haven't tried to use netfilter.  With this patch, though,
>  > it's as easy as:
> 
> I know, the problem is if some existing facility can be made
> to do it, I'd rather it be done that way.

of course.

> I'd be interested in seeing netfilter rules or a new netfilter
> kernel module which would do arpfilter as well.

the problem is, that netfilter hooks are currently only in the IPv4
and IPv6 packet paths. as ARP is not an IPv4 protocol, but another
protocol residing at layer 3, the arp code bypasses all netfilter hooks,
and is - as a result - not handled by any IP tables.

If you would want to do it using netfilter (the hooks only) and a hook-
attaching module, you need to add ARP netfilter hooks first.

If you want to filter arp packets, you need the netfilter hooks in the ARP
code, as well as a new 'arptables' module and a userspace tool allowing
modification of those arp tables.

So I see no clean solution for using netfilter in this case. It's one
of the scenario where netfilter/iptables layer-three-protocol boundness
hurts.

> David S. Miller

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
