Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTEUKKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 06:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbTEUKKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 06:10:41 -0400
Received: from ns.suse.de ([213.95.15.193]:51207 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261844AbTEUKKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 06:10:40 -0400
Date: Wed, 21 May 2003 12:23:40 +0200
From: Andi Kleen <ak@suse.de>
To: mikpe@csd.uu.se
Cc: tripperda@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: pat support in the kernel
Message-Id: <20030521122340.74f6502b.ak@suse.de>
In-Reply-To: <16075.20763.659219.636543@gargle.gargle.HOWL>
References: <20030520185409.GB941@hygelac.suse.lists.linux.kernel>
	<16074.33371.411219.528228@gargle.gargle.HOWL.suse.lists.linux.kernel>
	<p73brxwzlfr.fsf@oldwotan.suse.de>
	<16075.20763.659219.636543@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003 12:12:43 +0200
mikpe@csd.uu.se wrote:

> Andi Kleen writes:
>  > mikpe@csd.uu.se writes:
>  > 
>  > > (Large pages ignoring PAT index bit 2, or something like that.)
>  > 
>  > change_page_attr will force 4K pages for these anyways, so for the kernel
>  > direct mapping it should not be an issue. 
>  > 
>  > For the hugetlbfs user mapping you may need to check the case, but
>  > it's probably reasonable to EINVAL there.
>  > 
>  > Other than that everything should be 4K mapped.
> 
> The bug is that 4K pages get the wrong PAT index; the large page
> thing is the trigger but the large pages themselves arent' affected.
> 
> So 4K pages need to be restricted to the low 4 PAT types.

Should be no issue. cache disabled and write combining seem to be the
only really useful caching types anyways. You don't even need to mess
with the PAT registers for them, the default 486/586 compatible WC and CD PTE
bits should work.

-Andi
