Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbUCRSAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbUCRSAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:00:53 -0500
Received: from ftp.czame.czame.com ([64.33.120.2]:5904 "EHLO czame.czame.com")
	by vger.kernel.org with ESMTP id S262823AbUCRSAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:00:46 -0500
Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <482A3FA0050D21419C269D13989C61130435DD8A@lavender-fe.eng.netapp.com>
References: <482A3FA0050D21419C269D13989C61130435DD8A@lavender-fe.eng.netapp.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2A704E32-7906-11D8-97E9-000A95CFFC9C@idtect.com>
Content-Transfer-Encoding: 7bit
From: Charles-Edouard Ruault <ce@idtect.com>
Subject: Re: [NFS] Re: Linux 2.4.25, nfs client hangs when talking to a MacOS nfs server.
Date: Thu, 18 Mar 2004 19:00:39 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 17, 2004, at 8:56 PM, Lever, Charles wrote:

> charles-
>
>>> [ snip ]
>>>
>>>
>> We'll see if this disappears after we've finished migrating
>> the network
>> to 1Gbps
>>
>>> In these environments you *must* use TCP, since that has congestion
>>> control capabilities baked into the protocol...
>
> what matters here is flow control.  UDP simply doesn't have it.
>
> for gigabit Ethernet, you need flow control at the link level and
> at the transport level.  so once you have gigabit infrastructure,
> be sure you have enabled full gigabit flow control on your servers
> and on your switches.  then you should use TCP and not UDP so you
> have transport layer flow control.
>
Charles and Trond,
thanks for the advices !
I've upgraded the network cards of the linux machines to Gigabit 
ethernet cards and used tcp for my nfs mounts.
The problem disappeard so far so i'm pretty happy !
However i'm very disappointed by the throuhput i'm getting on the Gbps 
network :
When i scp a 473991492 bytes file from one machine to the other, i'm 
getting 14Mbps throughput, which is far less that 1Gpbs theoretical.
Looking at the network card info ( i'm using the sk98lin driver ) i've :
Mar 18 14:49:15 omnirot kernel: eth0: network connection up using port A
Mar 18 14:49:15 omnirot kernel:     speed:           1000
Mar 18 14:49:15 omnirot kernel:     autonegotiation: yes
Mar 18 14:49:15 omnirot kernel:     duplex mode:     full
Mar 18 14:49:15 omnirot kernel:     flowctrl:        symmetric
Mar 18 14:49:15 omnirot kernel:     role:            slave
Mar 18 14:49:15 omnirot kernel:     irq moderation:  disabled
Mar 18 14:49:15 omnirot kernel:     scatter-gather:  enabled

The switch i'm using is a Netgear GS516T

i've tried transferring to/from 2 linux machines connected to this 
switch using the exact same kernel and network cards and also to Mac 
Xserv using a Gbps card . They both yield the same low throuput.
Any hint of what could be causing this ?
Thanks in advance.


Charles-Edouard Ruault
Idtect SA
tel: +33-1-42-81-81-84
fax: +33-1-42-81-82-21
http://www.idtect.com

