Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268047AbUHNESV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268047AbUHNESV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 00:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUHNESU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 00:18:20 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:34197 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268047AbUHNESS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 00:18:18 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Aug 2004 14:18:15 +1000
Cc: lef@freil.com
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Message-ID: <20040814041815.GA10742@cse.unsw.EDU.AU>
Mail-Followup-To: linux-kernel@vger.kernel.org, lef@freil.com
References: <200408140211.i7E2BNSg027992@dogwood.freil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408140211.i7E2BNSg027992@dogwood.freil.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lawrence

On Fri, 13 Aug 2004, Lawrence E. Freil wrote:

> Hello,
>    
> I'm following the kernel bug reporting format so:
> 
> 1. Linux 2.6.7 kernel slowdown in directory access with HIMEM on
> 
> 2. I have discovered an issue with the Linux 2.6.7 kernel when HIMEM is
>    enabled which exhibits itself as a slowdown in directory access regardless
>    of filesystem used.  When HIMEM is disabled the performance returns to
>    normal.  The test I ran was a simple "/usr/bin/time ls -l" of a directory
>    with 3000 empty files.  With HIMEM enabled in the kernel this takes
>    approximately 1.5 seconds.  Without HIMEM it takes 0.03 seconds.  The
>    time is 100% CPU and no I/O operations are done to disk.  "time" reports
>    there are 460 "minor" page faults with zero "major" page faults.
>    I believe the issue here is the mapping of pages between high-mem and
>    lowmem in the kernel paging code.  This increase in time for directory
>    accesses doubles to triples times for applications using samba.
>    I have also tested this on another system which had only 512Meg of RAM
>    but with HIMEM set in the kernel and did not experience the problem.
>    I believe it only effects the performance when the paging buffers end
>    up in highmem.
> 
> 3. Keywords: HIMEM, Performance
> 
Would you be running these in a gnome-terminal, I remember seeing a thread
that discussed gnome-terminal problems though a quick search did not turn
anything up. Here is what I get between a xterm and gnome-terminal.

xterm
# time ls -lR /etc
real    0m0.381s
user    0m0.056s
sys     0m0.130s

gnome-terminal
# time ls -lR /etc
real    0m0.869s
user    0m0.057s
sys     0m0.141s

I ran this twice in both teminals and reported the
second result.

system info
P4 3.06 HT
2.6.7 SMP/SMT/HIGHMEM
1GB ram

-------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
