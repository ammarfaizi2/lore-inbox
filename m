Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUH2U0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUH2U0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUH2U0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:26:10 -0400
Received: from holomorphy.com ([207.189.100.168]:2480 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268280AbUH2U0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:26:06 -0400
Date: Sun, 29 Aug 2004 13:25:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       albert@users.sourceforge.net
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829202543.GV5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Paul Jackson <pj@sgi.com>,
	linux-kernel@vger.kernel.org, albert@users.sourceforge.net
References: <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829120733.455f0c82.pj@sgi.com> <20040829191707.GU5492@holomorphy.com> <20040829194926.GA3289@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829194926.GA3289@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 12:17:07 -0700, William Lee Irwin III wrote:
>> Introducing another whole-tasklist scan, even if feasible, is probably
>> not a good idea.

On Sun, Aug 29, 2004 at 09:49:26PM +0200, Roger Luethi wrote:
> I'm not sure whether I should participate in that discussion. I'll risk
> discrediting nproc with wild speculations on a subject I haven't really
> looked into yet. Ah well...

There isn't much to speculate about here; reducing the arrival rate to
tasklist_lock is okay, but it can't be held forever or use unbounded
allocations or anything like that.


On Sun, Aug 29, 2004 at 09:49:26PM +0200, Roger Luethi wrote:
> As far as nproc (and process monitoring) is concerned, we aren't really
> interested in walking a complete process list. All we care about is
> which pids exist right now. How about a bit field, maintained by the
> kernel, to indicate for each pid whether it exists or not? This would
> amount to 4 KiB by default and 512 KiB for PID_MAX_LIMIT (4 million
> processes). Maintenance cost would be one atomic bit operation per
> process creation/deletion. No contested locks.
> The list for the nproc user could be prepared based on the bit field
> (or simply memcpy'd), no tasklist_lock or walking linked lists required.
> What am I missing?

The pid bitmap could be exported to userspace rather easily.


-- wli
