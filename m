Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbULCBFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbULCBFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 20:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbULCBFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 20:05:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261831AbULCBFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 20:05:18 -0500
Date: Thu, 2 Dec 2004 17:08:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alain Tesio <alain@onesite.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM=4G slows down ps2pdf with 2.4.28
Message-ID: <20041202190815.GA2843@dmt.cyclades>
References: <20041201232522.6e39c954@alain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201232522.6e39c954@alain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 11:25:22PM +0100, Alain Tesio wrote:
> Hi,
> 
> With a 2.4.28 kernel, 1.5 Go RAM and nothing exotic, everything works fine
> with CONFIG_HIGHMEM4G and CONFIG_HIGHMEM=y except that
> ps2pdf is about 30 times slower 
> 
> ps2pdf is a script using ghostscript with device=pdfwriter, I don't know if he's
> doing something special with memory allocations.
> 
> If you want to test it, use this file:
> http://www.floc.net/observer/USDP/hoyteclassical/hoyteclassical.ps
> (gs-gpl 8.01 on debian sid)
> 
> Other usual server daemons seems unaffected.
> 
> If this is a known behaviour for HIGHMEM to slow down random apps, it will
> be nice to put a warning in the make config help !

How does /proc/mtrr look like? 

Maybe some of your memory is configured as uncacheable.

> #lspci | grep bridge
> cat /proc0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
> 
> #cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  1579692032 1522913280 56778752        0 194080768 798294016
> Swap: 2147467264 19042304 2128424960
> MemTotal:      1542668 kB
> MemFree:         55448 kB
> MemShared:           0 kB
> Buffers:        189532 kB
> Cached:         766428 kB
> SwapCached:      13156 kB
> Active:         461848 kB
> Inactive:       800564 kB
> HighTotal:      646336 kB
> HighFree:         2044 kB
> LowTotal:       896332 kB
> LowFree:         53404 kB
> SwapTotal:     2097136 kB
> SwapFree:      2078540 kB
> 
> #cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 3.40GHz
> stepping        : 9
> cpu MHz         : 3400.211
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 6789.52
