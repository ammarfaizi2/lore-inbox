Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284536AbRLJXEz>; Mon, 10 Dec 2001 18:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284535AbRLJXEo>; Mon, 10 Dec 2001 18:04:44 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34248 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284730AbRLJXEj>;
	Mon, 10 Dec 2001 18:04:39 -0500
Date: Mon, 10 Dec 2001 15:03:42 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
Message-ID: <20011210150342.C1124@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <E16DF5E-00009N-00@the-village.bc.nu> <Pine.LNX.4.40.0112091729180.996-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0112091729180.996-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Sun, Dec 09, 2001 at 05:38:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 05:38:42PM -0800, Davide Libenzi wrote:
> Coming at the pipe example, let's take Larry's lat_ctx ( lmbench ).
> This is bouncing data through pipes using I/O bound tasks, and running
> vmstat together with a lat_ctx 32 32 ... ( long list ), you'll see the run
> queue length barley reach 3 ( with 32 bouncing tasks ).
> It barely reaches 5 with 64 bouncing tasks.

This may show my ignorance, but ... Why would one expect much
more than 2 runnable tasks as a result of a running lat_ctx?
This benchmark simply passes a token around a ring of tasks.  
One task awakens the next, then goes to sleep.  The only time
you have more than one runnable task is during the times when
the token is passed between tasks.  In these transition times
I would rarely expect more than 2 tasks on the runqueue no
matter how many bouncing tasks you have. 

We created a benchmark similar to lat_ctx that would allow you
to control how many runnable tasks there are in the system.
Look for 'Reflex' benchmark at:
http://lse.sourceforge.net/scheduling/
You can think of this as a controlled way of running multiple
copies of lat_ctx in parallel.

-- 
Mike
