Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTAWJwf>; Thu, 23 Jan 2003 04:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTAWJwf>; Thu, 23 Jan 2003 04:52:35 -0500
Received: from [213.86.99.237] ([213.86.99.237]:52978 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265063AbTAWJwe>; Thu, 23 Jan 2003 04:52:34 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030123015659.422e8179.akpm@digeo.com> 
References: <20030123015659.422e8179.akpm@digeo.com>  <000001c2c287$ffa8eef0$800b040f@bergamot> <15943.1043315303@passion.cambridge.redhat.com> 
To: Andrew Morton <akpm@digeo.com>
Cc: ch@murgatroid.com, fbecker@intrinsyc.com,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.55-rmk1: user space lossage 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Jan 2003 10:01:12 +0000
Message-ID: <17281.1043316072@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


akpm@digeo.com said:
> Linus did it!

> diff -puN mm/filemap.c~generic_file_readonly_mmap-fix mm/filemap.c
> --- 25/mm/filemap.c~generic_file_readonly_mmap-fix	2003-01-23 01:55:41 -0800
> +++ 25-akpm/mm/filemap.c	2003-01-23 01:55:45 -0800
> @@ -1312,7 +1312,6 @@ int generic_file_readonly_mmap(struct fi
>  {
>  	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
> 		return -EINVAL;
> - 	vma->vm_flags &= ~VM_MAYWRITE;
>  	return generic_file_mmap(file, vma);
>  }
>  #else


-  	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
+-  	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
++ 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))



...?

--
dwmw2


