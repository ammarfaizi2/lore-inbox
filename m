Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTCaWYT>; Mon, 31 Mar 2003 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbTCaWYT>; Mon, 31 Mar 2003 17:24:19 -0500
Received: from dyn-ctb-210-9-246-105.webone.com.au ([210.9.246.105]:14852 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261874AbTCaWYS>;
	Mon, 31 Mar 2003 17:24:18 -0500
Message-ID: <3E88C29A.7050308@cyberone.com.au>
Date: Tue, 01 Apr 2003 08:35:06 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Helge Hafting <helgehaf@aitel.hist.no>, erik@hensema.net,
       linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net> <20030328231248.GH5147@zaurus.ucw.cz> <slrnb8gbfp.1d6.erik@bender.home.hensema.net> <3E8845A8.20107@aitel.hist.no> <3E88BAF9.8040100@cyberone.com.au> <3E88BFA9.5010003@nortelnetworks.com>
In-Reply-To: <3E88BFA9.5010003@nortelnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Friesen wrote:

> Nick Piggin wrote:
>
>> I haven't thought about this much, but it seems to me that
>> doing writeout whenever the disk would otherwise be idle
>> (and we have dirty memory to write out) would be a good
>> solution.
>
>
> The whole argument about waiting though is that there may be another 
> write coming to the same place, in which case you could save the cost 
> of the first write because it didn't have to be written.
>
> Writing to disk isn't free, even if the disk would otherwise be idle.  
> You have the cost of the setup as well as the memory and pci bus 
> traffic.  You may have disk bandwidth available but be already maxing 
> out the PCI bus, in which case your "free" disk write takes I/O away 
> from other things. 

Only if the memory gets dirtied again, otherwise the earlier the better. 
If the
memory does get written to again before the writeout timeout then yeah 
its used
some cpu, memory, pci, etc that it didn't have to.

>
>
> Ultimately its all a tradeoff.  Do you write now, or do you hold off 
> and hope that you can throw away some of the writes because new stuff 
> will home in to overwrite them?

Yes it is a tradeoff. Having an idle disk gives more weight to "write now".

