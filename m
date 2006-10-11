Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWJKJZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWJKJZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWJKJZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:25:32 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:54776 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750785AbWJKJZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:25:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
Date: Wed, 11 Oct 2006 11:25:09 +0200
User-Agent: KMail/1.9.4
Cc: jschopp <jschopp@austin.ibm.com>, Linas Vepstas <linas@austin.ibm.com>,
       akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
References: <20061010204946.GW4381@austin.ibm.com> <452C2AAA.5070001@austin.ibm.com> <452C4CE0.5010607@am.sony.com>
In-Reply-To: <452C4CE0.5010607@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610111125.10902.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 03:46, Geoff Levand wrote:
> > 
> > The others look good, but this one complicates the code and doesn't have any benefit.  20 
> > for 21 isn't bad.
> 
> Is the motivation for this change to improve performance by reducing the overhead
> of the mapping calls?  If so, there may be some benefit for some systems.  Could
> you please elaborate?
> 

>From what I understand, this patch drastically reduces the number of
I/O PTEs that are needed in the iommu. With the current static IOMMU
mapping, it should only make a difference during initialization, but
any platform that uses a dynamic mapping of iommu entries will benefit
a lot from it, because:

- the card can do better prefetching of consecutive memory
- there are more I/O ptes available for other drivers.

	Arnd <><
