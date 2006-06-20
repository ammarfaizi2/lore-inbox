Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWFTIhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWFTIhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWFTIhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:37:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:48515 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965043AbWFTIhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:37:14 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-git build breakage
Date: Tue, 20 Jun 2006 10:37:05 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org
References: <4497A871.8000303@garzik.org> <20060620011738.d72147a8.akpm@osdl.org>
In-Reply-To: <20060620011738.d72147a8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201037.05610.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 10:17, Andrew Morton wrote:
> On Tue, 20 Jun 2006 03:49:05 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > On the latest 'git pull', on x86-64 SMP 'make allmodconfig', I get the 
> > following build breakage:
> > 
> > 1) myri10ge: needs iowrite64_copy from -mm
> 
> Patch has been sent.
> 
> > 2) forcedeth: git tree conflict, Herbert sent a patch
> > 
> > 3) pci-gart (ouch!) link: no fix seen yet
> > 
> > [...]
> >    LD      init/built-in.o
> >    LD      .tmp_vmlinux1
> > arch/x86_64/kernel/built-in.o: In function `pci_iommu_init':
> > arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_amd64_init'
> > arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_bridge'
> > arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_copy_info'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> hm.  I could swear we fixed that multiple times, but I don't seem to be
> able to locate the patch.
> 
> This one, perhaps?

Is it new anyways? I don't think either me nor Dave changed anything 
in this area yet post .17

Anyways looks good although the old code worked at some point ...

-Andi

> 
> use select for GART_IOMMU to enable AGP
> 
> From: Roman Zippel <zippel@linux-m68k.org>
> 
> The AGP default doesn't work well with other selects, so use a select for
> GART_IOMMU as well.  Remove a redundant default for SWIOTLB as well.
>
