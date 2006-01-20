Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWATNxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWATNxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 08:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWATNxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 08:53:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37271 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750975AbWATNxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 08:53:09 -0500
Message-ID: <43D0EB32.5050909@redhat.com>
Date: Fri, 20 Jan 2006 08:52:50 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can you specify a local IP or Interface to be used on a per NFS
 mount basis?
References: <43CECB00.40405@candelatech.com>	 <1137631728.13076.1.camel@lade.trondhjem.org>	 <43CEF7A6.30802@candelatech.com>	 <1137641084.8864.3.camel@lade.trondhjem.org>	 <43CF0768.60703@candelatech.com> <1137644698.8864.8.camel@lade.trondhjem.org> <43D06687.2050108@candelatech.com>
In-Reply-To: <43D06687.2050108@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:

> Trond Myklebust wrote:
>
>> On Wed, 2006-01-18 at 19:28 -0800, Ben Greear wrote:
>>
>>
>>>> As David said, the place to fix it is in xs_bindresvport(), but 
>>>> there is
>>>> no support for passing this sort of information through the current 
>>>> NFS
>>>> binary mount structure. You would have to hack that up yourself.
>>>
>>>
>>> I can think of some horrible hacks to grab info out of a text file 
>>> based
>>> on the mount point or some other available info...but if I actually
>>> attempted to do it right..would you consider the patch for kernel
>>> inclusion?  Is it OK to modify the binary mount structure?
>>
>>
>>
>> It is possible, yes: the binary structure carries a version number that
>> allows the kernel to distinguish the various revisions that the userland
>> mount program supports.
>>
>> That said, the concensus at the moment appears to be that we should move
>> towards a text-based mount structure for NFS (like most of the other
>> filesystems have, and like NFSroot has) so I'd be reluctant to take
>> patches that define new binary structures.
>
>
> Ok.  This patch does extend the binary struct, and to do it really right,
> we should probably pass in some sort of in_addr struct instead of the
> single 'u32' for the IP address.
>
> So, please just consider this a proof of concept.  That said, with a
> patched 'mount' binary (diff available if anyone cares), this does
> do exactly what I want:  allows binding an nfs client to a particular
> local IP address.
>
> If/when you get the text based interface working, I will try to cook
> up an official patch worthy of inclusion if you have not already
> done so. 


These changes are very IPv4 specific.  Perhaps they could be constructed 
in a
bit more IP version agnostic fashion?  IPv6 is coming as well as other 
transport
choices, not all of whose addresses will fit into 32 bits.

    Thanx...

       ps
