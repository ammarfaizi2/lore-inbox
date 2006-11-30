Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759067AbWK3IXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759067AbWK3IXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759070AbWK3IXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:23:11 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:53487 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1759067AbWK3IXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:23:09 -0500
Date: Thu, 30 Nov 2006 00:16:37 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 add idle notifier
Message-ID: <20061130081637.GB30095@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061129162540.GL28007@frankl.hpl.hp.com> <20061129221853.GD29670@frankl.hpl.hp.com> <20061129150544.ebd952f3.akpm@osdl.org> <200611300021.41497.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611300021.41497.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 30, 2006 at 12:21:41AM +0100, Andi Kleen wrote:
> 
> > An alternative approach might be to change perfmon so that it works out
> > whether it is being called by an idle thread
> > 
> > 	if ((current->flags & PF_IDLE) && (other stuff to do with irqs?))
> > 		return;
> 
> The problem is that the performance counters just keep running in the CPU.
> Perfmon needs to do something actively to disable them.
> 
Exactly.

> Actually on x86 they usually stop in true idle state in hardware, but 
> they don't do in polling mode and it sometimes seems to depend on
> the firmware.  So it mostly would be for idle=poll
> 
Most likely. But we also have the deal with other architectures such
as MIPS,IA64, and PPC.

> But if you do walk clock time profiling exactly because they stop 
> a profiler should account for this somehow. Otherwise the profiling time
> doesn't add up to 100%
> 
Yes. Note that perfmon does maintain the duration when monitornig was active.
So it is possible to determine active time and use it to scale counts.

-- 
-Stephane
