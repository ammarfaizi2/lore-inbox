Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVFHSyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVFHSyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFHSyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 14:54:33 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:5781 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261531AbVFHSyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 14:54:20 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,183,1114984800"; 
   d="scan'208"; a="10621956:sNHT28803836"
Message-ID: <42A73ED8.9040505@fujitsu-siemens.com>
Date: Wed, 08 Jun 2005 20:54:16 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC for 2.6: avoid OOM at bounce buffer storm
References: <42A07BAA.4050303@fujitsu-siemens.com>	<20050603160629.2acc4558.akpm@osdl.org>	<42A5AD4A.6080100@fujitsu-siemens.com> <20050607120811.6527a9ff.akpm@osdl.org>
In-Reply-To: <20050607120811.6527a9ff.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

> The semaphore is initialised with the limit level, so once it has been
> down()ed more than `limit' times, processes will block until someone does
> up().

Oh - of course. Neat.

>>It appears to run much more 
>> smoothly now, perhaps because wakeup_bdflush() isn't called any more. 
>> Are you still interested in more data?
> 
> Perhaps the newer kernel has writeback thresholding fixes so it's not
> possible to dirty as much memory with write().

I have collected more data and the behavior with 2.6.12-rc5-mm2 is 
flawless, there is a continuous writeback flow close to the maximum rate 
possible, and the bounce buffer usage never gets anywhere near the limit 
where it'd become dangerous. At least not in my test setup. The latest 
fedora kernel 2.6.11-1.27 also behaves ok, although it doesn't adapt to 
changing io load as smoothly as 2.6.12-rc5-mm2 does, and the writeback 
rate is oscillating more strongly.

The kernels where I observe the problem are 2.6.9 kernels from RedHat 
EL4. I have posted this here because I saw that the highmem bounce 
buffer/memory pool implementation was identical between the 2.6.9 kernel 
and all but the very latest development kernels, and I concluded 
prematurely that the behavior under my scenario must also be the same -- 
which it wasn't. I apologize for not having looked more closely.

Many thanks for looking into this anyway. From a theoretical point of 
view, I still think I had a valid point :-/.

Your patch sure looks good to me.

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
