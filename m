Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSEVOXd>; Wed, 22 May 2002 10:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314571AbSEVOXd>; Wed, 22 May 2002 10:23:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55237 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314553AbSEVOXb>;
	Wed, 22 May 2002 10:23:31 -0400
Date: Wed, 22 May 2002 09:14:53 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.17
Message-ID: <10810000.1022076893@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0205212013020.5712-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 21, 2002 08:21:56 PM -0700 Linus Torvalds
<torvalds@transmeta.com> wrote:

> The problem is just finding a _good_ context to switch to. We can do this
> two different ways:
> 
> (...)
> 
>  - my preferred solution: speculatively find _some_ process (preferably
>    one that we are likely to schedule next), and use that process's
>    "active_mm" to do a "switch_mm()" into (and set that to "current->mm")
> 
> The speculative thing has the problem of finding a good process, but I
> would suggest something along the lines of:
> 
>  - take the first process in the run-queue on the current CPU.
>  - if there is no process on th erun-queue, take our parent

What would be the incremental cost of just switching to init_mm?  Granted,
it's likely to require switching again when you schedule, but this is the
exit path.  It could be a fallback if nothing else looks good.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

