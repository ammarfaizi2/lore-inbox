Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUCERsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbUCERsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:48:55 -0500
Received: from ns.suse.de ([195.135.220.2]:36054 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262187AbUCERsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:48:53 -0500
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 'simulator' and wave-form analysis tool?
References: <4048B36E.8000605@techsource.com>
From: Andi Kleen <ak@suse.de>
Date: 05 Mar 2004 18:48:52 +0100
In-Reply-To: <4048B36E.8000605@techsource.com.suse.lists.linux.kernel>
Message-ID: <p7365dj422j.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:

> Would it be a productive use of my time to work on this?

Not sure what you mean with waveform tool in this context, but
simulator logs can be indeed very useful to track down kernel bugs. I
used this excessively in the early days of the x86-64 port first with
the SimNow and later with the commercial Virtutech Simics
simulator. They both can generate a log file with all instructions and
all memory accesses. We wrote some post processing tools that added
the kernel symbols to that.  While processing these files (which can
quickly become several GB) was quite a stress test for less and the VM
it was often very useful. I can also only recommend XFS for such
uses, it seems to be by far the best file system for such workloads.

For example to find out who previously changed something in memory you
just need to search backwards for the same physical address.  The real
work usually was just to get a small enough "window" into the problem
to keep the log log files manageable. With logging the simulator runs
extremly slow and fills up disks quite quickly. I don't think it's
useful for complicated problems like races that take longer to trigger
(for longer running tests full logging is not practical), only for
something small and tricky that is relatively easy to repeat.

Writing a post processing tool that adds the symbols is not that complicated,
you can probably do it easily with any simulator log file. While it
would be possible to write a frontend to look for memory addresses
and automate other tasks just grep and less already work reasonably well.
With the amount of data involved you would probably want to do most
analysis as "batch" jobs.

-Andi
