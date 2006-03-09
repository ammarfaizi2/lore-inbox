Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWCII5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWCII5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 03:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWCII5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 03:57:37 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:42149 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751405AbWCII5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 03:57:37 -0500
Message-ID: <440FEDF7.2040008@aitel.hist.no>
Date: Thu, 09 Mar 2006 09:57:27 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
References: <200603081013.44678.kernel@kolivas.org> <200603081151.13942.kernel@kolivas.org> <20060307171134.59288092.akpm@osdl.org> <200603081212.03223.kernel@kolivas.org>
In-Reply-To: <200603081212.03223.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Wed, 8 Mar 2006 12:11 pm, Andrew Morton wrote:
>  
>
>>but, but.  If prefetching is prefetching stuff which that game will soon
>>use then it'll be an aggregate improvement.  If prefetch is prefetching
>>stuff which that game _won't_ use then prefetch is busted.  Using yield()
>>to artificially cripple kprefetchd is a rather sad workaround isn't it?
>>    
>>
>
>It's not the stuff that it prefetches that's the problem; it's the disk 
>access.
>  
>
Well, seems you have some sorry kind of disk driver then?
An ide disk not using dma? 

A low-cpu task that only abuses the disk shouldn't make an impact
on a 3D game that hogs the cpu only.  Unless the driver for your
harddisk is faulty, using way more cpu than it need.

Use hdparm, check the basics:
unmaksirq=1, using_dma=1, multcount is some positive number,
such as 8 or 16, readahead is some positive number.
Also use hdparm -i and verify that the disk is using some
nice udma mode.  (too old for that, and it probably isn't worth
optimizing this for...)

Also make sure the disk driver isn't sharing an irq with the
3D card. 

Come to think of it, if your 3D game happens to saturate the
pci bus for long times, then disk accesses might indeed
be noticeable as they too need the bus.  Check if going to
a slower dma mode helps - this might free up the bus a bit.

Helge Hafting
