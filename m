Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269222AbTGUEdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 00:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbTGUEdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 00:33:18 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:40126
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S269222AbTGUEdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 00:33:16 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16155.28785.946193.289544@wombat.chubb.wattle.id.au>
Date: Mon, 21 Jul 2003 14:47:45 +1000
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Erich Focht <efocht@hpce.nec.com>, LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [patch 2.6.0-test1] per cpu times
In-Reply-To: <20030718111850.C1627@w-mikek2.beaverton.ibm.com>
References: <200307181835.42454.efocht@hpce.nec.com>
	<20030718111850.C1627@w-mikek2.beaverton.ibm.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mike" == Mike Kravetz <kravetz@us.ibm.com> writes:

Mike> On Fri, Jul 18, 2003 at 06:35:42PM +0200, Erich Focht wrote:
>> This patch brings back the per CPU user & system times which one
>> was used to see in /proc/PID/cpu with 2.4 kernels. Useful for SMP
>> and NUMA scheduler development, needed for reasonable output in
>> numabench / numa_test.
>> 

Mike> On a somewhat related note ...

Mike> We (Big Blue) have a performance reporting application that
Mike> would like to know how long a task sits on a runqueue before it
Mike> is actually given the CPU.  In other words, it wants to know how
Mike> long the 'runnable task' was delayed due to contention for the
Mike> CPU(s).  Of course, one could get an overall feel for this based
Mike> on total runqueue length.  However, this app would really like
Mike> this info on a per-task basis.

Mike> Does anyone else think this type of info would be useful?

This is exactly what my microstate accounting patch does.

Per task figures for:
    -- how long on CPU
    -- how long on active queue
    -- how long on expired queue
    -- how long sleeping for paging
    -- how long sleeping in other non-interruptible state
    -- how long sleeping interruptibly
    -- how much time stolen for interrupts
    -- how long in system call
    -- how long sleeping on Futex
    -- how long sleeping for epoll, poll or select

I haven't yet added time spent handling traps, so the ONCPU time
includes pagefault and other trap time; also I've implemented the low
level timers only for X86 and IA64.  It'd be pretty trivial to add
other architectures.

The most recent published version of the patch is at
http://www.ussg.iu.edu/hypermail/linux/kernel/0306.3/0636.html 
(that one doesn't include all the states I mentioned, but the on-queue
times *are* counted)

There'll be another patch with more states soon.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
