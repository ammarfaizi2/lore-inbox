Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319093AbSHFOeR>; Tue, 6 Aug 2002 10:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319094AbSHFOeR>; Tue, 6 Aug 2002 10:34:17 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:60136 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S319093AbSHFOeR>;
	Tue, 6 Aug 2002 10:34:17 -0400
Message-ID: <3D4FDEF3.8070207@colorfullife.com>
Date: Tue, 06 Aug 2002 16:36:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
References: <3D4FD736.DA443B4B@daimi.au.dk>		<20020806.065652.12285252.davem@redhat.com>		<3D4FDA23.90CAB62F@daimi.au.dk> <20020806.070535.24871584.davem@redhat.com> <3D4FDCDB.744EE7C9@daimi.au.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:

>I just get another idea, that might be easier to get right. If
>the only problem is one process changing the mm while another
>process is doing a copy_to_user, we should be able to fix it by
>placing a readlock on the mm while the copy_to_user is in progress.
>  
>
Yes, that would work. copy_to_user is never called with the mmap 
semaphore locked, i.e.

#define copy_to_user(...) \
        down(&current->mm->mmap_sem); \
        check_wp_bit(); \
        real_copy_to_user(); \
        up(&current->mm->mmap_sem)

verify_area would just check that the pointer is below TASK_SIZE, and 
the wp bit is checked within copy_to_user().

But how many 80386 Linux systems that run the 2.4 kernel exist?

--
    Manfred

