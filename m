Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269002AbRHTUDe>; Mon, 20 Aug 2001 16:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269019AbRHTUDY>; Mon, 20 Aug 2001 16:03:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22153 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269002AbRHTUDN>; Mon, 20 Aug 2001 16:03:13 -0400
Date: Mon, 20 Aug 2001 15:03:25 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: george anzinger <george@mvista.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in/proc/<pid>/status
Message-ID: <59650000.998337805@baldur>
In-Reply-To: <3B816A65.5BA70FFF@mvista.com>
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu>
 <26210000.998324773@baldur> <3B815BFD.80D62209@mvista.com>
 <23580000.998333953@baldur> <3B816A65.5BA70FFF@mvista.com>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, August 20, 2001 12:52:05 -0700 george anzinger 
<george@mvista.com> wrote:

> But this (signal_struct) does not share the signals, just the
> infrastructure.  I believe the thread standard defines some signals that
> are to be delivered to a "thread leader" regardless of what actually
> caused the signal.  Thus for these signals a separate mask & signal
> queue seems in order.  I suppose one could use the union of all the
> thread masks or some such, but this seems like a lot of overhead.  Also
> need to introduce the concept of a "thread leader" (the thread that this
> group of signals is to be delivered to) and what happens when the
> "thread leader" exits (how a new "thread leader" is chosen).  I suspect
> that the standard addresses all this, but I don't yet have access to the
> standard.

Oh, I agree that a need exists for this kind of semantic.  I was just 
saying that we do have a place to add the info necessary for it.  We could 
add it to signal_struct, or we could create another structure that's shared 
in a similar fashion.

We can easily add the concept of 'thread group leader'.  We already have 
the task that has 'tgid == pid', ie the first task that called clone() with 
CLONE_THREAD.  It would be simple enough to expand on that.

Actually the signal semantics you want in the kernel aren't necessarily 
just an implementation of the POSIX process-wide semantic.  What you want 
is to assume there's a library that's implementing the semantic, and funnel 
the signals to it.  Directing them all to a single task (thread group 
leader, for example) is one good way to do it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

