Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271257AbRHTOxJ>; Mon, 20 Aug 2001 10:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271260AbRHTOw7>; Mon, 20 Aug 2001 10:52:59 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:48653 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S271257AbRHTOwq>; Mon, 20 Aug 2001 10:52:46 -0400
Message-Id: <200108201452.f7KEqxk18219@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <llx@swissonline.ch>
Reply-To: llx@swissonline.ch
To: linux-kernel@vger.kernel.org
Subject: misc questions about kernel 2.4.x internals
Date: Mon, 20 Aug 2001 16:52:55 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

1) when using any functions that can block i need to do this in the context 
of a process. so a can't read, write to sockets in a bottom-half of a 
interrupt handler. thats why i need to use a kernel thread (i don't what to
use a user level process). my question now is - how long does it take until 
my kernel thread starts running? do i have a way to give it very high 
priority and force my thread to be scheduled so that i can be 'sure' to run 
just after softirq's, tasklets, ...?

2) for module writers there is documented and easy to use api how to use 
tasklets to schedule it's buttom-half for later (very soon) execution. 
are tasklets like tq_immedate in 2.2.x or tq_schedule? i mean is there a
current process or do they runn at interrupt time?
and am i right when i say: to add a new softirq i need to patch kernel 
sources?

3) i had a look at the ll_rw_block and realised that it can block when there 
are to many buffers locked. when i use generic_make_request can i be 
shure that i wont block so that i can call it in a tasklet and don't need to
switch to a kernel thread? i think that also needs that clustering function 
__make_request may not block. does it or does it not?

4) i was looking at the networking code in 2.4 because it is possible that
i need to write a new thin network protocoll which is optimised for disk-i/o.
i didn't find any documentation how to implement a new one in 2.4. does
anybody have some pointers to doc's or can give me some comments?

thanks for any help or pointers to further information
chris
