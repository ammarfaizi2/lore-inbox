Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbUCPQhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUCPQIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:08:13 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:40325 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263375AbUCPQG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:06:59 -0500
From: Eric <eric@cisu.net>
To: Timothy Miller <miller@techsource.com>
Subject: Re: Scheduler: Process priority fed back to parent?
Date: Tue, 16 Mar 2004 10:06:02 -0600
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40571A62.8050204@techsource.com>
In-Reply-To: <40571A62.8050204@techsource.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403161006.02871.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 9:16 am, Timothy Miller wrote:
> Something occurred to me, so it has probably occurred to others as well. 
> :)
>
> Anyhow, the idea that I had was to feed information about a process's
> behavior (interactive/not) to the process's parent (and it's parent,
> etc).  The next time the parent forks, that information is used to
> initially estimate the priority of the forked process.

> This isn't perfect, but it would help distinguish between a user shell
> where compiles are being done and a user shell (say, Gnome) from which
> interactive processes are being launched.  Each process maintains a
> number which indicates the trends seen in the interactivity of its
> descendents.

> Another idea I had, but which I think I've seen discussed before, was to
> cache information about individual executables.  Every time a process
> terminates (and/or periodically), the behavior of that process is fed to
> a daemon which stores it on disk (on a periodic basis) in such a way
> that the kernel can efficiently get at it.  When the kernel launches a
> process, it looks at the cache for interactivity history to estimate
> initial priority.

	Sort of like what windows does with its prefetch stuff? Have a directory that 
contains info about the best way to run a particular program and its memory 
layouts/ disk accesses and patterns? 

> This way, after gcc has run a few times, it'll be flagged as a CPU-bound
> process and every time it's run after that point, it is always run at an
> appropriate priority.  Similarly, the first time xmms is run, its
> interactivity estimate won't be right, but after it's determined to be
> interactive, then the next time the program is launched, it STARTS with
> an appropriate priority:  no ramp-up time.

	This sounds like a good idea, however im not too versed in all the technical 
details. One thing I do see being a problem is do I really want the kernel 
doing a disk-read/write everytime something forks or starts a process? There 
would have to be some sort of cache. 
	Also, is it a good idea for the kernel to be writing/reading from disk, 
basing some of its decisions on disk files. Does this add filesystem specific 
complexity? As far as I know the kernel, never keeps any configuration on an 
actual hard disk. Everything is in /proc...etc... Something nags at me that 
its a bad idea to have the kernel read/write things it needs to run on a hard 
disk. 
	So if its a bad idea to write to disk we would have to keep the prefetch info 
in /proc, which will hog memory as more and more information is gathered, or 
we will lose our valuable information in between reboots. 
	If someone can explain why these things would/would not be a problem I think 
finding a better way to handle processes would be interesting.

	Overall it sounds like an ok idea if the specifics get hammered out. 
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
