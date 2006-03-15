Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751980AbWCOWSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbWCOWSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbWCOWSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:18:39 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3292
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751980AbWCOWSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:18:39 -0500
Date: Wed, 15 Mar 2006 14:18:20 -0800 (PST)
Message-Id: <20060315.141820.124063256.davem@davemloft.net>
To: akpm@osdl.org
Cc: ebiederm@xmission.com, bcrl@kvack.org, galak@kernel.crashing.org,
       vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060315141305.13864705.akpm@osdl.org>
References: <20060315212841.GE25361@kvack.org>
	<m1fylje5sv.fsf@ebiederm.dsl.xmission.com>
	<20060315141305.13864705.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 15 Mar 2006 14:13:05 -0800

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> > Benjamin LaHaise <bcrl@kvack.org> writes:
> > 
> > > On Wed, Mar 15, 2006 at 02:29:32PM -0700, Eric W. Biederman wrote:
> > >> If the impact is very slight or unmeasurable this means the option
> > >> needs to fall under CONFIG_EMBEDDED, where you can change if
> > >> every last bit of RAM counts but otherwise you won't care.
> > >
> > > But we have a data type that is correct for this usage: dma_addr_t.
> > 
> > Well the name is wrong.  Because these are in general not DMA addresses,
> > but it may have the other desired properties.  So it may be
> > useable.
> 
> Yes, dma_addr_t does the right thing but has the wrong name.

No it doesn't.

It's 32-bit on Sparc64 because all DMA mappings go through
the IOMMU into a 32-bit window on PCI space.

But we do most certainly want to support full 64-bit BARs
in PCI devices on sparc64.
