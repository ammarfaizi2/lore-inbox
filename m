Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSHTSiM>; Tue, 20 Aug 2002 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHTSiM>; Tue, 20 Aug 2002 14:38:12 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:59663 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S317081AbSHTSiL>; Tue, 20 Aug 2002 14:38:11 -0400
Message-ID: <3D628D14.E686C970@zip.com.au>
Date: Tue, 20 Aug 2002 11:40:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lahti Oy <rlahti@netikka.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: schedule_timeout()
References: <000b01c24870$d8419970$d20a5f0a@deldaran>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lahti Oy wrote:
> 
> Why does schedule_timeout() take a signed long as an argument and then check
> for possible negative values? Wouldn't it be better to just take an unsigned
> long as argument, thus eliminating all dumb checks in the code?

Because someone may do:

	schedule_timeout(when_i_want_to_wake - jiffies);

and if the current time happens to be _after_ when_i_want_to_wake,
we want schedule_timeout to cope with that and do the right thing.

> Another issue I found concerns setting current task state to TASK_RUNNING
> after calling schedule_timeout(). This seems to be done in many parts of the
> kernel, though Kernel-API documentations found from kernelnewbies.org seem
> to claim that task state is guaranteed to be TASK_RUNNING after
> schedule_timeout() returns. Is the documentation faulty or does the kernel
> have obsoleted code?

The documentation is correct.
