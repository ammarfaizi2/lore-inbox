Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbUBWVbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUBWVbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:31:00 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:6627 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262066AbUBWVai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:30:38 -0500
Message-ID: <403A70EB.4060909@matchmail.com>
Date: Mon, 23 Feb 2004 13:30:19 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Alexander Y. Fomichev" <gluk@php4.ru>, anton@megashop.ru
Subject: Re: 2.6.1 IO lockup on SMP systems
References: <200401311940.28078.rathamahata@php4.ru> <20040221113044.7deb60b9.akpm@osdl.org> <200402222039.58702.gluk@php4.ru> <200402232027.26958.rathamahata@php4.ru>
In-Reply-To: <200402232027.26958.rathamahata@php4.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey S. Kostyliov wrote:
> Hello Andrew,
> 
> Now this happens for the third time.
> 
> 
>>>>I've just reproduced this lockup with 2.6.3.
>>>>
>>>>
>>>>>You may need a serial console to be able to capture all the output.
>>>>>
>>>>>Also, it would be useful to know what sort of load the machines are
>>>>>under, and what filesystems are in use.
>>>>
>>>>The machine is a http server. The main applications are:
>>>>1) apache 1.3 which serves php pages (mod_php):
>>>>	 15.3 requests/sec - 111.9 kB/second - 7.3 kB/request
>>>>	 54 requests currently being processed, 19 idle servers
>>>>2) mysql:
>>>>	Threads: 19  Questions: 26922012  Slow queries: 9799  Opens: 64980
>>>>	Flush tables: 1  Open tables: 630  Queries per second avg: 143.547
>>>>
>>>>This is an IO bound machine in general. All filesystems are reiserfs.
>>>>
>>>>Here is a sysrq-T output obtained from a locked box via serail console:
>>>
>>>OK, so everything is stuck trying to allocate memory.  Perhaps you ran out
>>>of swapspace, or some process has gone berzerk allocating memory.
> 
> 
> The memory exhaustion is indeed possible for this box. I'll double check
> ulimit and /etc/security/limits.conf stuff. The only thing which worries
> me that this box had been running for months without any problems with
> 2.4.23aa1.
> 
> I have added another 2Gb to swap space (hope this give enough time
> to find the memory hungry process(es)).

Also check how much memory is being used for slab in /proc/meminfo
