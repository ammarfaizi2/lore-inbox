Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVHCKXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVHCKXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVHCKXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:23:15 -0400
Received: from ns.suse.de ([195.135.220.2]:19596 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262187AbVHCKXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:23:13 -0400
Date: Wed, 3 Aug 2005 12:23:13 +0200
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64: Fix off by one in e820_mapped
Message-ID: <20050803102313.GP10895@wotan.suse.de>
References: <m14qad4f5n.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14qad4f5n.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 12:53:56PM -0600, Eric W. Biederman wrote:
> 
> This allows a valid iommu placed immediately after memory
> to work, to be recognized as after the last byte of memory
> and not overlapping it.

Looks good thanks. I see Andrew has already queued it up.

-Andi

> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
>  arch/x86_64/kernel/e820.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> a0929b87b8d0d059a10eb3e61da3d679d64980e1
> diff --git a/arch/x86_64/kernel/e820.c b/arch/x86_64/kernel/e820.c
> --- a/arch/x86_64/kernel/e820.c
> +++ b/arch/x86_64/kernel/e820.c
> @@ -85,7 +85,7 @@ int __init e820_mapped(unsigned long sta
>  		struct e820entry *ei = &e820.map[i]; 
>  		if (type && ei->type != type) 
>  			continue;
> -		if (ei->addr >= end || ei->addr + ei->size < start) 
> +		if (ei->addr >= end || ei->addr + ei->size <= start) 
>  			continue; 
>  		return 1; 
>  	} 
