Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbULJXvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbULJXvk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 18:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbULJXvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 18:51:40 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:40708 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261874AbULJXvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 18:51:37 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10rc3+cset == oops (fs).
Date: Sat, 11 Dec 2004 00:51:34 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200412102330.02459.pluto@pld-linux.org> <20041210152555.5c579892.akpm@osdl.org>
In-Reply-To: <20041210152555.5c579892.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412110051.35050.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 of December 2004 00:25, Andrew Morton wrote:
> Pawe__ Sikora <pluto@pld-linux.org> wrote:
> > I've just tried to boot the 2.6.10rc3+cset20041210_0507.
> >
> > [handcopy of the ooops]
> >
> > dereferencing null pointer
> > eip at: radix_tree_tag_clear

 407:lib/radix-tree.c **** 
 408:lib/radix-tree.c ****   if (*pathp->slot == NULL)     <=== ooopses here
 409:lib/radix-tree.c ****    goto out;
 410:lib/radix-tree.c **** 

 1341                .loc 1 408 0
 1342 0605 8B45A4     movl -92(%ebp), %eax # <variable>.slot, D.9023
 1343 0608 8B00       movl (%eax), %eax #* D.9023,
 1344 060a 85C0       testl %eax, %eax #
 1345 060c 744F       je .L132 #,

> > trace:
> > (...)
> > test_clear_page_dirty
> > truncate_complete_page
> > truncate_inode_pages_range
> > truncate_inode_pages
> > generic_delete_inode
> > sys_unlink
> > initrd_load
> > prepare_namespace
> > (...)
>
> I can't think of any recent changes whish could cause something like this.
> Is this reproducible?  If so, could you please work out which kernel
> version and bk snapshot introduced the bug?  Thanks.

2.6.10rc1+cset20041025_0606 works fine (I'm using it now).
2.6.10rc3+cset20041210_0507 oopses.

I'll do more test later...

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
