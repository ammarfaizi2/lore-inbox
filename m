Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265049AbUF1Pwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbUF1Pwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUF1Pwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:52:37 -0400
Received: from iris-63.mc.com ([63.96.239.5]:4054 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S265049AbUF1Pw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:52:28 -0400
Subject: Re: DRAM and PCI devices at same physical address
From: Matt Sexton <sexton@mc.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040626202648.B29650@home.com>
References: <1088198580.29697.62.camel@dhcp_client-120-140>
	 <20040626202648.B29650@home.com>
Content-Type: text/plain
Message-Id: <1088437874.3292.95.camel@dhcp_client-120-140>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 28 Jun 2004 11:51:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 23:26, Matt Porter wrote:
> On Fri, Jun 25, 2004 at 05:23:00PM -0400, Matt Sexton wrote:
> > I have a dual Xeon system with the Lindenhurst (E7710) chip set and 1 GB
> > of memory.  In order to reserve a very large block of memory for a
> > (user-space) device driver I am writing, I pass "mem=XX" to the kernel
> > at boot time.  Unfortunately, /proc/pci shows two devices now appearing
> > in the reserved upper memory range.  
> 
> <snip>
>  
> > The devices always appear right after the limit I specify on the kernel
> > boot line.  If I specify "mem=512M", then the first device appears at
> > 0x20000000.  If I specify nothing, then it appears at 0x40000000.  All
> > other PCI devices show up at addresses of 0xDD000000 and above.
> > 
> > Is there any way to prevent these devices from showing up in the
> > physical address range of my reserved memory?
> 
> You could try using reserve_bootmem() to reserve your driver memory.
> 

But then I'd have to modify the kernel.  I'd rather just use a loadable
module or user-space driver.

> > Should they be appearing there at all?  Does Linux make any guarantees
> > when there is more physical memory than specified by "mem=" ?
> 

The problem appears to be that the BIOS did not assign PCI addresses to
the two devices.  Linux (2.6.3-4mdkenterprise) then did so, but it
starts assigning at either 256MB, or the first 1MB aligned page after
the end of DRAM, whichever is higher.  On my 1GB system with "mem=768M",
this the region of my "reserved" DRAM.

So, using "mem=" to reserve DRAM and having Linux assign PCI addresses
are not compatible.

Matt

> Depends on the arch, I don't know what ia32 does.
>  
> -Matt

