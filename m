Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWCYISz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWCYISz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 03:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWCYISz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 03:18:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750731AbWCYISz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 03:18:55 -0500
Date: Sat, 25 Mar 2006 00:15:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: mrustad@mac.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16 hugetlbfs problem - DEBUG_PAGEALLOC
Message-Id: <20060325001519.45a6e150.akpm@osdl.org>
In-Reply-To: <200603250728.k2P7Sog25321@unix-os.sc.intel.com>
References: <20060324185331.56837b0a.akpm@osdl.org>
	<200603250728.k2P7Sog25321@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Andrew Morton wrote on Friday, March 24, 2006 6:54 PM
> > "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> > >
> > > Mark Rustad wrote on Friday, March 24, 2006 9:52 AM
> > >  > I have narrowed this down to DEBUG_PAGEALLOC. If that option is  
> > >  > enabled, attempts to reference areas mmap-ed from hugetlbfs files  
> > >  > fault forever. You can see that I had that set in the failing config  
> > >  > I reported below.
> > > 
> > >  Yeah, it turns out that the debug option is not compatible with hugetlb
> > >  page support. That debug option turns off PSE. Once it is turned off in
> > >  CR4, cpu will ignore pse bit in the pmd and causing infinite page-not-
> > >  present fault :-(
> > 
> > I wonder if any of the other architectures which implement both these
> > features might have problems too.
> 
> 
> Only 32-bit x86 arch implements both. We get away by not having DEBUG_PAGEALLOC
> feature on any other arch.

OK, thanks.

> ...
> I was going to verify that on my ia32 box, but apparently, turning on
> 64G highmem gives me machine reset at boot. (is it a known regression?)

Works OK here.

quad:/home/akpm> cat /proc/meminfo
MemTotal:      7251348 kB
MemFree:       7180680 kB
Buffers:         18868 kB
Cached:          20980 kB
SwapCached:          0 kB
Active:          32100 kB
Inactive:        14440 kB
HighTotal:     6422528 kB
HighFree:      6390924 kB
LowTotal:       828820 kB
LowFree:        789756 kB
SwapTotal:     4000040 kB
SwapFree:      4000040 kB
Dirty:             128 kB
Writeback:           0 kB
Mapped:          10112 kB
Slab:            11352 kB
CommitLimit:   7625712 kB
Committed_AS:    15292 kB
PageTables:        520 kB
VmallocTotal:   118776 kB
VmallocUsed:      2180 kB
VmallocChunk:   116356 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:     2048 kB


