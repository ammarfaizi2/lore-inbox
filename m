Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315443AbSEGNzh>; Tue, 7 May 2002 09:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSEGNzg>; Tue, 7 May 2002 09:55:36 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:6083 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S315443AbSEGNzg>; Tue, 7 May 2002 09:55:36 -0400
Date: Tue, 7 May 2002 14:58:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] get_ma_area() function
In-Reply-To: <20020507115854.GB620@pazke.ipt>
Message-ID: <Pine.LNX.4.21.0205071454110.2018-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Andrey Panin wrote:
> 
> looking at mm/vmalloc.c i found one strange (for me) line of code.
> 
> From mm/vmalloc.c:
> 
> struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
> {
> 	unsigned long addr;
> 	struct vm_struct **p, *tmp, *area;
> 
> 	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
> 	if (!area)
> 		return NULL;
> 	size += PAGE_SIZE;
> 	^^^^^^^^^^^^^^^^^^
> Why ? Maybe size = PAGE_ALIGN(size); is more correct here ?

No, __vmalloc already did the size = PAGE_ALIGN(size).
Here it is intentionally adding one page to the virtual allocation size,
to leave one invalid guard or fence page between vmalloc'ed allocations,
to trap overruns from one area to the next.  You're right, a comment
would be appropriate there.

Hugh

