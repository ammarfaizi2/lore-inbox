Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268958AbRHTTwb>; Mon, 20 Aug 2001 15:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268968AbRHTTwV>; Mon, 20 Aug 2001 15:52:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23289 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S268958AbRHTTwO>; Mon, 20 Aug 2001 15:52:14 -0400
Message-ID: <3B816A65.5BA70FFF@mvista.com>
Date: Mon, 20 Aug 2001 12:52:05 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave McCracken <dmc@austin.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in/proc/<pid>/status
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu>
	 <26210000.998324773@baldur> <3B815BFD.80D62209@mvista.com> <23580000.998333953@baldur>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:
> 
> --On Monday, August 20, 2001 11:50:37 -0700 george anzinger
> <george@mvista.com> wrote:
> 
> > Are you possibly also looking into allocating a small data structure to
> > the thread group?  A place to keep thread group signal info, perhaps?
> 
> No, not specifically.  A mechanism already exists to share info between
> cooperating tasks, where there's a common structure pointed to by each task
> (ie mm_struct, signal_struct, files_struct, fs_struct, etc).  I think we
> can use this mechanism for any info a group of tasks needs to share.
> 
But this (signal_struct) does not share the signals, just the
infrastructure.  I believe the thread standard defines some signals that
are to be delivered to a "thread leader" regardless of what actually
caused the signal.  Thus for these signals a separate mask & signal
queue seems in order.  I suppose one could use the union of all the
thread masks or some such, but this seems like a lot of overhead.  Also
need to introduce the concept of a "thread leader" (the thread that this
group of signals is to be delivered to) and what happens when the
"thread leader" exits (how a new "thread leader" is chosen).  I suspect
that the standard addresses all this, but I don't yet have access to the
standard.

Then, again, I could be suffering from too much coffee :)

George
