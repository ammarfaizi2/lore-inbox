Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273996AbRJVPOh>; Mon, 22 Oct 2001 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274774AbRJVPOZ>; Mon, 22 Oct 2001 11:14:25 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:8407 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273996AbRJVPNq>; Mon, 22 Oct 2001 11:13:46 -0400
Date: Mon, 22 Oct 2001 11:14:16 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: sten@blinkenlights.nl, linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
Message-ID: <20011022111416.A23213@redhat.com>
In-Reply-To: <20011021.080432.71105870.davem@redhat.com> <Pine.LNX.4.40-blink.0110211736030.19859-100000@deepthought.blinkenlights.nl> <20011021.181523.112610375.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011021.181523.112610375.davem@redhat.com>; from davem@redhat.com on Sun, Oct 21, 2001 at 06:15:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 06:15:23PM -0700, David S. Miller wrote:
> 
> DRI works perfectly fine in my current sources, patches below.

On a side note of coding style, the following:

> +#ifdef __sparc__
> +		if (io_remap_page_range(vma->vm_start,
> +					VM_OFFSET(vma) + offset,
> +					vma->vm_end - vma->vm_start,
> +					vma->vm_page_prot, 0))
> +#else
>  		if (remap_page_range(vma->vm_start,
>  				     VM_OFFSET(vma) + offset,
>  				     vma->vm_end - vma->vm_start,
>  				     vma->vm_page_prot))
> +#endif

should really be turned into io_remap_page_range(...) unconditionally 
and add a #define for io_remap_page_range in the arch specific code.  
Having #ifdef's all over generic code is just ugly.

		-ben
