Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRCWTnn>; Fri, 23 Mar 2001 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131385AbRCWTnc>; Fri, 23 Mar 2001 14:43:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14347 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131382AbRCWTn2>; Fri, 23 Mar 2001 14:43:28 -0500
Date: Fri, 23 Mar 2001 11:42:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch(?): linux-2.4.3-pre6/mm/vmalloc.c could return with
 init_mm.page_table_lock held
In-Reply-To: <Pine.LNX.4.21.0103230634320.5947-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0103231140580.766-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Marcelo Tosatti wrote:
>
> There is no need to hold mm->page_table_lock for vmalloced memory.

But there is. You do need _some_ protection to protect the kernel from
inserting two different pmd/pgd entries for two different areas in the
same slot. And that's exactly what page_table_lock does for us.

> I guess a better solution is to make the vmalloc codepath use
> "pte_alloc_vmalloc" (or something like that) which would be a
> spinlock-free version of pte_alloc (like the old one).

The old one avoided the race by using the big kernel lock. Which is
totally non-sensical, but works. It's much better to use the spinlock that
is meant for exactly this thing.

		Linus

