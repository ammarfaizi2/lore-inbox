Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266766AbUGLID2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266766AbUGLID2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266754AbUGLIDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:03:17 -0400
Received: from holomorphy.com ([207.189.100.168]:60812 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266752AbUGLIDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:03:06 -0400
Date: Mon, 12 Jul 2004 01:02:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <20040712080259.GV21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <20040712003418.02997a12.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712003418.02997a12.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 12:34:18AM -0700, Andrew Morton wrote:
> OK, small problem.  We have code which does, effectively,
> 	if (need_resched()) {
> 		drop_the_lock();
> 		schedule();
> 		grab_the_lock();
> 	}
> so if need_resched() stays false then this will hold the lock for a long
> time and bogus reports are generated:
> 46ms non-preemptible critical section violated 1 ms preempt threshold starting at exit_mmap+0x26/0x188 and ending at exit_mmap+0x154/0x188
> To fix that you need to generate high scheduling pressure so that
> need_resched() is frequently true.  On all CPUs.  Modify realfeel to pin
> itself to each CPU, or something like that.

I suspect it's better to drop in hooks to trap those e.g. in
cond_resched() and cond_resched_lock().


On Mon, Jul 12, 2004 at 12:34:18AM -0700, Andrew Morton wrote:
> This rather decreases the patch's usefulness.
> The way I normally do this stuff is with
> 	http://www.zip.com.au/~akpm/linux/patches/stuff/rtc-debug.patch
> and `amlat', from http://www.zip.com.au/~akpm/linux/amlat.tar.gz
> It _might_ be sufficient to redefine need_resched() to just return 1 all
> the time.  If that causes the kernel to livelock then we need to fix that
> up anyway.

Less code... not sure how nasty performance the implications are.


-- wli
