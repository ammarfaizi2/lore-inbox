Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136476AbREDSOz>; Fri, 4 May 2001 14:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136477AbREDSOp>; Fri, 4 May 2001 14:14:45 -0400
Received: from colorfullife.com ([216.156.138.34]:28942 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136476AbREDSOb>;
	Fri, 4 May 2001 14:14:31 -0400
Message-ID: <3AF2F18D.15A52CD9@colorfullife.com>
Date: Fri, 04 May 2001 20:14:37 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: appro@fy.chalmers.se
CC: linux-kernel@vger.kernel.org
Subject: Re: modularized SYSENTER support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Q. How come the handler doesn't manage so called "bottom halves" or 
>    "soft IRQs"? 
> A. There is no need for this. Soft IRQs can only appear at exit from 
>    hardware interrupt handlers. Indeed, we can't count on user app. 
>    being around and performing a system call when it comes to 
>    interrupt handling, right? 

That's probably a bug.
syscall
* spin_lock_bh()
* hardware interrupt arrives
* BH's are blocked, delayed
* spin_unlock_bh()
* return from syscall.

You must check for softirq's before returning.

--
	Manfred
