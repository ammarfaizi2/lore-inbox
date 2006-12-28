Return-Path: <linux-kernel-owner+w=401wt.eu-S1755002AbWL1Vgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbWL1Vgo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755003AbWL1Vgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:36:44 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2415 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbWL1Vgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:36:43 -0500
Date: Thu, 28 Dec 2006 21:36:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marc Haber <mh+linux-kernel@zugschlus.de>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061228213625.GE20596@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Marc Haber <mh+linux-kernel@zugschlus.de>,
	Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, andrei.popa@i-neo.ro,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
	Martin Michlmayr <tbm@cyrius.com>
References: <20061217154026.219b294f.akpm@osdl.org> <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org> <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org> <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de> <20061228180536.GB7385@torres.zugschlus.de> <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org> <Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 01:24:30PM -0800, Linus Torvalds wrote:
> On Thu, 28 Dec 2006, Linus Torvalds wrote:
> > 
> > What we need now is actually looking at the source code, and people who 
> > understand the VM, I'm afraid. I'm gathering traces now that I have a good 
> > test-case. I'll post my trace tools once I've tested that they work, in 
> > case others want to help.
> 
> Ok, I've got the traces, but quite frankly, I doubt anybody is crazy 
> enough to want to trawl through them. It's a bit painful, since we're 
> talking thousands of pages to trigger this problem.
> 
> Also, I've used the PG_arch_1 flag, which is fine on x86[-64] and probably 
> ARM, but is used for other things on ia64, powerpc and sparc64. But here's 
> the patch in case anybody cares.

PG_arch_1 is used on ARM to flag pages that need a dcache flush prior to
hitting userspace, in the same way that sparc64 uses it.  So ARM systems
should not have this patch applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
