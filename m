Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWEUO4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWEUO4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 10:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWEUO4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 10:56:47 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:6049 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S964881AbWEUO4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 10:56:46 -0400
Message-ID: <44707F8E.8010506@colorfullife.com>
Date: Sun, 21 May 2006 16:56:14 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [git patches] net driver updates
References: <20060520042856.GA7218@havoc.gtf.org> <Pine.LNX.4.64.0605201035510.10823@g5.osdl.org> <20060520105547.220f2bea.akpm@osdl.org> <200605210015.15847.ak@suse.de> <447012B2.9050207@colorfullife.com> <4579880.1148217864672.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
In-Reply-To: <4579880.1148217864672.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Kleen wrote:

>>No idea, but unlikely. The fix removes a duplicate request_irq call.
>>Is
>>it possible that the both instances run concurrently?
>>    
>>
>
>The system has two Forcedeth ports, but only one has a cable connected.
>I don't think there is any parallelism. Just one connection with a lot
>of data. It didn't happen with 2.6.16.
>
>  
>
You misunderstood me:
Due to a broken patch, the driver did
    request_irq(irqnum, handler,...)
twice. Thus the irq handler was registered twice. The rx synchronization 
assumes that the irq handler doesn't run concurrently. I'm not sure what 
happens if the irq handler is registered twice: is it possible that it 
runs twice at the same time, i.e. is the synchronization in the irq 
subsystem irq number or registration call based?

>If you don't have any other good ideas I will try to track it down.
>
>  
>
I don't have any good ideas, please try to figure out what's wrong. Is 
there a debug switch for the network layer that forces the network layer 
to verify the CHECKSUM_UNNECESSARY blocks?

--
    Manfred
