Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271756AbRICRJQ>; Mon, 3 Sep 2001 13:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271755AbRICRJF>; Mon, 3 Sep 2001 13:09:05 -0400
Received: from colorfullife.com ([216.156.138.34]:57097 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S271754AbRICRIu>;
	Mon, 3 Sep 2001 13:08:50 -0400
Message-ID: <000f01c1349b$263fb890$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: mmap-rb-7 [was Re: /proc/<n>/maps growing...]
Date: Mon, 3 Sep 2001 19:09:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * vma->vm_start/vm_end cannot change under us because the caller is
required
> + * to hold the mmap_sem in write mode. We need to get the spinlock
only
> + * before relocating the vma range ourself.
> + */

There is one exception to that rule: a growable stack grows with
mmap_sem only acquired in read mode. vm_start can change on platforms
where the stack grows down, probably vm_end changes on platforms where
the stack grows upwards.

> - lock_vma_mappings(vma);
> - spin_lock(&vma->vm_mm->page_table_lock);
>  vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
> + lock_vma_mappings(vma);
> + spin_lock(&mm->page_table_lock);
> vma->vm_start = end;

Could be wrong with concurrent stack faults.

--
    Manfred

