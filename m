Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBGVX1>; Wed, 7 Feb 2001 16:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbRBGVXR>; Wed, 7 Feb 2001 16:23:17 -0500
Received: from mail1.cray.com ([136.162.0.111]:20217 "EHLO mail1.cray.com")
	by vger.kernel.org with ESMTP id <S129047AbRBGVXF>;
	Wed, 7 Feb 2001 16:23:05 -0500
From: piatz@cray.com
Message-Id: <200102072120.PAA68959@lambic.mw.cray.com>
Subject: Re: having a hard time with 2.4.x
To: Ulrich.Windl@rz.uni-regensburg.de (Ulrich Windl)
Date: Wed, 7 Feb 2001 15:20:22 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A810780.15805.1C14E0@localhost> from "Ulrich Windl" at Feb 07, 2001 08:30:07 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While attempting to port Linux to a new platform using a compiler other
then GCC I noticed that there appears to be a volatile missing on the
declaration of xtime in include/linux/sched.h.  The compiler I am using
considers this to be an error.  The following may help your problem.




include/linux/sched.h
*** sched.h     2001/02/05 21:48:10     1.3
--- sched.h     2001/02/07 05:19:09
***************
*** 533,539 ****
  extern unsigned long volatile jiffies;
  extern unsigned long itimer_ticks;
  extern unsigned long itimer_next;
! extern struct timeval xtime;
  extern void do_timer(struct pt_regs *);
  
  extern unsigned int * prof_buffer;
--- 533,539 ----
  extern unsigned long volatile jiffies;
  extern unsigned long itimer_ticks;
  extern unsigned long itimer_next;
! extern volatile struct timeval xtime;
  extern void do_timer(struct pt_regs *);


Ulrich Windl writes:
> 
> Hello,
> 
> I have some news on the topic of timekeeping in Linux-2.4:
> 
> As Alan Cox pointed out the ACPI changes between 2.4.0 and 2.4.1 created a 
> extremely slow console output (if not more). Configuring away ACPI support 
> solved that problem.
> 
> However there is still a problem that I cannot explain. I wrote a test program 
> for my modified kernel (I did not try the original one). I'll include the 
> program plus results (if you want to see the patch go to 
> ftp.kernel.org/pub/linux/daemons/ntp/PPS and get PPS-2.4.0-pre3.tar.bz2 (patch 
> plus signature)):
> 
> #include	<time.h>
> #include	<stdio.h>
> #define	NTP_NANO
> #include	<sys/timex.h>
> 
> int	main()
> {
> 	struct timex	tx;
> 	long		lastns = 0;
> 
> 	tx.modes = 0;
> 	while(1)
> 	{
> 		adjtimex(&tx);
> 		printf("%d %d %d\n",
> 		       tx.time.tv_sec, tx.time.tv_nsec,
> 		       tx.time.tv_nsec - lastns);
> 		lastns = tx.time.tv_nsec;
> 		fflush(stdout);
> 	}
> }


-- 
Steve Piatz                             piatz@cray.com
Cray Inc.                               651-605-9049
1340 Mendota Heights Road
Mendota Heights, MN 55120
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
