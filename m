Return-Path: <linux-kernel-owner+w=401wt.eu-S932131AbXAFWmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbXAFWmd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 17:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbXAFWmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 17:42:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55334 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbXAFWmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 17:42:32 -0500
Subject: Re: revert PIE randomization?
From: David Woodhouse <dwmw2@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Marcus Meissner <meissner@suse.de>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@codemonkey.org.uk>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0701062005001.22171@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0701062005001.22171@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 06:42:12 +0800
Message-Id: <1168123332.24110.41.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 20:11 +0000, Hugh Dickins wrote:
> And I notice that Andi added a personality & ADDR_NO_RANDOMIZE check
> into randomize_stack_top: I cannot see why that's necessary there,
> but if it is, then should the ET_DYN case add it too?)

While I think of it... it seems that ADDR_NO_RANDOMIZE isn't "inherited"
across exec of 32-bit binaries on x86_64 or ppc64. The personality flags
get wiped out when we detect a 32-bit ELF executable and set the
personality to PER_LINUX32.

This causes suboptimal behaviour from userspace code which checks
whether it can set ADDR_NO_RANDOMIZE with a sys_personality() call, and
if so re-execs itself. Run on x86_64 or ppc64, these go into an endless
loop because it always gets cleared in the exec.

I've seen such code in two places recently (Macaulay2 and sbcl, iirc).

-- 
dwmw2

