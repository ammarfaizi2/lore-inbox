Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUBHDVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUBHDVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:21:12 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:40368 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261885AbUBHDVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:21:10 -0500
Message-ID: <4025AB00.3030601@cyberone.com.au>
Date: Sun, 08 Feb 2004 14:20:32 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <20040207095057.GS19011@krispykreme> <200402080040.i180eY811893@owlet.beaverton.ibm.com> <20040208011221.GV19011@krispykreme> <40258F21.30209@cyberone.com.au> <20040208014141.GX19011@krispykreme>
In-Reply-To: <20040208014141.GX19011@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anton Blanchard wrote:

>>Does active balancing still work? Ie. get two processes running on the
>>same physical CPU and see if one is migrated away.
>>
>
>Both Ricks patch and your patch still have the active rebalance issue.
>
>Martins patch doesnt, but that seems to be because it does absolutely no
>rebalancing (all my runnable tasks are on one physical cpu) :)
>
>

Yeah its because you have a lot of cpus, so the average is still
small. You also need something like

if (*imbalance == 0 && max_load - this_load > SCHED_LOAD_SCALE)
    *imbalance = 1;

I don't have a >= 4 CPU box to test on, so I hate to be feeding
you lots of little unproven patches.


