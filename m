Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWESTPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWESTPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 15:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWESTPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 15:15:15 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:34705 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S932469AbWESTPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 15:15:14 -0400
Date: Fri, 19 May 2006 21:15:12 +0200
To: Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060519191512.GB22346@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it> <20060518155848.GC17498@cs.unibo.it> <p73sln72im3.fsf@bragg.suse.de> <20060518211321.GC6806@cs.unibo.it> <a36005b50605181923k285b4d50y30d6b43baede95ca@mail.gmail.com> <20060519090726.GA11789@cs.unibo.it> <20060519130952.GA1242@nevyn.them.org> <20060519174534.GA22346@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519174534.GA22346@cs.unibo.it>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for the sake of completeness here are the numbers:

This was the previous result.
> (test computer=tibook G4 1Ghz)
> Umview+unreal test module/NO PTRACE_MULTI/NO PTRACE_SYSVM
> $ time cp /unreal/usr/src/linux-source-2.6.16.tar.bz2 /tmp
> real    0m22.626s
> user    0m0.000s
> sys     0m0.448s

This operation cannot use /proc/<pid>/mem  as there is a "read" from
the virtual file system that has to write the buffer value into the
ptraced process ("cp") memory.

Let us try the reverse op.

****OLD WAY
Umview+unreal test module/NO PTRACE_MULTI/NO PTRACE_SYSVM (PTRACE, old
way)
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /unreal/tmp
real    0m16.039s
user    0m0.000s
sys     0m0.208s

****YOUR PROPOSAL WITHOUT/WITH SYSVM (that patch is independent).
Umview+unreal test module/NO PTRACE_MULTI/NO PTRACE_SYSVM (using
/proc/<pid>/mem)
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /unreal/tmp
real    0m1.649s
user    0m0.000s
sys     0m0.172s

Umview+unreal test module/NO_PTRACE_MULTI PTRACE_SYSVM (using
/proc/<pid>/mem)
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /unreal/tmp
real    0m1.185s
user    0m0.004s
sys     0m0.188s

****OUR PROPOSAL (PTRACE_MULTI instead of /proc/<pid>/mem (WO/W SYSVM)
Umview+unreal test module PTRACE_MULTI/NO PTRACE_SYSVM
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /unreal/tmp
real    0m1.500s
user    0m0.004s
sys     0m0.244s

Umview+unreal test module PTRACE_MULTI/PTRACE_SYSVM
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /unreal/tmp
real    0m0.983s
user    0m0.008s
sys     0m0.148s

All the experiments have been done three times. This is the best time
(always the third); the results would have had the same significance
taking the first or the second run figures, the difference in time would have
been a bit higher.

Anyway I think I'll put this possibility (to use /proc/<pid>/mem) inside umview 
source code.
It is a speedup for umview on unpatched kernel, just a one way speedup,
but it can help. Thank you for the hint.
I think that our patch(es) would be useful anyway as the solution you
propose is not a solution at all.
In the best approximation this is a workaround that covers part of the
problems with almost the same (a bit poorer) performance.

renzo
