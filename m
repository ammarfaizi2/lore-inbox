Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWJPMVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWJPMVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbWJPMVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:21:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:57064 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422716AbWJPMVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:21:38 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Mon, 16 Oct 2006 14:21:25 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, discuss@x86-64.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <200610052344.18598.ak@suse.de> <1160133260.1607.60.camel@localhost.localdomain>
In-Reply-To: <1160133260.1607.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161421.25530.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 13:14, Alan Cox wrote:
> Ar Iau, 2006-10-05 am 23:44 +0200, ysgrifennodd Andi Kleen:
> > I think we had that argument before. IMHO such messages are completely
> > useless. Hangs are not acceptable no matter what messages are printed
> > before.
> 
> Oh so you plan to fix the iommu/aacraid problem you always said you
> wouldn't fix ?

They don't cause hangs, just IO errors (or panics if you configure
iommu debugging)

Actually I plan to fix this one, but it will require more work.
Basically the plan is to make the current dma zone variable sized
and get rid of all GFP_DMA allocations.  Merge the current soft iommu
with that new dma allocator. Then make sure all allocations
that need such low dma use a mask argument to some allocator.

Then we can have a option to configure the size of the dma low zone.
Users of broken hardware just configure a larger size.

-Andi
