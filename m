Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289919AbSAKMBA>; Fri, 11 Jan 2002 07:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289920AbSAKMAu>; Fri, 11 Jan 2002 07:00:50 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:58338 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289919AbSAKMAp>; Fri, 11 Jan 2002 07:00:45 -0500
Message-ID: <3C3ED3E8.60CDE995@redhat.com>
Date: Fri, 11 Jan 2002 12:00:40 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H5
In-Reply-To: Russell King's message of "11 Jan 2002 12:37:44 +0100" <p73zo3lnmg9.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Russell King <rmk@arm.linux.org.uk> writes:
> >
> > The serial driver (old or new) open/close functions are one of the worst
> > offenders of the global-cli-and-hold-kernel-lock-and-schedule problem.
> > I'm currently working on fixing this in the new serial driver.
> 
> When they hold the kernel lock in addition to the global cli() before
> schedule() it should be ok. Only the behaviour of code not holding
> kernel lock but global cli and calling schedule() has changed.

well the biggest serial.c offender is block_til_ready of course...
oh and there's quite some dusty old code that does

save_flags();
cli();

while (some_condition)
	sleep_on(&queue);

eg not re-disabling interrupts after the sleep_on().....
to the point where just about every use of
sleep_on/interruptible_sleep_on is buggy
except in serial.c ;(
