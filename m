Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318217AbSHSJrh>; Mon, 19 Aug 2002 05:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318218AbSHSJrh>; Mon, 19 Aug 2002 05:47:37 -0400
Received: from aurora.dnttm.ro ([193.226.98.1]:43535 "EHLO aurora.dnttm.ro")
	by vger.kernel.org with ESMTP id <S318217AbSHSJrh>;
	Mon, 19 Aug 2002 05:47:37 -0400
Date: Mon, 19 Aug 2002 12:51:38 +0300 (EEST)
From: Dan Borlovan <danb@dnttm.ro>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.20 fwmark corruption?
Message-ID: <Pine.LNX.4.33.0208191240270.15434-100000@aurora.dnttm.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.3(snapshot 20020312) (office.dnttm.ro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

In order to redirect traffic to a transparent proxy, I'm using ipchains to 
set fwmark on packet, and an ip rule to throw those packets into an 
alternate routing table. The simplified setup looks like this:

- host R has 4 ethernet cards, eth0 .. eth3

- on eth1 there are host G (the default gateway) and host P (the 
transparent proxy)

- ipchains takes all packets that a) have proto tcp, dport 80 b) do not
have daddr on local networks and c) have a specified saddr - and sets
fwmark to 1

- routing table 1 contains only a default route with nexthost host P

- the is an "ip rule add fwmark 1 table 1"

The problem: couple of times a day I get entries in rt_cache that look
like "from (some interface of) host R to some host in directly connected
networks on eth0, eth2, eth3 via host P" - as if somehow those packets
were marked and got caught by the ip rule. But they cannot be marked,
because of the ipchains "daddr is not local" restriction (and remember
this happens only from time to time)

Changing the rule to something like "ip rule add from
same_specific_saddr_as_in_ipchains fwmark 1 table 1", though this is
redundant, makes the problem go away.

So, is there any way packets that do not match the ipchains rule get 
somehow from time to time a fwmark value of 1?

Dan
-- 
Dan Borlovan <danb@dnttm.ro>
System Administrator, Network Operation Center
Dynamic Network Technologies - ASTRAL TELECOM
Telefon: +40-256-204967  FAX: +40-256-220201

