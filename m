Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSFFRnM>; Thu, 6 Jun 2002 13:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSFFRnL>; Thu, 6 Jun 2002 13:43:11 -0400
Received: from earth.ayrnetworks.com ([64.166.72.139]:34493 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S317025AbSFFRnK>;
	Thu, 6 Jun 2002 13:43:10 -0400
Date: Thu, 6 Jun 2002 10:40:37 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: "linux-kernel@vger.kernel.org"@ayrnetworks.com,
        "linux-mips@oss.sgi.com"@ayrnetworks.com
Subject: Re: Deprecate pci_dma_sync_{single,sg}()?
Message-ID: <20020606104036.A11943@ayrnetworks.com>
In-Reply-To: <20020605131231.B10773@ayrnetworks.com> <20020605.154747.58455261.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 03:47:47PM -0700, David S. Miller wrote:
>    From: William Jhun <wjhun@ayrnetworks.com>
>    Date: Wed, 5 Jun 2002 13:12:31 -0700
>    
>    In the current linux-mips implementation, this has some subtle problems:
>    pci_unmap_{single,sg}() is essentially a no-op.
> 
> Right, I see the problem.  I'll think about this some more.
> 
> As it stands now, I think the correct solution is to require
> pci_dma_prep_single() before giving the buffer back to the
> device after the read.

Right, that's what I was thinking. Is it asking a lot to demand that all
existing drivers that use this interface add pci_dma_prep_single()? How
will backward compatiblility with older drivers work? That's why I
suggested leaving pci_dma_sync_single() and adding
pci_dma_release_single() which can leave the cache flush to
pci_dma_prep_single(). It seems like elsewhere, like the D-cache
flushing interface (for virtual aliasing), both old and new interfaces
co-exist. Does this seem to work out O.K. in your experience?

Will
