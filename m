Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262221AbSJASBW>; Tue, 1 Oct 2002 14:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262499AbSJASBW>; Tue, 1 Oct 2002 14:01:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10254 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262221AbSJAR7z>;
	Tue, 1 Oct 2002 13:59:55 -0400
Message-ID: <3D99E3C0.5010604@pobox.com>
Date: Tue, 01 Oct 2002 14:04:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
References: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Looking real good.

I still think that schedule_work() should have void* cookie passed to it 
directly, instead of at INIT_WORK time [and possibly changing it by hand 
in the driver, immediately before schedule_work() is called]

For drivers that pass an interface pointer like struct net_device*, 
INIT_WORK-time, the current scheme is fine, but when the cookie 
fluctuates more, it makes a lot more sense to pass void* to 
schedule_work() itself.

Further, schedule_work(wq,data) is conceptually very close to 
my_work_func(data) and makes the code easier to trace through: it 
becomes more obvious what is the value of the my_work_func arg, at the 
place in the code where schedule_work() is called.  I see passing the 
void* cookie as covering one common case, while adding void* arg to 
schedule_work() would cover all cases...

[IMO the same argument can be applied to the existing timer API as well, 
but timers are less often one-shot in kernel code, so it matter less...]

That said, I don't feel strongly about this, so can be convinced 
otherwise fairly easily :)  I would not complain if Linus applied your 
patch as-is.

	Jeff



