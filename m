Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVH2QOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVH2QOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVH2QO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:14:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:2482 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751285AbVH2QLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:11:16 -0400
Date: Mon, 29 Aug 2005 11:09:15 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20050829160915.GD12618@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com> <1124898331.24668.33.camel@sinatra.austin.ibm.com> <20050824162959.GC25174@austin.ibm.com> <17165.3205.505386.187453@cargo.ozlabs.ibm.com> <20050825161325.GG25174@austin.ibm.com> <17170.44500.848623.139474@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17170.44500.848623.139474@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 04:40:20PM +1000, Paul Mackerras was heard to remark:
> Linas Vepstas writes:
> 
> > Actually, no.  There are three issues:
> > 1) hotplug routines are called from within kernel. GregKH has stated on
> >    multiple occasions that doing this is wrong/bad/evil. This includes
> >    calling hot-unplug.
> > 
> > 2) As a result, the code to call hot-unplug is a bit messy. In
> >    particular, there's a bit of hoop-jumping when hotplug is built as
> >    as a module (and said hoops were wrecked recently when I moved the
> >    code around, out of the rpaphp directory).
> 
> One way to clean this up would be to make rpaphp the driver for the
> EADS bridges (from the pci code's point of view).  

I guess I don't understand what that means. Are you suggesting moving 
pSeries_pci.c into the rpaphp code directory?

> Then it would
> automatically get included in the error recovery process and could do
> whatever it should.

John Rose, the current maintainer of the rpaphp code, is pretty militant 
about removing things from, not adding things to, the rpaphp code.
Which is a good idea, as chunks of that code are spaghetti, and do need
simplification and cleanup.

> > 3) Hot-unplug causes scripts to run in user-space. There is no way to 
> >    know when these scripts are done, so its not clear if we've waited
> >    long enough before calling hot-add (or if waiting is even necessary).
> 
> OK, so let's just add a new hotplug event called KOBJ_ERROR or
> something, which tells userspace that an error has occurred which has
> made the device inaccessible.  Greg, would that be OK?

Why do we need such an event?

I would prefer to deprecate the hot-plug based recovery scheme.  This
is for many reasons, including the fact that some devices that can get
pci errors are soldered onto the planar, and are not hot-pluggable.

--linas
