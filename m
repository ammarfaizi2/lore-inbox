Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbUKRAkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUKRAkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbUKRAd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:33:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:42901 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262669AbUKRAZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:25:15 -0500
Subject: Re: [patch 4/4] Xen core patch : /dev/mem calls io_remap_page_range
From: Dave Hansen <haveblue@us.ibm.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
In-Reply-To: <E1CUZfD-00059Q-00@mta1.cl.cam.ac.uk>
References: <E1CUZfD-00059Q-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Message-Id: <1100737504.12373.259.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 17 Nov 2004 16:25:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 15:56, Ian Pratt wrote:
> +#if defined(CONFIG_XEN)
> +       if (io_remap_page_range(vma, vma->vm_start, offset, 
> +                               vma->vm_end-vma->vm_start, vma->vm_page_prot))
> +               return -EAGAIN;
> +#else
>         if (remap_page_range(vma, vma->vm_start, offset, vma->vm_end-vma->vm_start,
>                              vma->vm_page_prot))
>                 return -EAGAIN;
> +#endif
>         return 0;
>  }

Do *all* calls to remap_page_range() under your arch need to be
converted like this, or is this the only one?  Seems like something that
should be done with header magic instead.  

-- Dave

