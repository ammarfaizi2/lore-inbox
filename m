Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVKJNQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVKJNQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVKJNQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:16:46 -0500
Received: from gold.veritas.com ([143.127.12.110]:36769 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750839AbVKJNQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:16:45 -0500
Date: Thu, 10 Nov 2005 13:15:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051110124853.GD16589@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0511101311460.7348@goblin.wat.veritas.com>
References: <20051110123538.GL8942@minantech.com> <20051110124853.GD16589@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 13:16:44.0533 (UTC) FILETIME=[FF271A50:01C5E5F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Michael S. Tsirkin wrote:
> Quoting Gleb Natapov <gleb@minantech.com>:
> > I think you are removing VM_RAND_READ/VM_SEQ_READ here.

Good catch from Gleb, I certainly didn't notice that.
> 
> True, we need something like
> 
>         switch (behavior) {
>         case MADV_SEQUENTIAL:
>                 new_flags = (vma->vm_flags & ~VM_READHINTMASK) | VM_SEQ_READ;
>                 break;
>         case MADV_RANDOM:
>                 new_flags = (vma->vm_flags & ~VM_READHINTMASK) | VM_RAND_READ;
>                 break;

Yes, that helps avoid such errors in future.  Though, no strong feelings,
but I'd find it clearer to avoid the obscure VM_READHINTMASK completely,
and just say (vma->vm_flags & ~VM_RAND_READ) | VM_SEQ_READ etc.

Hugh
