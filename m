Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUHOOOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUHOOOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266701AbUHOOOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:14:14 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:52368 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266692AbUHOOOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:14:10 -0400
Message-ID: <411F7067.8040305@colorfullife.com>
Date: Sun, 15 Aug 2004 16:17:11 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:

>Well this is more an idea than a real patch yet. The page_table_lock
>becomes a bottleneck if more than 4 CPUs are rapidly allocating and using
>memory. "pft" is a program that measures the performance of page faults on
>SMP system. It allocates memory simultaneously in multiple threads thereby
>causing lots of page faults for anonymous pages.
>
>  
>
Very odd. Why do you see a problem with the page_table_lock but no 
problem from the mmap semaphore?
The page fault codepath acquires both.
How often is the page table lock acquired per page fault? Just once or 
multiple spin_lock calls per page fault? Is the problem contention or 
cache line trashing?

Do you have profile/lockmeter output? Is the down_read() in 
do_page_fault() a hot spot, too?

--
    Manfred
