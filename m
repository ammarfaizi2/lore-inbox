Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289236AbSANNtB>; Mon, 14 Jan 2002 08:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSANNsv>; Mon, 14 Jan 2002 08:48:51 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:45316 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S289236AbSANNsm>;
	Mon, 14 Jan 2002 08:48:42 -0500
Date: Mon, 14 Jan 2002 06:45:48 -0700
From: yodaiken@fsmlabs.com
To: Momchil Velikov <velco@fadata.bg>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114064548.D22065@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C41A545.A903F24C@linux-m68k.org> <20020113153602.GA19130@fenrus.demon.nl> <E16PzHb-00006g-00@starship.berlin> <20020113223438.A19324@hq.fsmlabs.com> <87bsfx9led.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <87bsfx9led.fsf@fadata.bg>; from velco@fadata.bg on Mon, Jan 14, 2002 at 02:17:46PM +0200
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 02:17:46PM +0200, Momchil Velikov wrote:
> >>>>> "yodaiken" == yodaiken  <yodaiken@fsmlabs.com> writes:
> yodaiken> 	It's not even clear how preempt is supposed to interact with SCHED_FIFO.
> 
> How so ? The POSIX specification is not clear enough or it is not to be followed ?

POSIX makes no specification of how scheduling classes interact - unless something changed
in the new version.

But more than that, the problem of preemption is much more complex when you have
task that do not share the "goodness fade" with everything else. That is, given a
set of SCHED_OTHER processes at time T0, it is reasonable to design the scheduler so
that there is some D so that by time T0+D each process has become the highest priority
and has received cpu up to either a complete time slice or a I/O block. Linux kind of
has this property now, and I believe that making this more robust and easier to analyze
is going to be an enormously important issue.  However, once you add SCHED_FIFO in the
current scheme, this becomes more complex. And with preempt, you cannot even offer the
assurance that once a process gets the cpu it will make _any_ advance at all.



-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

