Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTKNJOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 04:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTKNJOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 04:14:20 -0500
Received: from bulge.astrouw.edu.pl ([193.0.88.25]:42425 "EHLO
	bulge.astrouw.edu.pl") by vger.kernel.org with ESMTP
	id S262221AbTKNJOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 04:14:18 -0500
Date: Fri, 14 Nov 2003 10:14:13 +0100
From: Michal Szymanski <msz@astrouw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: scheduler/swapper doing bad job (kernel 2.4.20-20.7smp)
Message-ID: <20031114091413.GA874@astrouw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a dual-P4 (2x2.2GHz) machine running RedHat 7.2 upgraded to
kernel 2.4.20-20.7smp, glibc 2.2.4-32.

Equipped with 1GB RAM, SCSI 160 adapter, three 2.5TB raid arrays
(IDE-to-SCSI hardware devices), Ultrium tape drive (on SCSI) and one IDE
disk with system and 2GB swap.

It is serving (NFS) data to 6-8 machines (not very intensively) and
running two jobs (memory and CPU intensive, plus some I/O). Each job
runs in cycles, starting a few programs sequentially, the biggest and
longest of which is 360MB. Normally it takes about a minute to complete
one cycle. 

If it runs as described above, everything works fine. But when I start
any I/O intensive additional job (like extracting data from Ultrium tape
to the RAID array), the system starts to behave weirdly. The swap use
grows quite fast from typical dozen-or-so MB to 300MB or more. One (at
first) and in a few minutes BOTH big jobs get practically stopped,
getting not more than 1% of CPU time. The system load grows from ~3
to 5 or more but 'top' reports 80-90% idle time for both CPUs.
The 'tar' is working fine, still.

At first I thought it happens because the big jobs are niced to 19. But
when I ran them with normal (0) priority, nothing did change.

Well, I would guess maybe I do not have enough memory, so the
scheduler/swapper places the big jobs on the swap. But, the 'tar' which
extracts data from tape, uses less than 1MB of memory, so it does not
seem to be the reason.

So I tried to do somewhat "risky" experiment: I disabled (with
everything running) the swap entirely. 'swapoff' took a minute or so to
complete but once the swap space was 0, the system immediately started
to work as expected, giving 80-90% of CPU to the big jobs, 10-20% to the
'tar'. 

The conclusion is rather discouraging - it seems that there is something
wrong with the scheduler/swapper. I'm no expert on these issues but as
an end user, I really can't understand why the system is working fine
w/o any swap and gets almost stopped with swap enabled. I guess adding
the swap should help rather than make things so bad.

Any ideas?

regards, Michal.

-- 
  Michal Szymanski (msz@astrouw.edu.pl)
  Warsaw University Observatory, Warszawa, POLAND
