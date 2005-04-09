Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVDIJYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVDIJYP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 05:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVDIJYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 05:24:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:53888 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261250AbVDIJYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 05:24:10 -0400
Subject: Re: [patch] sched: unlocked context-switches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <20050409043848.GA2677@elte.hu>
References: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com>
	 <20050409043848.GA2677@elte.hu>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 19:22:23 +1000
Message-Id: <1113038543.9568.430.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-09 at 06:38 +0200, Ingo Molnar wrote:
> * Luck, Tony <tony.luck@intel.com> wrote:
> 
> > >tested on x86, and all other arches should work as well, but if an 
> > >architecture has irqs-off assumptions in its switch_to() logic 
> > >it might break. (I havent found any but there may such assumptions.)
> > 
> > The ia64_switch_to() code includes a section that can change a pinned
> > MMU mapping (when the stack for the new process is in a different
> > granule from the stack for the old process).  [...]
> 
> thanks - updated patch below. Any other architectures that switch the 
> kernel stack in a nonatomic way? x86/x64 switches it atomically.

ppc64 already has a local_irq_save/restore in switch_to, around the low
level asm bits, so it should be fine.

Ben.


