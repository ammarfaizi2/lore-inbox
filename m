Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVBVX35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVBVX35 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVBVX35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:29:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:29914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261330AbVBVX3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:29:46 -0500
Date: Tue, 22 Feb 2005 15:34:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: matthew@wil.cx, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
Message-Id: <20050222153456.502c3907.akpm@osdl.org>
In-Reply-To: <yq0zmxwgqxr.fsf@jaguar.mkp.net>
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
	<yq0ekf8lksf.fsf@jaguar.mkp.net>
	<20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	<20050222112513.4162860d.akpm@osdl.org>
	<yq0zmxwgqxr.fsf@jaguar.mkp.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@wildopensource.com> wrote:
>
> After applying the clue 2x4 to my head a couple of times, I came up
> with this patch. Hopefully it will work a bit better ;-)
> 

I know it's repetitious, but it's nice to maintain a changelog entry along
with the patch.  Especially when seventy people have asked "wtf is this patch
for?".

Implementation-wise, do you really need to clone-and-own the mem.c
functions?  Would it not be sufficient to do

	ptr = arch_translate_mem_ptr(page, ptr);

inside mem.c?


> + *  arch/ia64/kernel/mem.c
> ...
> +extern loff_t memory_lseek(struct file * file, loff_t offset, int orig);
> +extern int mmap_kmem(struct file * file, struct vm_area_struct * vma);
> +extern int open_port(struct inode * inode, struct file * filp);
> +

Please find a .h file for the function prototypes.
