Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbTL3Vft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbTL3Vfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:35:48 -0500
Received: from holomorphy.com ([199.26.172.102]:34499 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265805AbTL3Vfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:35:47 -0500
Date: Tue, 30 Dec 2003 13:35:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230213538.GH22503@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Molina <tmolina@cablespeed.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain> <Pine.LNX.4.58.0312291502210.1586@home.osdl.org> <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain> <20031230143929.GN27687@holomorphy.com> <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 04:14:13PM -0500, Thomas Molina wrote:
> I also get 90+ percent iowait under 2.6 and 0 iowait in 2.4.  I'm not sure 
> how the alleged suckiness of 2.6 paging fits into this.  On this system 
> the execution times are almost the same.  On this machine, in addition to 
> the iowait differences, there are cpu use statistics as reported by top.  
> On 2.4 idle time is 70 percent while on 2.6 the idle time is near zero 
> percent.  I'm not sure what the significance of this is.

2.4 does not report iowait; all iowait is reported as idle time on 2.4.

On Tue, Dec 30, 2003 at 04:14:13PM -0500, Thomas Molina wrote:
> CPU: PIII, speed 648.072 MHz (estimated)
> Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit mask of 0x00 (No unit mask) count 324036
> vma      samples  %           symbol name
> c0115e20 22498    22.6776     mark_offset_tsc
> c0110080 12707    12.8084     mask_and_ack_8259A
> c018eec0 7115      7.1718     ext3_find_entry
> c010ff60 4013      4.0450     enable_8259A_irq
> c0168d50 2650      2.6712     __d_lookup
> c015eb10 1727      1.7408     link_path_walk
> c010afd0 1482      1.4938     irq_entries_start

Well, it looks like Linus said various things along these lines in
various ways before I finished writing this, but in case hearing it a
second time is any reassurance:

There's a slight problem here in that you're io-bound, not cpu-bound,
so profiles won't actually tell us much about remaining overheads.

One thing here is that since turning off all the debugging options got
you down to about a 15% degradation, things aren't actually
looking anywhere near as problematic as before when you had a near 90%
degradation. One possible explanation is that the extensive padding
done by CONFIG_DEBUG_PAGEALLOC created significant memory pressure.

If you'd like further speedups, logging the things I suggested earlier
and trying fiddling with swappiness might help.

In fact, you are down to such a small margin of degradation that the
remaining degradation vs. 2.4 may in fact be due to using oprofile,
which has significant, though not overwhelming overhead.


-- wli
