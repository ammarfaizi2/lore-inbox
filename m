Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136504AbREDVA7>; Fri, 4 May 2001 17:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136506AbREDVAu>; Fri, 4 May 2001 17:00:50 -0400
Received: from stu1ir100-136-141.ip.tesion.net ([213.182.136.141]:11528 "EHLO
	tigram.bogus.local") by vger.kernel.org with ESMTP
	id <S136504AbREDVAo>; Fri, 4 May 2001 17:00:44 -0400
To: ptb@it.uc3m.es
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Interrupting select.
In-Reply-To: <200105022303.f42N36825429@oboe.it.uc3m.es>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 04 May 2001 22:59:20 +0200
In-Reply-To: <200105022303.f42N36825429@oboe.it.uc3m.es>
Message-ID: <87n18s96fr.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Peter T. Breuer" <ptb@it.uc3m.es> writes:

> "A month of sundays ago Alan Cox wrote:"
> > > What IS the magic combination that makes select interruptible
> > > by honest-to-goodness non-blocked signals!
> > man
> > 
> > [seriously man sigaction]
> 
> Equally seriously .. all signals are unblocked in my code and always
> have been. The processes receive signals vurrrrry happily. Except when
> they are in a select-with-timeout loop, when they keep going round the
> loop poking their head out of the select every 5s, and taking no notice
> of the murderous hail of die die die die die stuff being slammed at
> them.
[snip]
> Looking at the kernel code in select.c. I see it's implemented by poll
> (I knew that). sys_select calls do_select and I can't for the life of
> me see where anyone sets a signal mask. OTOH if all signals are
> masked by default when syscalls are made (I don't know, but it seems
> possible) then I can't see where interrupts are allowed again.
> 
> The man page for select says nothing about it being interruptible, or
> not. 
> 
> This has been in the back of my mind for months. I'm glad somebody
> asked about it!

I'm not really sure, what you're asking for. Select() is interruptible.

But: if you have multiple threads, the signal may be delivered to any
thread. So, what you may see, is, that the signal is delivered to a
thread, but the signaled thread is not the thread waiting in the
select() call.

Therefore it _seems_, as if select() is not interruptible, but it
surely is.

Regards, Olaf.
