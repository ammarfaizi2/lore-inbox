Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUHNPJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUHNPJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 11:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHNPJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 11:09:29 -0400
Received: from 64.89.71.154.nw.nuvox.net ([64.89.71.154]:64209 "EHLO
	gate.apago.com") by vger.kernel.org with ESMTP id S263640AbUHNPJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 11:09:25 -0400
SMTP-Relay: dogwood.freil.com
Message-Id: <200408141509.i7EF9IgQ003286@dogwood.freil.com>
X-Mailer: exmh version 2.0.2 2/24/98
To: Darren Williams <dsw@gelato.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, lef@freil.com, lef@dogwood.freil.com
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7 
In-reply-to: Your message of "Sat, 14 Aug 2004 14:18:15 +1000."
             <20040814041815.GA10742@cse.unsw.EDU.AU> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Aug 2004 11:09:18 -0400
From: "Lawrence E. Freil" <lef@freil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren,
   I ran your test of "ls -laR of /etc >/dev/null" on our system and you
need to gen a kernel without himem and try it.  I get around .1 seconds
without himem and a whopping 4.45 with himem enabled.

I also tried without preemption and got the same results.  It is strictly
do to setting HIMEM in the kernel.

> Hi Lawrence
> 
> On Fri, 13 Aug 2004, Lawrence E. Freil wrote:
> 
> > Hello,
> >    
> > I'm following the kernel bug reporting format so:
> > 
> > 1. Linux 2.6.7 kernel slowdown in directory access with HIMEM on
> > 
> > 2. I have discovered an issue with the Linux 2.6.7 kernel when HIMEM is
> >    enabled which exhibits itself as a slowdown in directory access regardless
> >    of filesystem used.  When HIMEM is disabled the performance returns to
> >    normal.  The test I ran was a simple "/usr/bin/time ls -l" of a directory
> >    with 3000 empty files.  With HIMEM enabled in the kernel this takes
> >    approximately 1.5 seconds.  Without HIMEM it takes 0.03 seconds.  The
> >    time is 100% CPU and no I/O operations are done to disk.  "time" reports
> >    there are 460 "minor" page faults with zero "major" page faults.
> >    I believe the issue here is the mapping of pages between high-mem and
> >    lowmem in the kernel paging code.  This increase in time for directory
> >    accesses doubles to triples times for applications using samba.
> >    I have also tested this on another system which had only 512Meg of RAM
> >    but with HIMEM set in the kernel and did not experience the problem.
> >    I believe it only effects the performance when the paging buffers end
> >    up in highmem.
> > 
> > 3. Keywords: HIMEM, Performance
> > 
> Would you be running these in a gnome-terminal, I remember seeing a thread
> that discussed gnome-terminal problems though a quick search did not turn
> anything up. Here is what I get between a xterm and gnome-terminal.
> 
> xterm
> # time ls -lR /etc
> real    0m0.381s
> user    0m0.056s
> sys     0m0.130s
> 
> gnome-terminal
> # time ls -lR /etc
> real    0m0.869s
> user    0m0.057s
> sys     0m0.141s
> 
> I ran this twice in both teminals and reported the
> second result.
> 
> system info
> P4 3.06 HT
> 2.6.7 SMP/SMT/HIGHMEM
> 1GB ram
> 
> -------------------------------------------------
> Darren Williams <dsw AT gelato.unsw.edu.au>
> Gelato@UNSW <www.gelato.unsw.edu.au>
> --------------------------------------------------


