Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbSJCCEd>; Wed, 2 Oct 2002 22:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262717AbSJCCEd>; Wed, 2 Oct 2002 22:04:33 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:36764
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262716AbSJCCEd>; Wed, 2 Oct 2002 22:04:33 -0400
Date: Wed, 2 Oct 2002 20:58:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.5.40, flush_tlb_mm
In-Reply-To: <3D9BA086.76B60194@digeo.com>
Message-ID: <Pine.LNX.4.44.0210022057550.14293-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002, Andrew Morton wrote:

> You need Hugh's patch.  Was sent to Linus yesterday...

Oh, thanks, sucks being in the dark like this :/

> 
> Patch from Hugh Dickins
> 
> Our earlier fix for mprotect_fixup was broken - passing an
> already-freed VMA to change_protection().
> 
> 
> 
>  mm/mprotect.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
> 
> --- 2.5.40/mm/mprotect.c~hugh-mprotect-fix	Tue Oct  1 23:43:14 2002
> +++ 2.5.40-akpm/mm/mprotect.c	Tue Oct  1 23:43:14 2002
> @@ -186,8 +186,10 @@ mprotect_fixup(struct vm_area_struct *vm
>  		/*
>  		 * Try to merge with the previous vma.
>  		 */
> -		if (mprotect_attempt_merge(vma, *pprev, end, newflags))
> +		if (mprotect_attempt_merge(vma, *pprev, end, newflags)) {
> +			vma = *pprev;
>  			goto success;
> +		}
>  	} else {
>  		error = split_vma(mm, vma, start, 1);
>  		if (error)
> 
> .
> 

-- 
function.linuxpower.ca

