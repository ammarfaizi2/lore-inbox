Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315811AbSENQZw>; Tue, 14 May 2002 12:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315812AbSENQZv>; Tue, 14 May 2002 12:25:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61690 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315811AbSENQZs>; Tue, 14 May 2002 12:25:48 -0400
Subject: Re: error : preempt_count 1
From: Robert Love <rml@tech9.net>
To: vda@port.imtp.ilyichevsk.odessa.ua, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205141143.g4EBhEY09631@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 May 2002 09:24:57 -0700
Message-Id: <1021393499.942.24.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-14 at 09:45, Denis Vlasenko wrote:

> On 13 May 2002 14:18, Robert Love wrote:
>
> > Absolutely nothing bad.  It is a debugging check to catch bad code that
> > does funny things with locks.  Ideally, every program should call unlock
> > for each instance it called lock - balancing everything out and giving a
> > preempt_count of zero.
> 
> > Some code in the kernel, knowing it is shutting down, does not bother to
> > drop any held locks and subsequently you see that message.
> 
> > Since it is triggering false positives, I will remove it eventually.
> 
> I'd say don't remove it, just omit the 'error:' part - this will
> reduce panic mails on the subject.
> 
> > For now it is incredibly useful for catching real problems.  And the
> > above, while harmless, could be fixed for "cleanliness" concerns.

Not a bad idea ;-)

For now this will hopefully curb the inquiries - I can still remove it
later when I am confident that the core code is sane and if people still
whine.

Thanks,

	Robert Love

--- linux-2.5.15/kernel/exit.c	Sun May  5 20:37:59 2002
+++ linux/kernel/exit.c	Tue May 14 09:22:52 2002
@@ -526,7 +526,7 @@
 	del_timer_sync(&tsk->real_timer);
 
 	if (unlikely(preempt_get_count()))
-		printk(KERN_ERR "error: %s[%d] exited with preempt_count %d\n",
+		printk(KERN_ERR "%s[%d] exited with preempt_count %d\n",
 				current->comm, current->pid,
 				preempt_get_count());
 

