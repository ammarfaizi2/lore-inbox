Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUDHS20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbUDHS2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:28:25 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:54478 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262143AbUDHS2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:28:24 -0400
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
In-Reply-To: <20040408181838.GN31667@dualathlon.random>
References: <20040408151415.GB31667@dualathlon.random>
	<1081438124.2105.207.camel@mulgrave>
	<20040408153412.GD31667@dualathlon.random>
	<1081439244.2165.236.camel@mulgrave>
	<20040408161610.GF31667@dualathlon.random>
	<1081441791.2105.295.camel@mulgrave>
	<20040408171017.GJ31667@dualathlon.random>
	<1081446226.2105.402.camel@mulgrave>
	<20040408175158.GK31667@dualathlon.random>
	<1081447654.1885.430.camel@mulgrave> 
	<20040408181838.GN31667@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2004 13:28:17 -0500
Message-Id: <1081448897.2105.465.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 13:18, Andrea Arcangeli wrote:
> it enterely depends on the workload. On a desktop machine there may be
> only some hundred entries in those lists at maximum with glibc being the
> biggest offender:
> 
> cat /proc/*/maps | grep libc.so.6 | wc -l
> 
> with shared memory on some server there can be easily several thousand
> entries for some inode even on 64bit, but a timeslice was probably
> exaggerated (the timeslice was for the walking of the ptes in each
> mapping too, I don't think you need to look at every pte).

So you're worried about our code?  OK, if you look, you'll see we only
have to flush one address in the mmap_shared list, (which is usually the
long list).

I'd constructed it on the predicate that flushing a non-current space is
more expensive than finding a current one, but I can alter it to flush
the first vma it comes to with a present translation.

The mmap list is usually empty.  We only excite that case for multiple
private mappings of a file which for some reason gets updated.

I'd be very surprised if flush_dcache_page executes more than a few
hundred instructions all told...that's certainly nowhere close to a
timeslice.

James


