Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262439AbREXWcf>; Thu, 24 May 2001 18:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262441AbREXWcZ>; Thu, 24 May 2001 18:32:25 -0400
Received: from [128.220.231.250] ([128.220.231.250]:1751 "EHLO
	commedia.cnds.jhu.edu") by vger.kernel.org with ESMTP
	id <S262439AbREXWcK>; Thu, 24 May 2001 18:32:10 -0400
Date: Thu, 24 May 2001 18:32:10 -0400 (EDT)
From: Chuck Wu <wu@cnds.jhu.edu>
To: linux-kernel@vger.kernel.org
Subject: Two-machine cluster efficient approach(?) Comment? Thanks.
Message-ID: <Pine.BSI.4.05L.10105241825270.25527-100000@commedia.cnds.jhu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two machines want to be accessed by the same IP address and
share workload. Can not change the router. Can only change 
local linux system. Will the following approach work? Thanks.

Solution:
---------
1. Reserve an unused IP as the to be publicized "Server IP", actually no
   machine takes it. So, it is kind of "virtual IP".
2. Alias the NIC of those two work stations to this "virtual IP" so they
   can accept packets to this "virtual IP".
3. For ARP request packet to this "virtual IP", those two work stations
   will return the MAC broadcast address. Then, all the packets to the
   "virtual IP" will be broadcast to this subnet and those two machines
   will get such packtes.
4. Before such packets gets into the TCP/IP stack, use a hash function
   to filter the packets. Say, workstation A will accept packets whose
   source IP is an odd number and discard the packets with even-number
   source IP.
5. For the outgoing packets from those two workstations, change the source
   IP address to be the "virtual IP".
6. Have another thread keep ping each other, once another workstation
   crashes, change my hash function to accept all the packets to the
   "virtual IP". Whenever another workstation resumes, switch back to
   the original hash function.

   Do you think if this approach will work? There is also a question I
am not quite sure, can two machines's NICs be aliased to the same "virtual
IP"? Will it cause some conflicts? And, it seems I need to change the
linux kernel source code. I am not pretty sure where is the location of
the source code related to the above operations. Like, can you tell me the
location of the linux kernel source code to answer an ARP request packet,
to build a hash function to filter the incoming IP packets before it
enters the TCP/IP stack?

   Thanks a lot.

best,
chuck

