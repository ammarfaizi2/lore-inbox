Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWBMTTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWBMTTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWBMTTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:19:24 -0500
Received: from [194.90.237.34] ([194.90.237.34]:9134 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964811AbWBMTTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:19:22 -0500
Date: Mon, 13 Feb 2006 21:20:46 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: madvise MADV_DONTFORK/MADV_DOFORK
Message-ID: <20060213192046.GD12458@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 13 Feb 2006 19:21:14.0531 (UTC) FILETIME=[A7EE3730:01C630D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds <torvalds@osdl.org>:
> > 
> > Add madvise options to control whether memory range is inherited across fork.
> > Useful e.g. for when hardware is doing DMA from/into these pages.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> >
> > -		if (mpnt->vm_flags & VM_DONTCOPY) {
> > +		if (mpnt->vm_flags & (VM_DONTCOPY | VM_DONTFORK)) {
> 
> Why?
> 
> That VM_DONTCOPY _is_ DONTFORK. 
> 
> Don't add a new useless DONTFORK that doesn't have any value.

When this was last discussed, Hugh Dickins said:
> If a driver sets VM_DONTCOPY, it's likely to be because the driver knows it'll
> cause some nastiness (memory corruption, memory leak, lockup...) if it were
> copied. The memory belongs to the driver, it's letting the process have a
> window on it. I don't think we should now let the process overrule it.

Here's a pointer to the relevant discussion:
http://lkml.org/lkml/2005/11/3/112

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
