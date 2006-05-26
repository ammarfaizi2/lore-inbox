Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWEZEq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWEZEq5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWEZEq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:46:57 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:50842 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030434AbWEZEq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:46:56 -0400
Date: Thu, 25 May 2006 23:46:36 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] x86-64: Calgary IOMMU - introduce iommu_detected
Message-ID: <20060526044636.GA31695@us.ibm.com>
References: <20060525033408.GC7720@us.ibm.com> <200605250554.23534.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605250554.23534.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 05:54:23AM +0200, Andi Kleen wrote:
> On Thursday 25 May 2006 05:34, Jon Mason wrote:
> > swiotlb relies on the gart specific iommu_aperture variable to know if
> > we discovered a hardware IOMMU before swiotlb initialization.  Introduce
> > iommu_detected to do the same thing, but in a HW IOMMU neutral manner,
> > in preparation for adding the Calgary HW IOMMU.
> 
> I applied them all.
> 
> But I think you broke the aperture setup. iommu_setup really
> needs to be called early, otherwise aperture.c doesn't get
> the right parameters.  I undid that change.

Actually, I didn't break aperture.c by moving iommu_setup because I
moved iommu_hole_init after __setup.  This change also enabled me to
move back the calgary specific bootarg parsing (like you asked for in
the original version of the path).  

Also, in the reworked version of iommu-abstraction on
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches has a bug.  When
iommu_setup was kept in it's original form, the "+__setup("iommu=",
iommu_setup);" wasn't removed, which gives 2 calls to the same function.
I'll send updated versions of the patches here shortly which will apply
cleanly inplace to that tree.

> 
> And please next time send against the latest tree. It required
> quite some tweaking to apply.

Sorry, I'll be happy to do it next time :)

Thanks,
Jon
