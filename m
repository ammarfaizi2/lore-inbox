Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUCQRxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUCQRxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:53:32 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:1450 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261724AbUCQRx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:53:29 -0500
Date: Wed, 17 Mar 2004 09:51:35 -0800
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Robert Picco <Robert.Picco@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: boot time node and memory limit options
Message-ID: <20040317175134.GA23153@sgi.com>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Robert Picco <Robert.Picco@hp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Dobson <colpatch@us.ibm.com>
References: <4057392A.8000602@hp.com> <20040316174329.GA29992@sgi.com> <34060000.1079465992@flay> <405879BC.7060904@hp.com> <1745150000.1079541412@[10.10.2.4]> <1079543385.5789.152.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079543385.5789.152.camel@nighthawk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 09:09:45AM -0800, Dave Hansen wrote:
> Every arch has its own way of describing its layout.  Some use "chunks"
> and others like ppc64 use LMB (logical memory blocks).  If each arch was
> willing to store their memory layout information in a generic way, then
> we might have a shot at doing a generic mem= or a NUMA version.  

> 
> I coded this up a few days ago to see if I could replace the x440 SRAT
> chunks with it.  I never got around to actually doing that part, but
> something like this is what we need to do *layout* manipulation in an
> architecture-agnostic way.
> 
> I started coding this before I thought *too* much about it.  What I want
> is a way to get rid of all of the crap that each architecture (and
> subarch) have to store their physical memory layout.  On normal x86 we
> have the e820 and the EFI tables and on Summit/x440, we have yet another
> way to do it.  

In some cases (ia64 for example) there are additional restrictions on
each memory chunk.  For example, the EFI memory map may describe a
contiguous chunk of memory 28MB in size, but if your kernel page size
was set to 64MB, you'd have to throw it away as unusable.  Should that
be dealt with in the arch independent code (i.e. is similar stuff done
on other platforms?) or is it best to only add sections that are usable?

> What I'd like to do is present a standard way for all of these
> architectures to store the information that they need to record at boot
> time, plus make something flexible enough that we can use it for stuff
> at runtime when hotplug memory is involved.

That would be great, what you have below seems sensible.

> The code I'd like to see go away from boot-time is anything that deals
> with arch-specific structures like the e820, functions like
> lmb_end_of_DRAM(), or any code that deals with zholes.  I'd like to get
> it to a point where we can do a mostly arch-independent mem=.  

So what you have here would be only for boot time setup, while
CONFIG_NONLINEAR would be used in lieu of multiple pgdats per node or a
virtual memmap in the case of intranode discontiguous memory?

Thanks,
Jesse
