Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276930AbRJHPVz>; Mon, 8 Oct 2001 11:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276336AbRJHPVs>; Mon, 8 Oct 2001 11:21:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38202 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276933AbRJHPVk>; Mon, 8 Oct 2001 11:21:40 -0400
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: BALBIR SINGH <balbir.singh@wipro.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] I still see people using cli()
In-Reply-To: <20011008084950.B16204@hq2>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 08 Oct 2001 09:11:57 -0600
In-Reply-To: <20011008084950.B16204@hq2>
Message-ID: <m1itdqw4hu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Victor Yodaiken <yodaiken@fsmlabs.com> writes:

> On Mon, Oct 08, 2001 at 07:59:05PM +0530, BALBIR SINGH wrote:
> > BTW, that brings me to another issue, once the kernel becomes preemptibel,
> what
> 
> > are the locking issues? how are semaphores and spin-locks affected? Has
> anybody
> 
> > defined or come up with the rules/document yet?
> 
> IF the kernel becomes preemptible it will be so slow, so buggy, and so painful
> to maintain, that those issues won't matter.

The preemptible kernel work just takes the current SMP code, and
allows it to work on a single processor.  You are not interruptted if
you have a lock held.  This makes the number of cases in the kernel
simpler, and should improve maintenance as more people will be
affected by the SMP issues.

Right now there is a preemptible kernel patch being maintained
somewhere.  I haven't had a chance to look recently.  But the recent
threads on low latency mentioned it.

As for rules.  They are the usual SMP rules.  In earlier version there
was a requirement or that you used balanced constructs.

i.e.
spin_lock_irqsave
...
spin_unlock_irqrestore

and not.

spin_lock_irqsave
...
spin_unlock
..
restore_flags.


Eric
