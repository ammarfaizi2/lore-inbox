Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132860AbRBEGDR>; Mon, 5 Feb 2001 01:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132896AbRBEGDI>; Mon, 5 Feb 2001 01:03:08 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:1715 "HELO
	localdomain") by vger.kernel.org with SMTP id <S132860AbRBEGDA>;
	Mon, 5 Feb 2001 01:03:00 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
Organization: myCIO.com
Date: Sun, 4 Feb 2001 22:03:31 -0800
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <20010205162903.A15507@ftoomsh.progsoc.uts.edu.au>
In-Reply-To: <20010205162903.A15507@ftoomsh.progsoc.uts.edu.au>
Subject: Re: system call sched_yield() doesn't work on Linux 2.2
MIME-Version: 1.0
Message-Id: <01020422033100.09580@ewok.dev.mycio.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 February 2001 21:50, Matt wrote:
> in this case you will see that in 2.2.18 a SCHED_YIELD process will
> get a "goodness" value of 0, however in 2.4.1-ac1 you will find that
> it gets a value of -1 (and hence a lower scheduling priority). i dont
> have a machine handy that is running 2.2.18 that i can patch and
> reboot, how ever you may wish to change the return value on line 119
> of kernel/sched.c in 2.2.18 to -1 and you may find that it might give
> the behaviour you are looking for. it may also cause other
> problems. caveat emptor and all that..

I don't have a copy of POSIX 1003.1 (Realtime Extensions) with me now but if 
I remember well this states that sched_yield() should release the CPU to 
other threads with the same priority and never schedule task with lower ones.
Now, if for priority We mean static priority the current behaviour of 2.4.x 
is correct, but if We mean dynamic priority the current implementation does 
not respect the standard.
This coz the goodness() for that task will return -1, and this will make this 
process a loser even compared to ones with lower ( dynamic ) priority.
If the POSIX standard concept of priority is nearest to the dynamic one, 
probably a better solution would be a move_last_runqueue + clean_yield_flag.
Not that this will change the universe anyway ...



- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
