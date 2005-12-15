Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbVLOLif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbVLOLif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 06:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbVLOLif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 06:38:35 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:54535 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1422669AbVLOLie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 06:38:34 -0500
Message-ID: <43A155AE.4050105@superbug.co.uk>
Date: Thu, 15 Dec 2005 11:38:22 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitchell Blank Jr <mitch@sfgoth.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Sridhar Samudrala <sri@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com> <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com> <43A08546.8040708@superbug.co.uk> <20051215015456.GC23393@gaz.sfgoth.com>
In-Reply-To: <20051215015456.GC23393@gaz.sfgoth.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> James Courtier-Dutton wrote:
> 
>>When I had the conversation with Matt at KS, the problem we were trying 
>>to solve was "Memory pressure with network attached swap space".
> 
> 
> s/swap space/writable filesystems/
> 
> You can hit these problems even if you have no swap.  Too much of the
> memory becomes filled with dirty pages needing writeback -- then you lose
> your NFS server's ARP entry at the wrong moment.  If you have a local disk
> to swap to the machine will recover after a little bit of grinding, otherwise
> it's all pretty much over.
> 
> The big problem is that as long as there's network I/O coming in it's
> likely that pages you free (as the VM gets more and more desperate about
> dropping the few remaining non-dirty pages) will get used for sockets
> that AREN'T helping you recover RAM.  You really need to be able to tell
> the whole network stack "we're in really rough shape here; ignore all RX
> work unless it's going to help me get write ACKs back from my {NFS,iSCSI}
> server"  My understanding is that is what this patchset is trying to
> accomplish.
> 
> -Mitch
> 
> 

You are using the wrong hammer to crack your nut.
You should instead approach your problem of why the ARP entry gets lost.
For example, you could give as critical priority to your TCP session, 
but that still won't cure your ARP problem.
I would suggest that the best way to cure your arp problem, is to 
increase the time between arp cache refreshes.

James

