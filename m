Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130667AbRAFRQS>; Sat, 6 Jan 2001 12:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbRAFRQJ>; Sat, 6 Jan 2001 12:16:09 -0500
Received: from hermes.mixx.net ([212.84.196.2]:14859 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130667AbRAFRP5>;
	Sat, 6 Jan 2001 12:15:57 -0500
Message-ID: <3A57521C.BEF2E349@innominate.de>
Date: Sat, 06 Jan 2001 18:13:00 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jared Sulem <jsulem@sulem.freeserve.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [non-kernel patch] Re: bug of Nvidia (0.9.5) Drivers in 2.4 Kernel 
 Enviroment
In-Reply-To: <NEBBKEIJMLEIHACEGKDMAEAECAAA.jsulem@sulem.freeserve.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jared Sulem wrote:
> Driver should work after applying the following patch.  I'm not a kernel
> hacker so I don't know how good a solution this is (especially suspicious
> of the work around in os-interface.c) but X works on my machine and it has
> not crashed (yet) - have not tried any OpenGL though.
> [...]
>
>  struct vm_operations_struct nv_vm_ops = {
>      open:     nv_vma_open,
>      close:    nv_vma_release,
> -    unmap:    nv_vma_unmap,
> +    nv_vma_unmap,
       ^^^^^^^^^^^^^
No... 1) Bad idea to mix named field initializers with positional  Here
you're initializing a nonexistent field  2) The unmap method is gone
from vm_operations_struct because this is now handled generically.  Just
remove it.

>  };
>  #endif

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
