Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268273AbUH2TIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268273AbUH2TIN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268278AbUH2TIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:08:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5514 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268273AbUH2TIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:08:09 -0400
Date: Sun, 29 Aug 2004 12:07:33 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: rl@hellgate.ch, linux-kernel@vger.kernel.org, albert@users.sourceforge.net
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-Id: <20040829120733.455f0c82.pj@sgi.com>
In-Reply-To: <20040829172022.GL5492@holomorphy.com>
References: <20040827122412.GA20052@k3.hellgate.ch>
	<20040827162308.GP2793@holomorphy.com>
	<20040828194546.GA25523@k3.hellgate.ch>
	<20040828195647.GP5492@holomorphy.com>
	<20040828201435.GB25523@k3.hellgate.ch>
	<20040829160542.GF5492@holomorphy.com>
	<20040829170247.GA9841@k3.hellgate.ch>
	<20040829172022.GL5492@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> get_tgid_list() is a sad story I don't have time to go into in depth.
> The short version is that larger systems are extremely sensitive to

Thanks, Roger and William, for your good work here.  I'm sure that SGI's
big bertha's will benefit.

In glancing at the get_tgid_list() I see it is careful to only pick off
20 (PROC_MAXPIDS) slots at a time.  But elsewhere in the kernel, I see
several uses of "do_each_thread()" which rip through the entire task
list in a single shot.

Is there a simple explanation for why it is ok in one place to take on
the entire task list in a single sweep, but in another it is important
to drop the lock every 20 slots?

>From the code and nice comments, I see that:
  (1) the work that had to be done by proc_pid_readdir(), the caller of
      get_tgid_list(), required dropping the task list lock, and
  (2) so the harvested tgid's had to be stashed in a temp buffer.

So perhaps the reason for not doing this in a single pass is:
  (3) it was not doable or not desirable (which one?) to size that temp
      buffer large enough to hold all the harvested tgid's in one pass.

But my understanding is losing the scent of the trail at this point.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
