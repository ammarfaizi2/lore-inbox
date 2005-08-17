Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVHQFqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVHQFqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVHQFqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:46:54 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:30408 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750895AbVHQFqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:46:53 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1124252419.5764.83.camel@localhost.localdomain>
References: <20050816121843.GA24308@elte.hu>
	 <1124206316.5764.14.camel@localhost.localdomain>
	 <1124207046.5764.17.camel@localhost.localdomain>
	 <1124208507.5764.20.camel@localhost.localdomain>
	 <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu>
	 <20050816165247.GA10386@elte.hu>  <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 01:46:20 -0400
Message-Id: <1124257580.5764.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 00:20 -0400, Steven Rostedt wrote:
> Ingo,
> 
> FYI, I ran this on my laptop (Pentium4 HT) and it locked up shortly
> after it started INIT.  I rebooted, and now it's up and running 
> with no problems!?!  I'll reboot it a few more times to see if it will
> lock up again.

With a small change it locks up all the time :-)

> 
> Unfortunately, my laptop doesn't have any serial so I don't have much to
> debug with it.  I'll set up netconsole, but this is not as reliable
> under RT, or was this fixed. I remember before that it could call things
> that would schedule and had some hooks to keep interrupts on.
> 
> Oh, I also did get the message when it started:
> 
> WARNING: kstopmachine/859 changed soft IRQ-flags.
>  [<c0149e0b>] stop_machine+0x11b/0x160 (8)
>  [<c0149e7e>] do_stop+0xe/0x70 (32)
>  [<c0139c5a>] kthread+0xba/0xc0 (16)
>  [<c0139ba0>] kthread+0x0/0xc0 (28)
>  [<c0101385>] kernel_thread_helper+0x5/0x10 (16)

I replaced this with raw_local_irq_disable and it really locks up
everytime now.  I need to look into how this is best done.

> The kernel I used was rt6 with my latest patch to the
> raw_local_save_flags.

I just got the NMI working, but since it is now 1:44am my time, I'm
going to bed.  I'll run it again tomorrow and hopefully the NMI will
show where and why it's locking up.

-- Steve


