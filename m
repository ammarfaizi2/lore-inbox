Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUCPPCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUCPPBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:01:52 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:41738 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262377AbUCPPBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:01:35 -0500
Message-ID: <40571A62.8050204@techsource.com>
Date: Tue, 16 Mar 2004 10:16:50 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Scheduler: Process priority fed back to parent?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something occurred to me, so it has probably occurred to others as well.  :)

Anyhow, the idea that I had was to feed information about a process's 
behavior (interactive/not) to the process's parent (and it's parent, 
etc).  The next time the parent forks, that information is used to 
initially estimate the priority of the forked process.

This isn't perfect, but it would help distinguish between a user shell 
where compiles are being done and a user shell (say, Gnome) from which 
interactive processes are being launched.  Each process maintains a 
number which indicates the trends seen in the interactivity of its 
descendents.


Another idea I had, but which I think I've seen discussed before, was to 
cache information about individual executables.  Every time a process 
terminates (and/or periodically), the behavior of that process is fed to 
a daemon which stores it on disk (on a periodic basis) in such a way 
that the kernel can efficiently get at it.  When the kernel launches a 
process, it looks at the cache for interactivity history to estimate 
initial priority.

This way, after gcc has run a few times, it'll be flagged as a CPU-bound 
process and every time it's run after that point, it is always run at an 
appropriate priority.  Similarly, the first time xmms is run, its 
interactivity estimate won't be right, but after it's determined to be 
interactive, then the next time the program is launched, it STARTS with 
an appropriate priority:  no ramp-up time.

