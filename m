Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbUDRDiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 23:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbUDRDiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 23:38:22 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:57004 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264110AbUDRDiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 23:38:20 -0400
Message-ID: <4081F809.4030606@yahoo.com.au>
Date: Sun, 18 Apr 2004 13:37:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418002343.GA16025@flea>
In-Reply-To: <20040418002343.GA16025@flea>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:
> On Sat, Apr 17, 2004 at 04:51:51PM -0700, Andrew Morton wrote:
> 
>>Marc Singer <elf@buici.com> wrote:
>>
>>>On Sat, Apr 17, 2004 at 04:21:25PM -0700, Andrew Morton wrote:
>>>
>>>>
>>>>How on earth can it take half a minute to list /proc?
>>>
>>>I've watched the vmscan code at work.  The memory pressure is so high
>>>that it reclaims mapped pages zealously.  The program's code pages are
>>>being evicted frequently.
>>
>>Which tends to imply that the VM is not reclaiming any of that nfs-backed
>>pagecache.
> 
> 
> I don't think that's the whole story.  They question is why.
> 

swappiness is pretty arbitrary and unfortunately it means
different things to machines with different sized memory.

Also, once you *have* gone past the reclaim_mapped threshold,
mapped pages aren't really given any preference above
unmapped pages.

I have a small patchset which splits the active list roughly
into mapped and unmapped pages. It might hopefully solve your
problem. Would you give it a try? It is pretty stable here.

Nick
