Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136169AbRDVPFI>; Sun, 22 Apr 2001 11:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136167AbRDVPE6>; Sun, 22 Apr 2001 11:04:58 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47626 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S136168AbRDVPEx>;
	Sun, 22 Apr 2001 11:04:53 -0400
Date: Sun, 22 Apr 2001 11:59:11 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Francis Litterio <franl@world.std.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Does the scheduler run every time jiffies is incremented?
In-Reply-To: <m31yql2di8.fsf@chantale.std.com>
Message-ID: <Pine.LNX.4.21.0104221156280.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please remove linux-kernel from the CC and move it to the
 more appropriate kernelnewbies list]

On 22 Apr 2001, Francis Litterio wrote:

> I'm reading Rubini's "Linux Device Drivers" and it isn't clear to me
> whether the scheduler runs every time the timer interrupt increments
> jiffies or less frequently.
> 
> Does the scheduler run every time jiffies is incremented?

No.  Every timer interrupt a bunch of functions in
kernel/timer.c is run, amongst them the following lines
of code (from update_process_times):

                if (--p->counter <= 0) {
                        p->counter = 0;
                        p->need_resched = 1;
                }

As you can see, we will only reschedule when the time slice
of the currently running process is over.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

