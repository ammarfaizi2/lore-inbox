Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVLYQCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVLYQCl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 11:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVLYQCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 11:02:41 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:44474 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750860AbVLYQCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 11:02:41 -0500
Message-ID: <43AEC299.1010707@colorfullife.com>
Date: Sun, 25 Dec 2005 17:02:33 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
References: <43AC78CF.9090407@colorfullife.com> <20051224034504.GC24614@sgi.com>
In-Reply-To: <20051224034504.GC24614@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again replying to myself, sorry:

Jack Steiner wrote:

>On Fri, Dec 23, 2005 at 11:23:11PM +0100, Manfred Spraul wrote:
>  
>
>>Bad race.
>>Unfortuantely the scenario that you describe is quite frequent:
>>- autoremove_wake_function()
>>    
>>
Not a bug, but for very subtile reasons:
There are no writes to the wait_queue structure except the 
list_del_init(), and for list_del_init() no memory barriers are required 
because finish_wait() uses list_empty_careful(), i.e. the spin_lock() is 
only bypassed if both write operations from list_del_init() have completed.

>>- ipc/sem.c (search for IN_WAKEUP)
>>    
>>
fixed in -rc7.


--
    Manfred
