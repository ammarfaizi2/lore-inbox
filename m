Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132297AbRANL3X>; Sun, 14 Jan 2001 06:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132302AbRANL3N>; Sun, 14 Jan 2001 06:29:13 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:40679 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132297AbRANL3B>; Sun, 14 Jan 2001 06:29:01 -0500
Message-ID: <3A618F17.FD285E2B@uow.edu.au>
Date: Sun, 14 Jan 2001 22:35:51 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>
Subject: Re: low-latency scheduling patch for 2.4.0
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> A patch against kernel 2.4.0 final which provides low-latency
> scheduling is at
> 
>         http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads
> 

This has been updated for 2.4.1-pre3

- Fixed latency problems with some /proc files and forking
  when many files are open.

- Fixed the tcp-minisocks thing.

- The patch now works properly on SMP.

  If a wakeup is directed to a SCHED_FIFO or SCHED_RR
  task then we request a reschedule on *all* non-idle
  CPUs.

  This causes any CPU which is holding a long-lived
  spinlock to bale out, allowing the target CPU to
  acquire the spinlock and then reschedule normally.

  Bit of a hack, but it works very well and there
  is no impact on the system unless there are
  non-SCHED_OTHER tasks running.

  Five lines of code :)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
