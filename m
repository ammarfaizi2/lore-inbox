Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131327AbRCNI1A>; Wed, 14 Mar 2001 03:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131331AbRCNI0u>; Wed, 14 Mar 2001 03:26:50 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:52983 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131327AbRCNI0h>; Wed, 14 Mar 2001 03:26:37 -0500
Message-ID: <3AAF2AB6.6E9E53F4@mvista.com>
Date: Wed, 14 Mar 2001 00:24:22 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, npsimons@fsmlabs.com,
        Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <Pine.LNX.4.21.0103132325140.2056-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 14 Mar 2001, Martin Dalecki wrote:
> 
> > Not the embedded folks!!! The server folks laugh histerically all
> > times they go via ssh to a trashing busy box to see what's wrong and
> > then they see top or ps auxe under linux never finishing they job:
> 
> That's a separate issue.
> 
> I guess the pagefault path should have _2_ locks.
> 
> One mmap_sem protecting read-only access to the address space
> and another one for write access to the adress space (to stop
> races with swapout, other page faults, ...).
> 
> At the point where the pagefault sleeps on IO, it could release
> the read-only lock, so vmstat, top, etc can get the statistics
> they need. Only during the time the pagefaulting code is actually
> messing with the address space could it block read access (to
> prevent others from seeing an inconsistent state).
> 
Is it REALLY necessary to prevent them from seeing an inconsistent
state?  Seems to me that in the total picture (i.e. system wide) they
will never see a consistent state, so why be concerned with a small
corner of the system.  Let them figure it out, possibly by consistency
checks, if they care.  It just seems unhealthy to demand consistency at
the cost of delays that will only make other data even more
inconsistent. And if the delay is _forever_ from a tool that may be used
to diagnose system problems...  I would rather a tool that repeatedly
showed the same inconsistent state than one that hangs because it can
not get a consistent one.

George
