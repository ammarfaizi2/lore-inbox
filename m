Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUGMEIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUGMEIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 00:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUGMEIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 00:08:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:36537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263847AbUGMEIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 00:08:49 -0400
Date: Mon, 12 Jul 2004 21:07:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: devenyga@mcmaster.ca, ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: Preempt Threshold Measurements
Message-Id: <20040712210701.46e2cd40.akpm@osdl.org>
In-Reply-To: <20040713025502.GR21066@holomorphy.com>
References: <200407121943.25196.devenyga@mcmaster.ca>
	<20040713024051.GQ21066@holomorphy.com>
	<200407122248.50377.devenyga@mcmaster.ca>
	<20040713025502.GR21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Mon, Jul 12, 2004 at 10:48:50PM -0400, Gabriel Devenyi wrote:
>  > Well I'm not particularly educated in kernel internals yet, here's some 
>  > reports from the system when its running.
>  > 6ms non-preemptible critical section violated 4 ms preempt threshold starting 
>  > at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
>  >  [<c014007b>] do_munmap+0xeb/0x140
>  >  [<c01163b0>] dec_preempt_count+0x110/0x120
>  >  [<c014007b>] do_munmap+0xeb/0x140
>  >  [<c014010f>] sys_munmap+0x3f/0x60
>  >  [<c0103ee1>] sysenter_past_esp+0x52/0x71
> 
>  Looks like ZAP_BLOCK_SIZE may be too large for you. Lowering that some
>  may "help" this. It's probably harmless, but try lowering that to half
>  of whatever it is now, or maybe 64*PAGE_SIZE. It may be worthwhile
>  to restructure how the preemption points are done in unmap_vmas() so
>  we don't end up in some kind of tuning nightmare.

Does that instrumentation patch have the cond_resched_lock() fixups?  If
not, this is a false positive.

The current setting of ZAP_BLOCK_SIZE is good for sub-500usec latencies on
a recentish CPU.

