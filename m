Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRC3Gdh>; Fri, 30 Mar 2001 01:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130824AbRC3Gd2>; Fri, 30 Mar 2001 01:33:28 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:32525 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130820AbRC3GdJ>;
	Fri, 30 Mar 2001 01:33:09 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: george anzinger <george@mvista.com>
cc: Dipankar Sarma <dipankar@sequent.com>, nigel@nrg.org,
   linux-kernel@vger.kernel.org, mckenney@sequent.com
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Wed, 28 Mar 2001 12:51:02 PST."
             <3AC24EB6.1F0DD551@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Mar 2001 22:32:13 -0800
Message-ID: <6732.985933933@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2001 12:51:02 -0800, 
george anzinger <george@mvista.com> wrote:
>Dipankar Sarma wrote:
>> 1. Disable pre-emption during the time when references to data
>> structures
>> updated using such Two-phase updates are held.
>
>Doesn't this fly in the face of the whole Two-phase system?  It seems to
>me that the point was to not require any locks.  Preemption disable IS a
>lock.  Not as strong as some, but a lock none the less.

The aim is to remove all module locks from the main kernel path and
move the penalty for module unloading into the task doing the unload.
Only the unload code needs to worry about preemption, not the main
kernel code paths, so main line code runs faster and scales better.  I
don't care how long (within reason) it takes to unload a module, it is
such a rare event.  I want module unload to be race free with zero
impact on the fast code paths, the current design penalizes the fast
code paths.

