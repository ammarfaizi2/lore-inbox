Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUFQNTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUFQNTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266482AbUFQNRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:17:37 -0400
Received: from [213.13.117.218] ([213.13.117.218]:9698 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S266487AbUFQNNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:13:50 -0400
Date: Thu, 17 Jun 2004 14:13:44 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: rwsem-spinlock error
Message-ID: <20040617131344.GA2916@hobbes.itsari.int>
References: <20040616183343.GA9940@logos.cnet> <Pine.GSO.4.58.0406171206470.22919@waterleaf.sonytel.be> <40D173F8.4060701@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <40D173F8.4060701@yahoo.com.au> (from nickpiggin@yahoo.com.au on Thu, Jun 17, 2004 at 11:35:36 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.06.17 11:35, Nick Piggin wrote:
> Geert Uytterhoeven wrote:
>> On Wed, 16 Jun 2004, Marcelo Tosatti wrote:
>> 
>>> <nickpiggin:yahoo.com.au>:
>>>  o rwsem race fixes backported from 2.6
>> 
>> 
>>> Nuno Monteiro:
>>>  o Fix rwsem-fix typo
>>>  o Complete rwsem typo fix
>> 
>> 
>> | rwsem-spinlock.c: In function `__rwsem_wake_one_writer':
>> | rwsem-spinlock.c:111: `tsk' undeclared (first use in this function)
>> | rwsem-spinlock.c:111: (Each undeclared identifier is reported only 
>> once
>> | rwsem-spinlock.c:111: for each function it appears in.)
>> 
>> How can this ever compile on any architecture?
>> 
> 
> Dangit. rwsem-spinlock.c isn't compiled for many architectures.
> 
> It should just require a
> 
> 	struct task_struct *tsk;
> 


Yeah, m68k being one of those that need it, hence why Geert noticed 
immediately. I only tested on x86, ppc32 and alpha, none of which
needs it. This should do the trick, then.



--- linux-2.4/lib/rwsem-spinlock.c~fix-rwsem-race-fix-3	2004-06-16 21:50:49.000000000 +0100
+++ linux-2.4/lib/rwsem-spinlock.c	2004-06-17 13:58:19.833211128 +0100
@@ -101,6 +101,7 @@ static inline struct rw_semaphore *__rws
 static inline struct rw_semaphore *__rwsem_wake_one_writer(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter *waiter;
+	struct task_struct *tsk;
 
 	sem->activity = -1;
 


