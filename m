Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268972AbUINFIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268972AbUINFIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268999AbUINFIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:08:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:25535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268972AbUINFH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:07:27 -0400
Date: Mon, 13 Sep 2004 22:05:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: raybry@sgi.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-Id: <20040913220521.03d0e539.akpm@osdl.org>
In-Reply-To: <20040914044748.GZ9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<20040914044748.GZ9106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> read_proc_profile()
>  does not flush the per-cpu hashtables because flushing may cause
>  timeslice overrun on the systems where prof_buffer cacheline bounces
>  are so problematic as to livelock the timer interrupt.

That's a bit of a problem, isn't it?  As we can accumulate an arbitrarily
large number of hits within the hash table is it not possible that the
/proc/profile results could be grossly inaccurate?

If you had two front-ends per cpu to the profiling buffer then the CPU
which is running the /proc/profile read could tell all the other CPUs to
flip to their alternate buffer and can then perform accumulation at its
leisure.

How does oprofile get around this?  I guess in most modes the CPUs are not
synchronised.

One wonders how long we should keep flogging the /prof/profile profiling
code.  What systems are seeing this livelock?
