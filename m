Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTKHXql (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 18:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTKHXql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 18:46:41 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:28045 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261774AbTKHXqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 18:46:40 -0500
Message-ID: <3FAD7F7D.2020003@cyberone.com.au>
Date: Sun, 09 Nov 2003 10:42:53 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, mbligh@aracnet.com
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
References: <200311090349.04983.kernel@kolivas.org> <20031108145840.52fed740.akpm@osdl.org>
In-Reply-To: <20031108145840.52fed740.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Con Kolivas <kernel@kolivas.org> wrote:
>
>>Hi
>>
>>I believe this is a simple typo / variable name mixup between rq_src and 
>>this_rq. So far all testing shows positive (if minor) improvements.
>>
>>
>
>Looks right to me.  I'll queue this up for the 2.6.1 deluge.
>

prev_cpu_load[i] is nr_running of cpu i last time this operation was
performed. Either it, or the current nr_running is taken, whichever
is lower.

I guess its done this way for cache benefits, but it was correct as
Ingo intended. For example, with Con's patch you can see
rq_src->prev_cpu_load[i] will only ever use the ith position in the array.

I wonder what improvements Con is seeing? If they are significant, change
prev_cpu_load to be an integer type and do a similar thing here.


