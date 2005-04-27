Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVD0DV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVD0DV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 23:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVD0DV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 23:21:27 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:25790 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261897AbVD0DVX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 23:21:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zs6yXBQgCUQAtkFiF5GDaLuFT3jXDvM1bUXEY7MAEl8ix/PaDdQcs8PKpUoaN0EjhHEdLkGVa/tCEIgeakKMGu/Yq/VXAX6KCbX68LZXSZk3LSbfrDgTxIBHEsNfqqFZnR0EFxiigFJFilxliLusXrHqzO1OjUXF5MzVhIarx4c=
Message-ID: <469958e0050426202144a1fdf4@mail.gmail.com>
Date: Tue, 26 Apr 2005 20:21:23 -0700
From: Caitlin Bestler <caitlin.bestler@gmail.com>
Reply-To: Caitlin Bestler <caitlin.bestler@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Roland Dreier <roland@topspin.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       timur.tabi@ammasso.com
In-Reply-To: <20050426170513.33b81f76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425135401.65376ce0.akpm@osdl.org>
	 <20050425173757.1dbab90b.akpm@osdl.org> <52wtqpsgff.fsf@topspin.com>
	 <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>
	 <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>
	 <20050426133229.416a5e66.akpm@osdl.org> <521x8xs04v.fsf@topspin.com>
	 <20050426170513.33b81f76.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Andrew Morton <akpm@osdl.org> wrote:

> >
> > However I don't see how to make it work if I put the reference
> > counting for overlapping regions in userspace but when I want mlock()
> > accounting in the kernel.  If a buggy/malicious app does:
> >
> >     a) register from 0x0000 to 0x2fff
> >     b) register from 0x1000 to 0x1fff
> >     c) unregister from 0x0000 to 0x2fff
> 
> As far as the kernel is concerned, step b) should be a no-op.  (The kernel
> might choose to split the vma, but that's not significant).
> 

If "register" and "unregister" is meant in the RDMA sense then the above
sequence is totally reasonable. The b) registration could be for a different
protection domain that did not require access to all of the larger region.

Unless a full counting lock is available from the kernel, the responsibility
of the collective RDMA components would be to a) pin 0x0000 to 0x2fff,
b) nothing c) unpin 0x000 to 0x0fff and 0x2000 to 0x2fff
