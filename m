Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKOXep>; Wed, 15 Nov 2000 18:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbQKOXef>; Wed, 15 Nov 2000 18:34:35 -0500
Received: from [213.8.185.152] ([213.8.185.152]:14854 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129103AbQKOXeW>;
	Wed, 15 Nov 2000 18:34:22 -0500
Date: Thu, 16 Nov 2000 01:03:29 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Guus Sliepen <guus@warande3094.warande.uu.nl>
cc: linux-kernel <linux-kernel@vger.kernel.org>, netfilter@us5.samba.org
Subject: Re: (iptables) ip_conntrack bug?
In-Reply-To: <20001115221922.L13682@sliepen.warande.net>
Message-ID: <Pine.LNX.4.21.0011160043450.15582-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Guus Sliepen wrote:

> > I was DDoS'd today while away and came home to find the firewall unable to
> > do anything network related (although my connection to irc was still
> > working oddly).  a quick dmesg showed the problem.
> > ip_conntrack: maximum limit of 2048 entries exceeded
> [...]
> 
> I have also seen this happen on a box which ran test9. Apparently because of
> it's long uptime, because the logs should no signs of an attack.
> 
> I guess conntrack forgets to flush some entries? Or maybe there is no way it can
> recover from a full conntrack table? Is it maybe necessary to make the maximum
> size a configurable option? Or a userspace conntrack daemon like the arpd?

>From reading the sources I got the impression that the use count of
the ip_conntrack struct isn't decremented properly. This causes
destroy_conntrack() not to free ip_conntrack's - which results allocation
until the maximum (ip_conntrack_max), and failing to allocate new ones.

p.s. Get a popcorn when you're reading netfilter's sources - bumping into
a label like 'i_see_dead_people' is quite amusing...

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
