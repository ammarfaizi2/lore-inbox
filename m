Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131492AbRAXM3Z>; Wed, 24 Jan 2001 07:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131253AbRAXM3O>; Wed, 24 Jan 2001 07:29:14 -0500
Received: from coruscant.franken.de ([193.174.159.226]:62214 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S130153AbRAXM3H>; Wed, 24 Jan 2001 07:29:07 -0500
Date: Wed, 24 Jan 2001 13:27:53 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Scaramanga <scaramanga@barrysworld.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@us5.samba.org
Subject: Re: Firewall netlink question...
Message-ID: <20010124132753.U6055@coruscant.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Scaramanga <scaramanga@barrysworld.com>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
In-Reply-To: <20010122073343.A3839@lemsip.lan> <Pine.LNX.4.21.0101221045380.25503-100000@titan.lahn.de> <20010122102600.A4458@lemsip.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010122102600.A4458@lemsip.lan>; from scaramanga@barrysworld.com on Mon, Jan 22, 2001 at 10:26:00AM +0000
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Pungenday, the 13rd day of Chaos in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2001 at 10:26:00AM +0000, Scaramanga wrote:
> 
> Yeah, after some quick googling and freshmeating, i came accross a daemon
> that picked up these QUEUEd packets and multiplexed them to various child
> processes, which seemed very innefcient, the documentation said something
> about QUEUE not being multicast in nature, like the old firewall netlink.

ah... you are referring to my ipqmpd (ip queue multiplex daemon). Yes, it
is not very efficient. But it is right now the only way to have multiple
processes using the ip_queue. 

The ideal solution is a queue handler which does in fact handle more than
one queue from inside the kernel. Unfortunately nobody got around writing
it yet. 

> What was wrong with the firewall netlink? My re-implementation works great
> here. I can't see why anything else would be needed, QUEUE seems twice as
> complex. Unless with QUEUE the userspce applications can make decisions on
> what to do with the packet? In which case, it would be far too inefficient
> for an application like mine, where all i need is to be able to read the
> IP datagrams..

well... the ip_queue module as opposed to your implementation as iptables
target has the following advantages:

- can be used from each netfilter-hook attached code (not only from 
  an ip table)
- is more generic (you can register different queue handler, ipv6, ...)

btw: please move this discussion to netfilter-devel@lists.samba.org

> Regards

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
