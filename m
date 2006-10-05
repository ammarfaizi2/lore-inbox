Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWJEJQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWJEJQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 05:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWJEJQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 05:16:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:51279 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751547AbWJEJQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 05:16:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=tzxSmW9FAVVfsw19T+vbhsP4Fs6XN27BTzn7pFZ9sjSvxCUd4e5q8GVO5RO/02BjafGD2gFObhPZiqyt0RsH9D96Mdbd5qJQI6b/QAf02pcZChl8sWLKyLT1xRZROJJFTbMOj3Gb6Mbwz68v9zAEB/0CPL5/84rmR2Qr0RLkI20=
Message-ID: <4524CD61.5080904@web.de>
Date: Thu, 05 Oct 2006 11:16:17 +0200
From: Markus Wenke <M.Wenke@web.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: to many sockets ?
References: <4523CD4E.10806@web.de> <200610050958.38036.dada1@cosmosbay.com> <4524C05D.6080305@web.de> <200610051045.46919.dada1@cosmosbay.com>
In-Reply-To: <200610051045.46919.dada1@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet schrieb:
> On Thursday 05 October 2006 10:20, Markus Wenke wrote:
>   
>> Eric Dumazet schrieb:
>>     
>
>   
>>> Could you post here the result of these commands when your system is
>>> using more than 100.000 connections (and before the OOM :) )
>>>       
>> Hi,
>>
>> here the results with 130001 connetions
>>
>>     
>>> cat /proc/meminfo
>>>       
>> MemTotal:      3108372 kB
>> MemFree:       2114404 kB
>> Buffers:          5112 kB
>> Cached:          97804 kB
>> SwapCached:          0 kB
>> Active:         140552 kB
>> Inactive:        38948 kB
>> HighTotal:     2228160 kB
>> HighFree:      2048108 kB
>> LowTotal:       880212 kB
>> LowFree:         66296 kB
>>     
>
> See here ? you have 'only' 880212 kB of LOWMEM, and 66 MB free.
> all kernel structures (you can see them in /proc/slabinfo) are lying on this 
> zone, no matter you add RAM on your machine (more RAM end up in HighMEM zone, 
> wich is basically unused on your setup)
>
> Since you have a 64bits CPU, your best move would be to use a 64bits kernel 
> (you can keep all user land in 32bits mode)
>
> With a 64bits kernel, kernel land structures would not be constrained in a 
> small area, but can use full RAM.
>
I think I change to the 64 Bit-Kernel ;-).


btw: with the Xen-patched Kernel I get this at 130000 connections:

MemTotal:      2979840 kB
MemFree:       2394544 kB
Buffers:          5748 kB
Cached:         104492 kB
SwapCached:          0 kB
Active:         146632 kB
Inactive:        43276 kB
HighTotal:     2136004 kB
HighFree:      1943728 kB
LowTotal:       843836 kB
LowFree:        450816 kB
SwapTotal:     2104472 kB
SwapFree:      2104472 kB
Dirty:             412 kB
Writeback:           0 kB
Mapped:          89556 kB
Slab:           285284 kB
CommitLimit:   3594392 kB
Committed_AS:   205244 kB
PageTables:        756 kB
VmallocTotal:   114680 kB
VmallocUsed:      4576 kB
VmallocChunk:   109280 kB

> I'm curious you have so many sockets but few entries in route cache... 
> basically all connections come from few machines ?
>
My test scenario has only 5 clients, so I must make the connections with 
a few clients.



Thanks a lot

Markus Wenke

