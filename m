Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVCBWyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVCBWyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCBWvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:51:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:53711 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262518AbVCBWqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:46:32 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Linas Vepstas <linas@austin.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200503021041.07090.jbarnes@engr.sgi.com>
References: <422428EC.3090905@jp.fujitsu.com>
	 <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
	 <20050302182205.GI1220@austin.ibm.com>
	 <200503021041.07090.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 09:43:48 +1100
Message-Id: <1109803429.5611.111.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One issue with that is how to notify drivers that they need to make this call.  
> In may cases, DMA completion will be signalled by an interrupt, but if the 
> DMA failed, that interrupt may never happen, which means the call to 
> pci_unmap or the above function from the interrupt handler may never occur.
> 
> Some I/O errors are by nature asynchronous and unpredictable, so I think we 
> need a separate thread and callback interface to deal with errors where the 
> beginning of the transaction and the end of the transaction occur in 
> different contexts, in addition to the PIO transaction interface already 
> proposed.

Yup. As I wrote already. We need a new callback in pci_driver, that's
the cleanest way. It would take an "event" argument plus some still to
be defined flags to inform the driver about platform capabilities.

The driver based on the result code can then request a slot reset  if
the platform supports it, or just try to recover, or just giveup.

Another callback would come once the slot has been reset & reconfigure,
etc...

I'm going to write something down real soon now (after I had breakfast
hopefully :)

Ben.


