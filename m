Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268204AbUIPUHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268204AbUIPUHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUIPUHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:07:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30100 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268213AbUIPUGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:06:51 -0400
Date: Thu, 16 Sep 2004 13:05:15 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Robert Picco <Robert.Picco@hp.com>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@engr.sgi.com>, venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
In-Reply-To: <4149D655.5070904@hp.com>
Message-ID: <Pine.LNX.4.58.0409161259030.7834@schroedinger.engr.sgi.com>
References: <200409161003.39258.bjorn.helgaas@hp.com>
 <Pine.LNX.4.58.0409160930300.6765@schroedinger.engr.sgi.com>
 <200409161054.51467.bjorn.helgaas@hp.com> <4149D655.5070904@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Robert Picco wrote:

> >Is there something specific that drivers/char/hpet.c expects that
> >your hardware doesn't implement?
> Look at HPET revision history.  Specifically 0.98 01/20/2002
>     * Product name changed: from Multimedia Timer to HPET (High
> Precision Event Timer)

The HPET timer has a specific memory layout of registers that is mappable
to user space. The mmtimer driver only allows the mapping of a single 64
bit counter to use space. We have lots of applications at SGI
that rely on mmtimer since mmtimer provides a locally accessible
clock in an NUMA environment with hundreds of CPU. A hpet device would
have to show up in the global address space and require cross node
accesses in our NUMA environment that would make access to the timer
slow. All CPU would content for access to a certain global memory address.

The HPET hardware and the sgi mmtimer are totally different architectures
that are not easily reconcilable.

The software API to handle both is similar and we would like it to be as
compatible as possible.

