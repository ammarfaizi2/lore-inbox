Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQJ3IME>; Mon, 30 Oct 2000 03:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQJ3ILo>; Mon, 30 Oct 2000 03:11:44 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:4614 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129066AbQJ3ILi>; Mon, 30 Oct 2000 03:11:38 -0500
Date: Mon, 30 Oct 2000 01:08:08 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030010808.B19615@vger.timpanogas.org>
In-Reply-To: <20001030002019.B19136@vger.timpanogas.org> <Pine.LNX.4.21.0010300934200.872-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010300934200.872-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 09:39:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 09:39:37AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > Is there an option to map Linux into a flat address space [...]
> 
> nope, Linux is fundamentally multitasked.
> 
> what you can do to hack around this is to not switch to the idle thread
> after having done work in nfsd. Some simple & stupid thing in schedule:
> 
> 	if (next == idle_task) {
> 		while (nr_running)
> 			barrier();
> 		goto repeat_schedule;
> 	}
> 
> (provided you are testing this on a UP system.) This way we do not destroy
> the TLB cache when we wait a few microseconds for the next network
> interrupt.
> 
> we do this in 2.4 already - ie. nfsd doesnt have to mark itself lazy-MM,
> the idle thread will automatically 'inherit' the MM of nfsd, and is going
> to switch CR3 only if the next process is not nfsd. So you can get an
> apples to apples comparison by using 2.4.

Ingo, I will attempt this, but I doubt seriously it will allow 
Linux to defeat NetWare 5.x on LAN I/O scaling.  ALl protection 
has to go away in all LAN paths for this to happen, and user space
apps set to ring 0.  NetWare 5.cx does support ring 3 applications,
but the model is different than Linux.  I will look at a potential 
compromise between the two with the MANOS /arch merge.   It may 
allow some incarnation of Linux to smoke NetWare 5.x on LAN 
performance.  Doing this would move MARS-NWE and SAMBA into the kernel
without changing a line of code in either...

Jeff


> 
> 	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
