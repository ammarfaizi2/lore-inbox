Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRAXUsZ>; Wed, 24 Jan 2001 15:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAXUsP>; Wed, 24 Jan 2001 15:48:15 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:60399 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129375AbRAXUsG>; Wed, 24 Jan 2001 15:48:06 -0500
Date: Wed, 24 Jan 2001 14:48:05 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Cc: Linux MM mailing list <linux-mm@kvack.org>
In-Reply-To: <3A6F3E05.4090409@valinux.com>
In-Reply-To: <20010124174824Z129401-18594+948@vger.kernel.org> <20010124203012Z129444-18594+1042@vger.kernel.org>
Subject: Re: Page Attribute Table (PAT) support?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010124204811Z129375-18594+1059@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Wed, 24 Jan
2001 13:41:41 -0700

> When you mark a page UCWC, you better 
> have removed all cached mappings or your asking for REAL trouble.

What exactly do you mean by "removed all cached mappings"?  Does that mean that
if one virtual address is a UCWC mapping of a physical page, then ALL virtual
addresses mapped to that page must also be UCWC?

In my driver, I use ioremap_nocache() on physical memory (real RAM) to create
an uncached "alias" (a virtual address) to a physical page of RAM.  When I
access the memory via this virtual address, the memory access is not cached.
What I reall need is to be able to also have that virtual address as Write
Combined.

Since all physical RAM is mapped as cached via the kernel (on a 1-to-1 basis),
and since there can be several other virtual addresses that point to that memory
(e.g. user virtual address), I can't see how these virtual addresses can be
removed.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
