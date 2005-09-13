Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVIMTZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVIMTZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVIMTZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:25:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965167AbVIMTZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:25:57 -0400
Date: Tue, 13 Sep 2005 12:25:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, rusty@rustcorp.com.au
Subject: Re: [patch 1/11] mm: Reimplementation of dynamic per-cpu allocator
 -- vmalloc_fixup
Message-Id: <20050913122511.6a8fe01f.akpm@osdl.org>
In-Reply-To: <20050913155416.GC3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
	<20050913155416.GC3570@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> Patch to add gfp_flags as args to __get_vm_area.  alloc_percpu needs to use
>  GFP flags as the dst_entry.refcount needs to be allocated with GFP_ATOMIC.
>  Since alloc_percpu needs get_vm_area underneath, this patch changes
>  __get_vmarea to accept gfp_flags as arg, so that alloc_percpu can use
>  __get_vm_area.  get_vm_area remains unchanged.

Is dst_alloc() ever called from IRQ or softirq contexts?

If so, __get_vm_area()'s write_lock(&vmlist_lock) is now deadlockable.

If not, then you've just added a restriction to dst_alloc()'s usage which
should be checked over by the net guys and which needs commenting in the code.

