Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTBPT1k>; Sun, 16 Feb 2003 14:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbTBPT1k>; Sun, 16 Feb 2003 14:27:40 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:14527 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267348AbTBPT1j>;
	Sun, 16 Feb 2003 14:27:39 -0500
Message-ID: <3E4FE86D.1010708@colorfullife.com>
Date: Sun, 16 Feb 2003 20:37:17 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
References: <Pine.LNX.4.44.0302161119020.2952-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302161119020.2952-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>In short, everything really seems to be pointing that way: the current
>task lock simply _is_ broken, and has apparently always been broken (but
>the ABBA deadlock is just extremely rare in practice, since you have to
>get an interrupt at just the right point on one CPU, while you have the AB
>case on another).\
>
ABBA is not a deadlock, because linux read_locks permit recursive calls.

    read_lock(tasklist_lock);
    task_lock(tsk);
    read_lock(tasklist_lock);

Does not deadlock, nor any other ordering.

The tasklist_lock is never taken for write from bh or irq context.

--
    Manfred

