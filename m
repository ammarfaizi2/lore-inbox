Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbVLOFxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbVLOFxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbVLOFxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:53:46 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:23967 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161130AbVLOFxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:53:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Th9exp89WFbmVPD8mdycqBRwV8ubpVKFhKpz/vyu0GtXTi26bODRC3oWoK+iMkHKcLCHeCSStx2Z5HSFKHUVVbcZ90ezm4BW8FgkRaD9wlmCgKSPd58zsux7vym0s7tIGV8zFIlZCFLbfNDaul53sH0z8/aT+a3fj1WaxFofWUM=  ;
Message-ID: <43A104DC.7040203@yahoo.com.au>
Date: Thu, 15 Dec 2005 16:53:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: mpm@selenic.com, sri@us.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
References: <20051215033937.GC11856@waste.org>	<20051214.203023.129054759.davem@davemloft.net>	<20051215050250.GT8637@waste.org> <20051214.212309.127095596.davem@davemloft.net>
In-Reply-To: <20051214.212309.127095596.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Matt Mackall <mpm@selenic.com>
> Date: Wed, 14 Dec 2005 21:02:50 -0800
> 
> 
>>There needs to be two rules:
>>
>>iff global memory critical flag is set
>>- allocate from the global critical receive pool on receive
>>- return packet to global pool if not destined for a socket with an
>>  attached send mempool
> 
> 
> This shuts off a router and/or firewall just because iSCSI or NFS peed
> in it's pants.  Not really acceptable.
> 

But that should only happen (shut off a router and/or firewall) in cases
where we now completely deadlock and never recover, including shutting off
the router and firewall, because they don't have enough memory to recv
packets either.

> 
>>I think this will provide the desired behavior
> 
> 
> It's not desirable.
> 
> What if iSCSI is protected by IPSEC, and the key management daemon has
> to process a security assosciation expiration and negotiate a new one
> in order for iSCSI to further communicate with it's peer when this
> memory shortage occurs?  It needs to send packets back and forth with
> the remove key management daemon in order to do this, but since you
> cut it off with this critical receive pool, the negotiation will never
> succeed.
> 

I guess IPSEC would be a critical socket too, in that case. Sure
there is nothing we can do if the daemon insists on allocating lots
of memory...

> This stuff won't work.  It's not a generic solution and that's
> why it has more holes than swiss cheese. :-)

True it will have holes. I think something that is complementary and
would be desirable is to simply limit the amount of in-flight writeout
that things like NFS allows (or used to allow, haven't checked for a
while and there were noises about it getting better).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
