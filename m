Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVFJHSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVFJHSp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVFJHSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:18:45 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:3805 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S262507AbVFJHSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:18:36 -0400
Message-ID: <42A93D85.4060005@lab.ntt.co.jp>
Date: Fri, 10 Jun 2005 16:13:09 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: axboe@suse.de, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Real-time problem due to IO congestion.
References: <42A91D36.8090506@lab.ntt.co.jp> <20050609234231.42a10763.akpm@osdl.org>
In-Reply-To: <20050609234231.42a10763.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see.
The program which I tested is just sample, and I wanted to know the 
phenomena is spec or bug.
I also understand that this problem is spec, and need to apply some 
buffering to such applications.

Thank you.

Andrew Morton wrote:
> Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp> wrote:
> 
>>There are 2 type processes in test environment.
>> 1. The real-time needed process (run on with high static priority)
>>     The process wake up every 10ms, and wake up, write some log (the
>> test case is current CPU clock via tsc) to the file.
>>
>> 2. The process which make IO load
>>     The process have large memory size, and kill the process with dumping.
>>     The process's memory area exceeds 70% of whole physical
>> RAM.(Actually 1.5GB memory area while whole RAM is 2GB)
>>
>> Whenever during dumping, the real-time needed process sometimes stop for
>> long time during write system call. (sometimes exceeds 1000ms)
> 
> 
> The writeback code does attempt to give some preference to realtime tasks
> (in get_dirty_limits()), but it can only work up to a point.
> 
> Frankly, your application is poorly designed.  If you want sub-10ms
> responsiveness you shouldn't be doing disk I/O.  The realtime task should
> hand the data off to a non-realtime task for writeout, with suitable
> amounts of buffering in between.

-- 
Takashi Ikebe
