Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWF0L4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWF0L4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWF0L4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:56:19 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:48205 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932512AbWF0L4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:56:18 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Mike Grundy <grundym@us.ibm.com>
Cc: jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
In-Reply-To: <20060621171517.GA7421@localhost.localdomain>
References: <20060612131552.GA6647@localhost.localdomain>
	 <1150141217.5495.72.camel@localhost>
	 <20060621042804.GA20300@localhost.localdomain>
	 <1150907920.8295.10.camel@localhost>
	 <20060621171517.GA7421@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 27 Jun 2006 13:56:11 +0200
Message-Id: <1151409371.5390.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 10:15 -0700, Mike Grundy wrote:
> On Wed, Jun 21, 2006 at 06:38:40PM +0200, Martin Schwidefsky wrote:
> > On Tue, 2006-06-20 at 21:28 -0700, Mike Grundy wrote:
> > > Hi Martin - This patch implements the suggestions from your review. There were
> > > a couple points I wanted to go over:
> > > > There are some more instructions missing that need fixup:
> > > > "brxh" 0x84??????, "brxle" 0x85??????, "brc" 0xa7?4????,
> > > > "brct" 0xa7?6????, "brctg" 0xa7?7????, "bctgr" 0xb946????,
> > > > "brxhg" 0xec????????44 and "brxlg" 0xec??????45.
> > > Since all of these are relative branches, and they don't save the psw, the
> > > standard clean up of adjusting the original psw by the offset from the out of
> > > line address after single step. Unless I'm just being dense :-) 
> > 
> > All of these are conditional branches, if the branch is not taken you
> > have to do a cleanup.
> The reason I have a special cleanup for the other branches is the easy way to 
> tell if the branch wasn't taken is the pswa = orig pswa + instruction length.
> The relative branches get cleaned up the same way if the branch was taken or
> not, pswa = probe_addr + (out of line end psw - out of line start psw). These
> are all relative branches and while they need cleanup, they don't get treated
> differently based on the branch status.

So you are always doing a sort of branch cleanup, even for non-branch
instructions. Seems reasonable, since non-branch instructions don't
branch and the standard cleanup logic can deal with. 

> > You misunderstood me here. I'm not talking about storing the same piece
> > of data to memory on each processor. I'm talking about isolating all
> > other cpus so that the initiating cpu can store the breakpoint to memory
> Yep, I misunderstood that. The serialization is the point, not the replacement
> of a word in memory.

Exactly.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


