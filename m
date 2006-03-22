Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWCVGbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWCVGbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWCVGbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:31:35 -0500
Received: from fmr21.intel.com ([143.183.121.13]:43926 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750820AbWCVGbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:31:35 -0500
Date: Tue, 21 Mar 2006 22:31:21 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Linux v2.6.16
Message-ID: <20060321223120.A4003@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <4420DF21.8060700@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4420DF21.8060700@bigpond.net.au>; from pwil3058@bigpond.net.au on Tue, Mar 21, 2006 at 09:22:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 09:22:41PM -0800, Peter Williams wrote:
> 
>    I/O APICs
>    Mar 22 16:10:31 heathwren kernel: More than 8 CPUs detected and
>    CONFIG_X86_PC cannot handle it.
> 
>    ###  No more CPUs seen but something in there thinks there's more than
>    8
>    of them.
> 
>    Mar 22 16:10:31 heathwren kernel: Use CONFIG_X86_GENERICARCH or
>    CONFIG_X86_BIGSMP.
> 


This was disussed here,  

http://marc.theaimsgroup.com/?l=linux-kernel&m=114228068804099&w=2

but we didnt yet close out on it, Andrew didnt feel comfortable
making CONFIG_HOTPLUG_CPU depend on !X86_PC, and making it depend on CONFIG_GENERICARCH
or CONFIG_BIGSMP this late in the process.

The warning is bogus, when BIGSMP was first introduced it was solely to handle >8 CPUS
using custer mode configuration. We switched bigsmp to use flat physical mode just like 
what we do for x86_64, because some chipsets have ill effects with cpu hotplug.
when we wakeup a new cpu. Details here

http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2

Hence we switched to bigsmp, but the error message was not reworked, better yet is
to have the right config depends so we dont run into any race and instability issues.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
