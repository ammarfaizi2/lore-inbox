Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUDHV7v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUDHV7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:59:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31428
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262788AbUDHV7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:59:49 -0400
Date: Thu, 8 Apr 2004 23:59:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040408215946.GU31667@dualathlon.random>
References: <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay> <20040408001845.GX26888@dualathlon.random> <1479132704.1081405456@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479132704.1081405456@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 11:24:16PM -0700, Martin J. Bligh wrote:
> Instead of fiddling with tuning knobs, I'd prefer to just do the UKVA
> idea I've proposed before, and let each process have their own pagetables
> mapped permanently ;-)

that will have you pay for pte-highmem even in non-highmem machines.
I'm always been against your above idea ;) It can speedup mmap a bit for
some uncommon case but I believe your slowdown comes from the page faults after
exeve and startup not from mmap with the kernel compile, and worst of
all for non-highmem too (no sysctl or tuning knob can save you then).
Amittedly some mmap intensive workload can get a slight speedup compared
to pte-highmem but I don't think it's common and it has the potential of
slowing down the page faults especially in short lived tasks even w/o
highmem.

What I found attractive was the persistent kmap in userspace, but that
idea breaks with threading, and Andrew found another way that is to make
the page fault interruptible so it doesn't seem very worthwhile anymore
even w/o threading.
