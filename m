Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSJ1VhO>; Mon, 28 Oct 2002 16:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbSJ1VhO>; Mon, 28 Oct 2002 16:37:14 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:48061 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261507AbSJ1VhN>;
	Mon, 28 Oct 2002 16:37:13 -0500
Message-ID: <3DBDAF7E.3040309@colorfullife.com>
Date: Mon, 28 Oct 2002 22:43:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Waechtler <pwaechtler@mac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
References: <3DBC1A6B.7020108@colorfullife.com> <3DBC6314.6B8AC5EA@mac.com> <3DBCDF4A.3080709@colorfullife.com> <3DBDAE85.B4499B8F@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Waechtler wrote:

>>For the locking stuff, the patch should probably depend on the sysv rcu
>>patch, it cleans up locking a bit.
>>
>>    
>>
>
>Well, I am a victim of "information hiding" ;-)
>  
>
That's not information hiding - there were 3 different locking 
implementations: first one with a per-queue spinlock that didn't support 
growing the number of queues at runtime, then one with a global rw lock 
and a per-queue spinlock, and the simple, global spinlock version that's 
part of 2.3.x-2.5.4x.

>msq_lock(id) does not lock a queue, it locks/unlocks the whole array.
>Forget my post about a deadlock in ipc_addid()
>  
>
Which deadlock did you see? With the RCU ipc patch [part of 2.5.44-mm6], 
msg_lock again locks the queue, not the whole array. Calls to 
ipc_addid() with the msq spinlock aquired are not permitted.

--
    Manfred

