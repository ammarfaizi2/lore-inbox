Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbVLOCgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVLOCgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVLOCgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:36:10 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51877 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030377AbVLOCgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:36:09 -0500
Message-ID: <43A0D68D.8090405@de.ibm.com>
Date: Thu, 15 Dec 2005 03:35:57 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/6] statistics infrastructure - prerequisite: scatter-gather
 ringbuffer
References: <43A044AA.4040103@de.ibm.com> <p73d5jz8r7n.fsf@verdi.suse.de>
In-Reply-To: <p73d5jz8r7n.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Martin Peschke <mp3@de.ibm.com> writes:
>
>  
>
>>[patch 1/6] statistics infrastructure - prerequisite: scatter-gather ringbuffer
>>
>>This patch implemenents a ringbuffer made up of scattered memory (pages).
>>The current implementation allows fixed-size entries to be stored in the
>>ringbuffer. There are routines that simplify writing entries to a buffer
>>and reading entries from a buffer. Ringbuffer resizing is not supported, yet.
>>
>>This is actually a separate feature which could be used for purposes
>>other than statistics.
>>    
>>
>
>This seems redundant with relayfs.
>
>-Andi
>
>  
>
Interesting pointer.

Just having scanned through the relayfs documentation the first time, to 
me, relayfs looks like a combination of ringbuffer functionality, 
kernel-user space communication, and easy-to-use filesystem semantics.

Not sure I really need that much for my purposes. I was primarily 
looking for a simple way to temporarily store small bits of data in a 
larger buffer that wraps and isn't overly risky with regard to it's 
allocation. Both producer and consumer of the stored data are inside the 
kernel, or even within the same component.

Relayfs might be interesting for statistics, nonetheless, considering 
that there need to be a way to transfer data to user space.

Relayfs seems to be the right thing to convey streams of incremental 
pieces of data, like trace records as implemented by 
arch/s390/kernel/debug.c, for example. Relayfs would work for statistics 
that involve data growth like a history of a counter, for example, or 
the raw measurement data reported for statistic updates. I doubt it is 
the right thing for counters, fill level indicators and histograms; 
basically for all types of statistics that do not continuously put their 
hands on untouched memory to store their results.

I am currently using debugfs, which works fine for all of these cases. 
In addition, I need some ringbuffer functionality, though.

