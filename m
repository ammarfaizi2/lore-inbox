Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUFXXRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUFXXRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUFXXRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:17:12 -0400
Received: from holomorphy.com ([207.189.100.168]:39565 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264531AbUFXXQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:16:15 -0400
Date: Thu, 24 Jun 2004 16:15:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624231549.GT21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, andrea@suse.de,
	nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de, ak@muc.de,
	tripperda@nvidia.com, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624220823.GO21066@holomorphy.com> <20040624224529.GA30687@dualathlon.random> <20040624225121.GS21066@holomorphy.com> <20040624160945.69185c46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624160945.69185c46.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 04:09:45PM -0700, Andrew Morton wrote:
> A testcase would be, on a 2G box:
> a) free up as much memory as you can
> b) write a 1.2G file to fill highmem with pagecache
> c) malloc(800M), bzero(), sleep
> d) swapoff -a
> You now have a box which has almost all of lowmem pinned in anonymous
> memory.  It'll limp along and go oom fairly easily.
> Another testcase would be:
> a) free up as much memory as you can
> b) write a 1.2G file to fill highmem with pagecache
> c) malloc(800M), mlock it
> You now have most of lowmem mlocked.

These are approximately identical to the testcases I had in mind, except
neither of these is truly specific to 2GB and can have the various magic
numbers calculated from sysconf() and/or meminfo.


On Thu, Jun 24, 2004 at 04:09:45PM -0700, Andrew Morton wrote:
> In both situations the machine is really sick.  Probably the most risky
> scenario is a swapless machine in which lots of lowmem is allocated to
> anonymous memory.
> It should be the case that increasing lower_zone_peotection will fix all
> the above.  If not, it needs fixing.
> So we're down the question "what should we default to at bootup".  I find
> it hard to justify defaulting to a mode where we're super-defensive against
> this sort of thing, simply because nobody seems to be hitting the problems.
> Distributors can, if the must, bump lower_zone_protection in initscripts,
> and it's presumably pretty simple to write a boot script which parses
> /proc/meminfo's MemTotal and SwapTotal lines, producing an appropriate
> lower_zone_protection setting.

I'm going to beat on this in short order, but will be indisposed for an
hour or two before that begins.

Thanks.


-- wli
