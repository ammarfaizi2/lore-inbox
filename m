Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVAGEX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVAGEX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 23:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVAGEX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 23:23:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:20141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261227AbVAGEXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 23:23:53 -0500
Date: Thu, 6 Jan 2005 20:23:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A new entry for /proc
Message-Id: <20050106202339.4f9ba479.akpm@osdl.org>
In-Reply-To: <3f250c7105010613115554b9d9@mail.gmail.com>
References: <3f250c7105010613115554b9d9@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin <mauriciolin@gmail.com> wrote:
>
> Here is a new entry developed for /proc that prints for each process
> memory area (VMA) the size of rss. The maps from original kernel is
> able to present the virtual size for each vma, but not the physical
> size (rss). This entry can provide an additional information for tools
> that analyze the memory consumption. You can know the physical memory
> size of each library used by a process and also the executable file.
> 
> Take a look the output:
> # cat /proc/877/smaps
> 08048000-08132000 r-xp  /usr/bin/xmms
> Size:     936 kB
> Rss:     788 kB

This is potentially quite useful.  I'd be interested in what others think of
the idea and implementation.

> Here is the patch:

- It was wordwrapped.  Mail the patch to yourself first, make sure it
  still applies.

- Prepare patches with `diff -u'

- 

> + extern struct seq_operations proc_pid_smaps_op;

  Put extern headers in .h files, not in .c.


> + static void resident_mem_size(struct mm_struct *mm, unsigned long
> start_address,
> + 			unsigned long end_address, unsigned long *size) {
> + 	pgd_t *pgd;
> + 	pmd_t *pmd;
> + 	pte_t *ptep, pte;
> + 	unsigned long page;

The identifier `page' is usually used for pointers to struct page.  Please
pick another name?

> + 			if (pte_present(pte)) {
> + 				*size += PAGE_SIZE;
> + 			}

We prefer to omit the braces if they enclose only a single statement.

> + 	if (map->vm_file) {
> + 		len = sizeof(void*) * 6 - len;
> + 		if (len < 1)
> + 			len = 1;
> + 		seq_printf(m, "%*c", len, ' ');
> + 		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
> + 	}

hm, that's a bit bizarre.  Isn't there a printf construct which will do the
right-alignment for you?  %8u?  (See meminfo_read_proc())

