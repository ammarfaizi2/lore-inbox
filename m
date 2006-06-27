Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWF0QKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWF0QKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWF0QKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:10:50 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:63905 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1161141AbWF0QKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:10:48 -0400
Message-ID: <44A157CA.70204@candelatech.com>
Date: Tue, 27 Jun 2006 09:07:38 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <m1hd27uaxw.fsf@ebiederm.dsl.xmission.com> <20060626183649.GB3368@MAIL.13thfloor.at> <m1u067r9qk.fsf@ebiederm.dsl.xmission.com> <44A05BFD.6030402@candelatech.com> <20060626225440.GA7425@MAIL.13thfloor.at> <44A068E7.6080403@candelatech.com>
In-Reply-To: <44A068E7.6080403@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> Herbert Poetzl wrote:
> 
>> On Mon, Jun 26, 2006 at 03:13:17PM -0700, Ben Greear wrote:
> 
> 
>> yes, that sounds good to me, any numbers how that
>> affects networking in general (performance wise and
>> memory wise, i.e. caches and hashes) ...
> 
> 
> I'll run some tests later today.  Based on my previous tests,
> I don't remember any significant overhead.

Here's a quick benchmark using my redirect devices (RDD).  Each
RDD comes in a pair...when you tx on one, the pkt is rx'd on the peer.
The idea is that it is exactly like two physical ethernet interfaces
connected by a cross-over cable.

My test system is a 64-bit dual-core Intel system, 3.013 Ghz processor with 1GB RAM.
Fairly standard stuff..it's one of the Shuttle XPC systems.
Kernel is 2.6.16.16 (64-bit).


Test setup is:  rdd1 -- rdd2   [bridge]   rdd3 -- rdd4

I am using my proprietary module for the bridge logic...and the default
bridge should be at least this fast.  I am injecting 1514 byte packets
on rdd1 and rdd4 with pktgen (bi-directional flow).  My pktgen is also
receiving the pkts and gathering stats.

This setup sustains 1.7Gbps of generated and received traffic between
rdd1 and rdd4.

Running only the [bridge] between two 10/100/1000 ports on an Intel PCI-E
NIC will sustain about 870Mbps (bi-directional) on this system, so the
virtual devices are quite efficient, as suspected.

I have not yet had time to benchmark the mac-vlans...hopefully later today.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

