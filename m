Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVBTN1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVBTN1d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 08:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBTN1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 08:27:33 -0500
Received: from rayleigh.systella.fr ([213.41.173.141]:15786 "EHLO
	rayleigh.systella.fr") by vger.kernel.org with ESMTP
	id S261829AbVBTN1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 08:27:08 -0500
Date: Sun, 20 Feb 2005 14:27:05 +0100
From: BERTRAND =?iso-8859-1?Q?Jo=EBl?= <mt1@systella.fr>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.29 (Sparc64) and iproute
Message-ID: <20050220132705.GC20204@rayleigh.systella.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (rayleigh.systella.fr [127.0.0.1]); Sun, 20 Feb 2005 14:27:05 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I'm trying to use iproute (20041019) with 2.4.29 official kernel on
	a UltraSparc 1E. I have marked all packets that come from an
	intranet server (192.168.0.130:3000 / tcp) like this :

Chain PREROUTING (policy ACCEPT 13344 packets, 1830K bytes)
 pkts bytes target     prot opt in     out     source
destination         
   89  5340 MARK       tcp  --  *      *       192.168.0.130
0.0.0.0/0           tcp spts:3000:3001 MARK set 0x1 

	And I have logged the result of iptables. All packets are marked.
	So, I have written a new rule with iproute :

Root kant:[/var/log] > ip rule show
0:      from all lookup local 
100:    from 192.168.1.1 lookup intranet 
101:    from all fwmark 0x1 lookup intranet 
32766:  from all lookup main 
32767:  from all lookup default 
Root kant:[/var/log] > ip route show table intranet
default via 192.168.1.254 dev eth2 
Root kant:[/var/log] > 

	My intranet table is ignored. But I can use the second interface. If
	I replace "from all fwmark 0x1 lookup intranet" by ""from
	192.168.0.130 lookup intranet", all packets coming from my intranet
	server all redirected conforming to intranet table. Any idea ? Is
	iproute broken with 2.4.29 ?

	Thanks in advance,

	JKB
