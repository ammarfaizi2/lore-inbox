Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWF1RNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWF1RNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWF1RNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:13:23 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:38788 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932856AbWF1RNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:13:22 -0400
Message-ID: <44A2B7F6.8090702@candelatech.com>
Date: Wed, 28 Jun 2006 10:10:14 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Lezcano <dlezcano@fr.ibm.com>
CC: Kirill Korotaev <dev@sw.ru>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk, alexey@sw.ru
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <449FF5AE.2040201@fr.ibm.com> <44A28964.2090006@fr.ibm.com> <20060628183015.B31885@castle.nmd.msu.ru> <44A29379.6060609@sw.ru> <44A2B4D7.9080007@fr.ibm.com>
In-Reply-To: <44A2B4D7.9080007@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano wrote:
> Kirill Korotaev wrote:
> 
>>>>>> Structures related to IPv4 rounting (FIB and routing cache)
>>>>>> are made per-namespace.
>>>>
>>>>
>>>>
>>>> Hi Andrey,
>>>>
>>>> if the ressources are private to the namespace, how do you will 
>>>> handle NFS mounted before creating the network namespace ? Do you 
>>>> take care of that or simply assume you can't access NFS anymore ?
>>>
>>>
>>>
>>>
>>> This is a question that brings up another level of interaction between
>>> networking and the rest of kernel code.
>>> Solution that I use now makes the NFS communication part always run in
>>> the root namespace.  This is discussable, of course, but it's a far more
>>> complicated matter than just device lists or routing :)
>>
>>
>> if we had containers (not namespaces) then it would be also possible 
>> to run NFS in context of the appropriate container and thus each user 
>> could  mount NFS itself with correct networking context.

With a relatively small patch, I was able to make NFS bind to a particular
local IP (poor man's namespace with existing code).  I also changed it so
that multiple mounts to the same destination (and with unique local mount
points) are treated as unique mounts.  This patch was done so that I could
stress test NFS servers, but similar logic might work for namespace isolation
as well...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

