Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbTCJT0n>; Mon, 10 Mar 2003 14:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbTCJT0n>; Mon, 10 Mar 2003 14:26:43 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61066 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261406AbTCJT0l>; Mon, 10 Mar 2003 14:26:41 -0500
Date: Mon, 10 Mar 2003 11:27:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>,
       linux-kernel@vger.kernel.org
Subject: Re: OOPS in do_try_to_free_pages with VERY large software RAID array
Message-ID: <6240000.1047324468@flay>
In-Reply-To: <8075D5C3061B9441944E1373776451180F0761@cinshrexc03.shermfin.com>
References: <8075D5C3061B9441944E1373776451180F0761@cinshrexc03.shermfin.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can anyone help me out please?  I'm trying to create a monster software
> RAID array and the kernel is not behaving.  On some test hardware I can
> get 17 RAID1 arrays to begin syncing and will sync with
> /proc/sys/dev/raid/speed_limit_max set to 100000 (the max allowed) with
> no problem.  
> 
> We wanted to use 26 RAID1 arrays and then stripe across them to get very
> high performance.  When I tried to do that this weekend on our
> production box we started getting kernel panics when the RAID1 arrays
> started syncing.  This was with speed_limit_max set to 10000 so the rate
> wasn't very high.  Since we knew 34 disks worked we decided to put the
> box in to production with just 13 RAID1 arrays and striping across
> those.  The performance is great compared to our hardware RAID, but I
> would like to get all the disks we purchase for this system working.
> 
> This morning I connected 56 disks to our test hardware and tried to
> reproduce the problem.  With the test hardware, the 26 RAID1 arrays were
> working OK at speed_limit_max 10000 however the kernel OOPSed when I
> 'less'ed /proc/mdstat.  It wasn't a hard crash because I could still
> work.  However when I upped the speed_limit_max to 30000 there was a
> hard crash.

At a wild guess (OK, I only looked for about 1 minute),
md_status_read_proc is generating more than 4K of information, and overwriting
the end of it's 4K page. Throw some debug in there, and get it to printk
how much of the buffer it thinks it's using (just printk sz every time it
changes it). If it's > 4K, convert it to the seq_file interface.

May not be it, but it seems likely given the unusual scale of what you're
doing, and it's easy to check.

M.



