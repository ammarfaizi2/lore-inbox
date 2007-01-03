Return-Path: <linux-kernel-owner+w=401wt.eu-S1751020AbXACE5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXACE5E (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 23:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbXACE5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 23:57:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:55975 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbXACE5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 23:57:02 -0500
Date: Wed, 3 Jan 2007 10:26:59 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Rene Herman <rene.herman@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: CONFIG_PHYSICAL_ALIGN limited to 4M?
Message-ID: <20070103045659.GC17546@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <459A3C6E.7060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459A3C6E.7060503@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 12:05:18PM +0100, Rene Herman wrote:
> Good day.
> 
> A while ago it was remarked on list here that keeping the kernel 4M
> aligned physically might be a performance win if the added 1M (it
> normally loads at 1M) meant it would fit on one 4M aligned hugepage
> instead of 2 and since that time I've been doing such.
> 
> In fact, while I was at it, I ran the kernel at 16M; while admittedly a
> bit of a non-issue, having never experienced ZONE_DMA shortage, I am an
> ISA user on a >16M machine so this seemed to make sense -- no kernel
> eating up "precious" ISA-DMAable memory.
> 
> Recently CONFIG_PHYSICAL_START was replaced by CONFIG_PHYSICAL_ALIGN
> (commit e69f202d0a1419219198566e1c22218a5c71a9a6) and while 4M alignment
> is still possible, that's also the strictest alignment allowed meaning I
> can't load my (non-relocatable) kernel at 16M anymore.
> 
> If I just apply the following and set it to 16M, things seem to be
> working for me. Was there an important reason to limit the alignment to
> 4M, and if so, even on non relocatable kernels?

Hi Rene,

Can't think of any reason why we can't keep alignment uppper limit to
16M. That time I had kept 4M as upper limit as that seemed to be only
practical usage.

Rencetly I have restored back CONFIG_PHYSICAL_START option. That patch
is still in -mm. IMHO, your case will fit more if we set
CONFIG_PHYSICAL_START to 16M rather than increasing alignment upper limit
for CONFIG_PHYSICAL_ALIGN. 

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/broken-out/i386-restore-config_physical_start-option.patch

Andrew, Can you please push this patch to 2.6.20-rc3?

Thanks
Vivek
