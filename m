Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVAJOfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVAJOfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVAJOfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:35:38 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:14781 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262276AbVAJOf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:35:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mgvJ1TvrXNOB2+GZ6ZCjqYmQuCyPXlxBXVmaXlchA0y/Yt9KfaZ4Gioc9GIjF49KQmVQwxKjoIdG5VQ8wFyUsKCwutxikfE4nAy3bL68v2e7B4IF8feK4/wUJ76qzjRDCUs1YXIIj18sPcZDYcXDznynnoN5Lpzey9MAvFTtuX0=
Message-ID: <3f250c71050110063523fcdd65@mail.gmail.com>
Date: Mon, 10 Jan 2005 10:35:26 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] A new entry for /proc
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050106202339.4f9ba479.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c7105010613115554b9d9@mail.gmail.com>
	 <20050106202339.4f9ba479.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005 20:23:39 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Mauricio Lin <mauriciolin@gmail.com> wrote:
> >
> > Here is a new entry developed for /proc that prints for each process
> > memory area (VMA) the size of rss. The maps from original kernel is
> > able to present the virtual size for each vma, but not the physical
> > size (rss). This entry can provide an additional information for tools
> > that analyze the memory consumption. You can know the physical memory
> > size of each library used by a process and also the executable file.
> >
> > Take a look the output:
> > # cat /proc/877/smaps
> > 08048000-08132000 r-xp  /usr/bin/xmms
> > Size:     936 kB
> > Rss:     788 kB
> 
> This is potentially quite useful.  I'd be interested in what others think of
> the idea and implementation.
> 
> > Here is the patch:
> 
> - It was wordwrapped.  Mail the patch to yourself first, make sure it
>   still applies.
> 
> - Prepare patches with `diff -u'
OK.
> 
> -
> 
> > + extern struct seq_operations proc_pid_smaps_op;
> 
>   Put extern headers in .h files, not in .c.
OK.
> 
> 
> > + static void resident_mem_size(struct mm_struct *mm, unsigned long
> > start_address,
> > +                     unsigned long end_address, unsigned long *size) {
> > +     pgd_t *pgd;
> > +     pmd_t *pmd;
> > +     pte_t *ptep, pte;
> > +     unsigned long page;
> 
> The identifier `page' is usually used for pointers to struct page.  Please
> pick another name?
OK.
> 
> > +                     if (pte_present(pte)) {
> > +                             *size += PAGE_SIZE;
> > +                     }
> 
> We prefer to omit the braces if they enclose only a single statement.
> 
> > +     if (map->vm_file) {
> > +             len = sizeof(void*) * 6 - len;
> > +             if (len < 1)
> > +                     len = 1;
> > +             seq_printf(m, "%*c", len, ' ');
> > +             seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
> > +     }
> 
> hm, that's a bit bizarre.  Isn't there a printf construct which will do the
> right-alignment for you?  %8u?  (See meminfo_read_proc())
OK, we will follow your suggestion. This was an informal PATCH, just
to present the idea of this work for the list. So the mistakes you
pointed will be fixed and I will send to the list a more formal PATCH
with the developers names attached. OK?
> 
>
