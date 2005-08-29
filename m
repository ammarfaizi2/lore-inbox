Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVH2UbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVH2UbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVH2UbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:31:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51158 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751080AbVH2UbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:31:12 -0400
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
From: John Rose <johnrose@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       lkml <linux-kernel@vger.kernel.org>,
       External List <linuxppc64-dev@ozlabs.org>
In-Reply-To: <17170.44500.848623.139474@cargo.ozlabs.ibm.com>
References: <20050823231817.829359000@bilge>
	 <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com>
	 <1124898331.24668.33.camel@sinatra.austin.ibm.com>
	 <20050824162959.GC25174@austin.ibm.com>
	 <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
	 <20050825161325.GG25174@austin.ibm.com>
	 <17170.44500.848623.139474@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1125347185.19449.54.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Aug 2005 15:26:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul-

> > 2) As a result, the code to call hot-unplug is a bit messy. In
> >    particular, there's a bit of hoop-jumping when hotplug is built as
> >    as a module (and said hoops were wrecked recently when I moved the
> >    code around, out of the rpaphp directory).
> 
> One way to clean this up would be to make rpaphp the driver for the
> EADS bridges (from the pci code's point of view).  Then it would
> automatically get included in the error recovery process and could do
> whatever it should.

Not sure that I agree with this.  Not all PCI hotplug slots have EADS
devices as parents.  This sort of topography dependency is something
we're trying to break in rpaphp.  Rpaphp could set this up for devices
that do have EADS parents, but then we've only covered a subset of
EEH-capable devices.  

Anyway, isn't the OS forbidden from performing most of the expected
function of such a driver for EADS devices:
	Enable the device
	Access device configuration space
	Discover resources (addresses and IRQ numbers) provided by the device
	Allocate these resources
	Communicate with the device
	Disable the device

Thanks-
John

