Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265875AbUFXWY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUFXWY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUFXWW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:22:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37267
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265887AbUFXWVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:21:46 -0400
Date: Fri, 25 Jun 2004 00:21:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, nickpiggin@yahoo.com.au,
       tiwai@suse.de, ak@suse.de, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624222150.GZ30687@dualathlon.random>
References: <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624145441.181425c8.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 02:54:41PM -0700, Andrew Morton wrote:
> First thing to do is to identify some workload which needs the patch. 

that's quite trivial, boot a 2G box, malloc(1G), bzero(1GB), swapoff -a,
then the machine will lockup.

Depending on the architecture (more precisely depending if it starts
allocating ram from the end or from the start of the physical memory),
you may have to load 1G of data into pagecache first, like reading from
/dev/hda 1G (without closing the file) will work fine, then run the
above malloc + bzero + swapoff.

Most people will never report this because everybody has swap and they
simply run a lot slower than they could run if they didn't need to pass
through the swap device to relocate memory because memory would been allocated
in the right place in the first place. this plus the various oom killer
breakages that gets dominated by the nr_swap_pages > 0 check, are the
reasons 2.6 is unusable w/o swap. 
