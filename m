Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVANWug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVANWug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVANWtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:49:06 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:16649 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S261487AbVANWr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:47:59 -0500
Message-ID: <41E84C1D.9060505@superbug.co.uk>
Date: Fri, 14 Jan 2005 22:47:57 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: Steve Iribarne <steve.iribarne@dilithiumnetworks.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: ARP routing issue
References: <B8561865DB141248943E2376D0E85215846787@DHOST001-17.DEX001.intermedia.net> <200501061711.59301.lkml@kcore.org>
In-Reply-To: <200501061711.59301.lkml@kcore.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
> On Thursday 06 January 2005 17:06, Steve Iribarne wrote:
> 
>>Hi Jan,
>>
>>
>>-> default gateway is set to 10.0.22.1, on eth0.
>>->
>>-> Problem is, if I try to ping from another network
>>-> (10.216.0.xx) to 10.0.24.xx, i see the following ARP request:
>>->
>>-> arp who-has 10.0.22.1 tell 10.0.24.xx
>>->
>>
>>You see that coming out the eth0 interface??
>>
>>If that is the case it is most definately wrong.  Assuming that your
>>masks are setup properly.  But I haven't worked on the 2.4 kernel for a
>>long time so I'm not so sure if what you are seeing is a bug that has
>>been fixed.
> 
> 
> The network information is:
> eth0 10.0.22.xxx mask 255.255.255.0
> eth1 10.0.24.xxx mask 255.255.255.0
> 
> routing:
> 10.0.22.0 0.0.0.0 255.255.255.0 eth0
> 10.0.24.0 0.0.0.0 255.255.255.0 eth1
> 0.0.0.0  10.0.22.1 0.0.0.0  eth0
> 
> Jan
> 

That arp is perfectly OK.
The routing table will cause the icmp echo packet to go from 10.216.0.xx 
to 10.0.24.xx via the 10.0.24.x network.
The icmp echo response will return via the 10.0.22.x network back to the 
10.216.0.xx network.
So the paths in each direction are different.

the "arp who-has 10.0.22.1 tell 10.0.24.xx", you can safely ignore the 
"10.0.24.xx" bit, as that will be ignored by the device responding to 
the ARP.
It is just highlighting the point that you have 2 paths to the same 
destination.

Cheers

James

