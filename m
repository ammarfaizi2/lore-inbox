Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTIZWDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTIZWDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:03:45 -0400
Received: from ns.suse.de ([195.135.220.2]:23776 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261659AbTIZWDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:03:44 -0400
To: Jim Deas <jdeas@jadsystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
References: <1064609623.16160.11.camel@ArchiveLinux.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Sep 2003 00:03:42 +0200
In-Reply-To: <1064609623.16160.11.camel@ArchiveLinux.suse.lists.linux.kernel>
Message-ID: <p73ad8r5hs1.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Deas <jdeas@jadsystems.com> writes:

> I am looking for the most current (blessed) structure
> for mapping PCI memory to a user process. One that allows
> both PIO and busmastering to work on a common block of
> PCI RAM. I am not concerned with backporting to older
> kernels but it would be nice if the solution wasn't ibm specific.

mmap on /dev/mem

PIO cannot be done on memory, for that you have to use iopl() 
or ioperm() to get access to the port and then issue the PIO 
instructions yourself

The only trap with the mapping is getting uncached mappings
(most PCI hardware prefers uncached accesses). When the mapping
is beyond the end of memory the kernel will automatically 
map it uncached. PCI mappings are normally in the PCI hole
at the end of the 4GB area. When you machine has more than
4GB of ram this heuristic does not work and you have 
set MTRRs by hand using /proc/mtrr or use O_SYNC. The later is 
cleanest, but only works in newer kernels.

[BTW I consider this a kernel bug - it should always map mappings
to non memory uncached] 


-Andi
