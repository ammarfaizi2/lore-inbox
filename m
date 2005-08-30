Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVH3Epv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVH3Epv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVH3Epv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:45:51 -0400
Received: from ozlabs.org ([203.10.76.45]:44505 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932126AbVH3Epu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:45:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17171.58403.920889.62559@cargo.ozlabs.ibm.com>
Date: Tue, 30 Aug 2005 14:44:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
In-Reply-To: <20050829160915.GD12618@austin.ibm.com>
References: <20050823231817.829359000@bilge>
	<20050823232143.003048000@bilge>
	<20050823234747.GI18113@austin.ibm.com>
	<1124898331.24668.33.camel@sinatra.austin.ibm.com>
	<20050824162959.GC25174@austin.ibm.com>
	<17165.3205.505386.187453@cargo.ozlabs.ibm.com>
	<20050825161325.GG25174@austin.ibm.com>
	<17170.44500.848623.139474@cargo.ozlabs.ibm.com>
	<20050829160915.GD12618@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> > One way to clean this up would be to make rpaphp the driver for the
> > EADS bridges (from the pci code's point of view).  
> 
> I guess I don't understand what that means. Are you suggesting moving 
> pSeries_pci.c into the rpaphp code directory?

No, not at all. :)

I'm suggesting that the rpaphp code has a struct pci_driver whose
id_table and probe function are such that it will claim the EADS
bridges.  (It would probably be best to match on vendor=IBM and
class=PCI-PCI bridge and let the probe function figure out which of
the bridges it gets asked about are actually EADS bridges.)

> I would prefer to deprecate the hot-plug based recovery scheme.  This
> is for many reasons, including the fact that some devices that can get
> pci errors are soldered onto the planar, and are not hot-pluggable.

Those devices can still be isolated and reset, can they not?  And they
still have an EADS bridge above them, don't they?  Are there any that
can't be dynamically reassigned from one partition to another?  I.e.,
they may not be physically hotpluggable but they are still virtually
hotpluggable as far as the partition is concerned, IIUC.

Paul.
