Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRDJT5N>; Tue, 10 Apr 2001 15:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbRDJT4x>; Tue, 10 Apr 2001 15:56:53 -0400
Received: from iris.mc.com ([192.233.16.119]:17098 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131988AbRDJT4q>;
	Tue, 10 Apr 2001 15:56:46 -0400
Message-ID: <3AD366DC.478E4AF@mc.com>
Date: Tue, 10 Apr 2001 16:02:36 -0400
From: mark salisbury <mbs@mc.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:

> f) As noted, the account timers (task user/system times) would be much
> more accurate with the tick less approach.  The cost is added code in
> both the system call and the schedule path.
>
> Tentative conclusions:
>
> Currently we feel that the tick less approach is not acceptable due to
> (f).  We felt that this added code would NOT be welcome AND would, in a
> reasonably active system, have much higher overhead than any savings in
> not having a tick.  Also (d) implies a list organization that will, at
> the very least, be harder to understand.  (We have some thoughts here,
> but abandoned the effort because of (f).)  We are, of course, open to
> discussion on this issue and all others related to the project
> objectives.

f does not imply tick-less is not acceptable, it implies that better process time
accounting is not acceptable.

list organization is not complex, it is a sorted absolute time list.  I would
argue that this is a hell of a lot easier to understand that ticks + offsets.

still, better process time accounting should be a compile CONFIG option, not
ignored and ruled out because some one thinks that is is to expensive in the
general case.

the whole point of linux and CONFIG options is to get you the kernel with the
features you want, not what someone else wants.

there should be a whole range of config options associated with this issue:

CONFIG_JIFFIES   == old jiffies implementation
CONFIG_TICKLESS  == tickless
CONFIG_HYBRID  == old jiffies plus a tickless high-res timer system on
                                    the side but not assoc w/ process and global
timekeeping

CONFIG_USELESS_PROCESS_TIME_ACCOUNTING = old style, cheap time acctg
CONFIG_USEFUL_BUT_COSTS_TIME_ACCOUNTING = accurate but expensive time accounting

this way, users who want tickless and lousy time acctg can have it AND people who
want jiffies and good time acctg could have it.

these features are largely disjoint and easily seperable.  it is also relatively
trivial to do this in such a way that drivers depending on the jiffie abstraction
can be supported without modification no matter what the configuration.

    Mark Salisbury

