Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWFURPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWFURPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWFURPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:15:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:55005 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932282AbWFURPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:15:19 -0400
Date: Wed, 21 Jun 2006 10:15:18 -0700
From: Mike Grundy <grundym@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060621171517.GA7421@localhost.localdomain>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org,
	systemtap@sources.redhat.com
References: <20060612131552.GA6647@localhost.localdomain> <1150141217.5495.72.camel@localhost> <20060621042804.GA20300@localhost.localdomain> <1150907920.8295.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150907920.8295.10.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 06:38:40PM +0200, Martin Schwidefsky wrote:
> On Tue, 2006-06-20 at 21:28 -0700, Mike Grundy wrote:
> > Hi Martin - This patch implements the suggestions from your review. There were
> > a couple points I wanted to go over:
> > > There are some more instructions missing that need fixup:
> > > "brxh" 0x84??????, "brxle" 0x85??????, "brc" 0xa7?4????,
> > > "brct" 0xa7?6????, "brctg" 0xa7?7????, "bctgr" 0xb946????,
> > > "brxhg" 0xec????????44 and "brxlg" 0xec??????45.
> > Since all of these are relative branches, and they don't save the psw, the
> > standard clean up of adjusting the original psw by the offset from the out of
> > line address after single step. Unless I'm just being dense :-) 
> 
> All of these are conditional branches, if the branch is not taken you
> have to do a cleanup.
The reason I have a special cleanup for the other branches is the easy way to 
tell if the branch wasn't taken is the pswa = orig pswa + instruction length.
The relative branches get cleaned up the same way if the branch was taken or
not, pswa = probe_addr + (out of line end psw - out of line start psw). These
are all relative branches and while they need cleanup, they don't get treated
differently based on the branch status.

> You misunderstood me here. I'm not talking about storing the same piece
> of data to memory on each processor. I'm talking about isolating all
> other cpus so that the initiating cpu can store the breakpoint to memory
Yep, I misunderstood that. The serialization is the point, not the replacement
of a word in memory.

-- 
Thanks
Mike
