Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVETQxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVETQxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVETQxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:53:14 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:18100 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261496AbVETQxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:53:08 -0400
Date: Fri, 20 May 2005 12:53:07 -0400
To: Olivier Croquette <ocroquette@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
Message-ID: <20050520165307.GG23488@csclub.uwaterloo.ca>
References: <428CD458.6010203@free.fr> <20050519182302.GE23621@csclub.uwaterloo.ca> <428CED0C.9020607@nortel.com> <20050520125511.GC23488@csclub.uwaterloo.ca> <428DF95E.2070703@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428DF95E.2070703@free.fr>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 04:51:10PM +0200, Olivier Croquette wrote:
> From the beginning we are talking about the present GNU/Linux systems, 
> which do already use NTPL in standard. NPTL is no future standard, it is 
> present standard.

Hmm, I just noticed the page I found about NPTL had 2005 date one place
and 2002 in another.  Yeah that is what people are using already.

Most current i386 systems do NOT use NPTL yet by default since it only
works on 2.6 kernels, and even then probably only if glibc was compiled
that way.

> This means basicly that 50% of your assertions (like the above) are 
> wrong, and your conclusions "suffer" from that :)
> 
> The point is that if you make a ps on a decent Linux based system, you 
> will *NOT* see one process for each thread. Nor they do appear in /proc.
> 
> This means there are *NOT* userland processes.
> 
> And therefore, you shall *NOT* be able to reference them as such where a 
> process ID is required.

Hmm, I just ran a pthread program and every thread shows up as a process
in ps.  Of course that is on a system with a 2.4 kernel compatible
glibc, so that is probably not a valid test.  Running on 2.6.11 on an
amd64 with glibc compiled for 2.6 kernels only, I only see one pid for
the multithreaded program.

Doing kill on the threadid on the amd64 does return ESRCH.

Make sure your test is on a 2.6 kernel system with glibc compiled to
only use nptl (so not 2.4 kernel compatible at all).  It appears to work
as you want it to now.

Len Sorensen
