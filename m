Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRA3Uwg>; Tue, 30 Jan 2001 15:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132105AbRA3UwT>; Tue, 30 Jan 2001 15:52:19 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:58123 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S131324AbRA3UwL>;
	Tue, 30 Jan 2001 15:52:11 -0500
Date: Tue, 30 Jan 2001 13:51:54 -0700
From: yodaiken@fsmlabs.com
To: David Woodhouse <dwmw2@infradead.org>
Cc: Joe deBlaquiere <jadb@redhat.com>, yodaiken@fsmlabs.com,
        Andrew Morton <andrewm@uow.edu.au>, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010130135154.B27260@hq.fsmlabs.com>
In-Reply-To: <3A75A70C.4050205@redhat.com> <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com> <3A75A70C.4050205@redhat.com> <30672.980867280@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.4us
In-Reply-To: <30672.980867280@redhat.com>; from David Woodhouse on Tue, Jan 30, 2001 at 03:08:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The thing that really does concern me about the flash driver code is the
> fact that it often wants to wait for about 100µs. On machines with
> HZ==100, that sucks if you use udelay() and it sucks if you schedule(). So
> we end up dropping the spinlock (so at least bottom halves can run again)
> and calling:
> 
> static inline void cfi_udelay(int us)
> {
>         if (current->need_resched)
>                 schedule();
>         else
>                 udelay(us);
> }

So then a >100us delay is ok ?

I have a dumb RT perspective: either you have to make the deadline or you don't.
If you have to make the deadline, then why are you checking need_resched?



-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
