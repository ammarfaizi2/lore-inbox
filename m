Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUHPFU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUHPFU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267440AbUHPFU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:20:56 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:31381 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267438AbUHPFUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:20:54 -0400
Message-ID: <412044E4.4030409@colorfullife.com>
Date: Mon, 16 Aug 2004 07:23:48 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte
References: <411F7067.8040305@colorfullife.com> <Pine.LNX.4.58.0408151304190.2470@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0408151304190.2470@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Sun, 15 Aug 2004, Manfred Spraul wrote:
>
>  
>
>>Very odd. Why do you see a problem with the page_table_lock but no
>>problem from the mmap semaphore?
>>    
>>
>
>Because there is a only a down_read() call for the mmap semaphore before
>invoking handle_mm_fault. This is a rw semaphore which means that multiple
>processors/processes may be entering handle_mm_fault with a read lock on
>the mmap semaphore.
>  
>
As far as I can see the actual hold times on the page_table_lock are not 
that long and down_read() causes a cache line transfer, too.
But you have answered my question in your first mail: There are 2-5 
spin_lock calls per page fault but only one down_read call.

--
    Manfred
