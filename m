Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263454AbTJLLxi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTJLLxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:53:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:29910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263454AbTJLLxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:53:35 -0400
Date: Sun, 12 Oct 2003 04:56:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] invalidate_mmap_range() misses
 remap_file_pages()-affected targets
Message-Id: <20031012045644.0dce8f6b.akpm@osdl.org>
In-Reply-To: <20031012103436.GC765@holomorphy.com>
References: <20031012084842.GB765@holomorphy.com>
	<20031012103436.GC765@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> It would seem that mincore() shares a similar issue on account of its
>  algorithm

Yes, I think it makes sense to fix mincore().  I don't fully understand the
reasoning behind the three cases though:

+	if (pte_file(*pte))
+		present = mincore_linear_page(vma, pte_to_pgoff(*pte));
+	else if (!(vma->vm_flags | (VM_READ|VM_WRITE|VM_MAYREAD|VM_MAYWRITE)))
+		present = pte_present(*pte);
+	else
+		present = mincore_linear_page(vma, pgoff);

Could you explain the logic behind each of these?  Perhaps with permanent
comments?

