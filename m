Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUEGUJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUEGUJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUEGUI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:08:26 -0400
Received: from holomorphy.com ([207.189.100.168]:1950 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263702AbUEGUII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:08:08 -0400
Date: Fri, 7 May 2004 11:17:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040507181706.GR1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Jack Steiner <steiner@sgi.com>,
	linux-kernel@vger.kernel.org
References: <20040501120805.GA7767@sgi.com> <20040501211704.GY1445@holomorphy.com> <20040507175358.GD3829@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507175358.GD3829@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 02:17:04PM -0700, William Lee Irwin III wrote:
>> Would something like this help cacheline contention? This uses the
>> per_cpu data areas to hold per-cpu booleans for needing switches.
>> Untested/uncompiled.
>> The global lock is unfortunately still there.

On Fri, May 07, 2004 at 07:53:58PM +0200, Andrea Arcangeli wrote:
> I'm afraid this cannot help, the rcu_cpu_mask and the mutex are in the same
> cacheline, so it's not just about the global lock being still there,
> it's about the cpumask being in the same cacheline with the global lock.

Hmm. I can't quite make out what you're trying to say. If it were about
the cpumask sharing the cacheline with the global lock, then the patch
would help, but you say it should not. I don't care much about the
conclusion, since I wrote the patch to express the notion that the
concentration of accesses to the cpumask's shared cacheline(s) could be
dispersed by using integers in per_cpu data to represent the individual
bits of the cpumask if that were the problem, and by trying something
similar to the posted patch, it could be determined if that were so,
but later heard back that it'd been determined by other means that it
was the lock itself...

-- wli
