Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUDHSSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUDHSSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:18:41 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6066
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262175AbUDHSSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:18:40 -0400
Date: Thu, 8 Apr 2004 20:18:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408181838.GN31667@dualathlon.random>
References: <20040408151415.GB31667@dualathlon.random> <1081438124.2105.207.camel@mulgrave> <20040408153412.GD31667@dualathlon.random> <1081439244.2165.236.camel@mulgrave> <20040408161610.GF31667@dualathlon.random> <1081441791.2105.295.camel@mulgrave> <20040408171017.GJ31667@dualathlon.random> <1081446226.2105.402.camel@mulgrave> <20040408175158.GK31667@dualathlon.random> <1081447654.1885.430.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081447654.1885.430.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 01:07:31PM -0500, James Bottomley wrote:
> On Thu, 2004-04-08 at 12:51, Andrea Arcangeli wrote:
> > that path can take as long as timeslice to run, not taking interrupts
> > for a whole scheduler timeslice is pretty bad.
> 
> OK, now I'm confused.  Where's the whole timeslice bit coming from? the
> parisc flush_dcache_code better not take a timeslice to execute
> otherwise we're in very serious performance trouble.
> 
> Does it take as long as a timeslice to do mmap[_shared] list insertion?

it enterely depends on the workload. On a desktop machine there may be
only some hundred entries in those lists at maximum with glibc being the
biggest offender:

cat /proc/*/maps | grep libc.so.6 | wc -l

with shared memory on some server there can be easily several thousand
entries for some inode even on 64bit, but a timeslice was probably
exaggerated (the timeslice was for the walking of the ptes in each
mapping too, I don't think you need to look at every pte).
