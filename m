Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWBMTFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWBMTFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWBMTFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:05:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964806AbWBMTFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:05:53 -0500
Date: Mon, 13 Feb 2006 11:05:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <20060213154114.GO32041@mellanox.co.il>
Message-ID: <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
References: <20060213154114.GO32041@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Michael S. Tsirkin wrote:
> 
> Add madvise options to control whether memory range is inherited across fork.
> Useful e.g. for when hardware is doing DMA from/into these pages.
> 
> Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
>
> -		if (mpnt->vm_flags & VM_DONTCOPY) {
> +		if (mpnt->vm_flags & (VM_DONTCOPY | VM_DONTFORK)) {

Why?

That VM_DONTCOPY _is_ DONTFORK. 

Don't add a new useless DONTFORK that doesn't have any value.

		Linus
