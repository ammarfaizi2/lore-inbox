Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRDJMlp>; Tue, 10 Apr 2001 08:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRDJMlI>; Tue, 10 Apr 2001 08:41:08 -0400
Received: from iris.mc.com ([192.233.16.119]:19151 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S132337AbRDJMkG>;
	Tue, 10 Apr 2001 08:40:06 -0400
From: Mark Salisbury <mbs@mc.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, ak@suse.de (Andi Kleen)
Subject: Re: No 100 HZ timer !
Date: Tue, 10 Apr 2001 08:27:13 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        mbs@mc.com (Mark Salisbury), jdike@karaya.com (Jeff Dike),
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <E14mx0K-00049P-00@the-village.bc.nu>
In-Reply-To: <E14mx0K-00049P-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <0104100832191C.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Alan Cox wrote:
> > Does not sound very attractive all at all on non virtual machines (I see the point on
> > UML/VM):
> > making system entry/context switch/interrupts slower, making add_timer slower, just to 
> > process a few less timer interrupts. That's like robbing the fast paths for a slow path.
> 
> Measure the number of clocks executing a timer interrupt. rdtsc is fast. Now
> consider the fact that out of this you get KHz or better scheduling 
> resolution required for games and midi. I'd say it looks good. I agree
> the accounting of user/system time needs care to avoid slowing down syscall
> paths
> 
> Alan

the system I implemented this in went from 25 Millisecond resolution to 25-60
Nanosecond resolution (depending on the CPU underneath).  that is a theoretical
factor of 500,000 to 1,000,000 improvement in resolution for timed events, and
the clock overhead after the change was about the same. (+-10% depending on
underlying CPU)

this is on a system that only had one clock tick per process quantum, as
opposed to the 10 in linux.





-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

