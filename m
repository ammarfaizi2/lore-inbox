Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263467AbREYATm>; Thu, 24 May 2001 20:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263468AbREYATd>; Thu, 24 May 2001 20:19:33 -0400
Received: from stine.vestdata.no ([195.204.68.10]:65028 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S263467AbREYATT>; Thu, 24 May 2001 20:19:19 -0400
Date: Fri, 25 May 2001 02:18:42 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Chuck Wu <wu@cnds.jhu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two-machine cluster efficient approach(?) Comment? Thanks.
Message-ID: <20010525021840.C29754@vestdata.no>
In-Reply-To: <Pine.BSI.4.05L.10105241825270.25527-100000@commedia.cnds.jhu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.5i
In-Reply-To: <Pine.BSI.4.05L.10105241825270.25527-100000@commedia.cnds.jhu.edu>; from Chuck Wu on Thu, May 24, 2001 at 06:32:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 06:32:10PM -0400, Chuck Wu wrote:
> Two machines want to be accessed by the same IP address and
> share workload. Can not change the router. Can only change 
> local linux system. Will the following approach work? Thanks.

You should check out Linux Virtual Server; it does something simular
(only it doesn't reply to arp-requests with broadcast-address, but with
one of the servers' ethernet-address).

> Solution:
> ---------
> 1. Reserve an unused IP as the to be publicized "Server IP", actually no
>    machine takes it. So, it is kind of "virtual IP".
> 2. Alias the NIC of those two work stations to this "virtual IP" so they
>    can accept packets to this "virtual IP".
> 3. For ARP request packet to this "virtual IP", those two work stations
>    will return the MAC broadcast address. Then, all the packets to the
>    "virtual IP" will be broadcast to this subnet and those two machines
>    will get such packtes.
> 4. Before such packets gets into the TCP/IP stack, use a hash function
>    to filter the packets. Say, workstation A will accept packets whose
>    source IP is an odd number and discard the packets with even-number
>    source IP.

If this work, a useful addon would be to use something a little more
advanced, to allow it to scale to more than 2 servers.

> 5. For the outgoing packets from those two workstations, change the source
>    IP address to be the "virtual IP".
> 6. Have another thread keep ping each other, once another workstation
>    crashes, change my hash function to accept all the packets to the
>    "virtual IP". Whenever another workstation resumes, switch back to
>    the original hash function.
> 
>    Do you think if this approach will work? There is also a question I
> am not quite sure, can two machines's NICs be aliased to the same "virtual
> IP"? Will it cause some conflicts? And, it seems I need to change the
> linux kernel source code. I am not pretty sure where is the location of
> the source code related to the above operations. Like, can you tell me the
> location of the linux kernel source code to answer an ARP request packet,
> to build a hash function to filter the incoming IP packets before it
> enters the TCP/IP stack?


--
Ragnar Kjørstad
Big Storage
