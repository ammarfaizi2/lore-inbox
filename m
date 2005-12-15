Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVLOQTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVLOQTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVLOQTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:19:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46788 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750774AbVLOQTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:19:32 -0500
Date: Thu, 15 Dec 2005 16:19:31 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 3/3] m68k: compile fix - updated vmlinux.lds to include LOCK_TEXT
Message-ID: <20051215161931.GW27946@ftp.linux.org.uk>
References: <20051215090037.GV27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151408560.1605@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512151408560.1605@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 02:12:34PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Dec 2005, Al Viro wrote:
> 
> > [rz: BTW, proposed variant of thread_info patchset is available for review,
> > see ftp.linux.org.uk/pub/people/viro/task_thread_info-mbox...
> 
> BTW please fix the comment in the last patch, {get,put}_thread_info() 
> didn't come from the m68k tree, so don't blame it for this stuff.
> The thread_info stuff went through a number changes during 2.5.xx and it's 
> a leftover from this.

<goes to check history>

My apologies - that junk predates the events I'd been thinking about.
The rest of comments still stands - it was never used since the moment
of introduction...

Speaking of hardirq.h - come on; even argument about check being not
in the same place where the value is defined...

* we compare NR_IRQS and HARDIRQ_BITS
* one of them is defined in irq.h, another - in hardirq.h
* due to current header ordering, comparison works in irq.h and not in
hardirq.h
* if you change that ordering (which is a *big* patchset, even if you
manage to keep it with zero impact on other architectures) so that check
can go in either place, you can always put it into the place where it
would make more sense in new header ordering; it's not going to be make
patch heavier.

IMO for now it's a no-brainer - compile fix that moves comparison to the
place where another side of comparison is defined  vs.  header ordering
rework...  Sorry.
