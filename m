Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbUAaVKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 16:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUAaVKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 16:10:55 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:49567 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S264905AbUAaVKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 16:10:53 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sat, 31 Jan 2004 21:49:14 +0100
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org, molnar@elte.hu,
       phil-list@redhat.com
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131204914.GB2160@kiste>
References: <20040131104606.GA25534@kiste> <20040131153743.GA13834@outpost.ds9a.nl> <20040131155155.GA1504@kiste> <20040131161805.GA15941@outpost.ds9a.nl> <20040131181518.GB1815@kiste> <20040131191923.GA21333@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131191923.GA21333@outpost.ds9a.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

bert hubert:
> [Matthias reports that threads forking multiple programs and running waitpid
>  on them has problems] 
> 
To recap:

This process, on a SMP machine, does generate a few threads. Each
thread forks off some process, which it then waitpid()s for.
There is no SIGCHLD handler.

All but the last of these waitpid()s, as seen in strace output, never
return.

31342 <... clone resumed> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x416dbc18) = 31346
31346 execve("/usr/bin/apt-ftparchive", ["apt-ftparchive", "packages", "testing/all"], [/* 12 vars */] <unfinished ...>
31346 <... execve resumed> )            = 0
31346 exit_group(0)                     = ?
31340 --- SIGCHLD (Child exited) @ 0 (0) ---
31342 waitpid(31346,  <unfinished ...>

Your test program works... except that it reports, when I strace it,

[pid 10629] waitpid(10631, Process 10629 suspended
 <unfinished ...>
[pid 10628] <... mmap2 resumed> )       = 0x41966000
[pid 10630] waitpid(10632, Process 10630 suspended
<unfinished ...>

Those "Process ### suspended" messages did NOT happen with the Python
script that exhibits the bug.

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
