Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284944AbRLFCdJ>; Wed, 5 Dec 2001 21:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284948AbRLFCc7>; Wed, 5 Dec 2001 21:32:59 -0500
Received: from ns.suse.de ([213.95.15.193]:40715 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284946AbRLFCcq>;
	Wed, 5 Dec 2001 21:32:46 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] scalable timers implementation, 2.4.16, 2.5.0
In-Reply-To: <3C0E9BFD.BC189E17@zip.com.au.suse.lists.linux.kernel> <E16Bo4c-00031f-00@wagner.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Dec 2001 03:32:38 +0100
In-Reply-To: Rusty Russell's message of "6 Dec 2001 03:20:47 +0100"
Message-ID: <p73wv016ptl.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> The deadlock you're referring to is, I assume, del_timer_sync() called
> inside the timer itself?  Can you think of any other dangerous cases?

Common seems to be: 


	CPU#0                CPU#1

                             timer fires
spinlock()                 
                             spinlock() - spinning
del_timer_sync() 


-> deadlock. 

-Andi
