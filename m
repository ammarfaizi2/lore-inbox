Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbTKTCNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTKTCNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:13:06 -0500
Received: from holomorphy.com ([199.26.172.102]:39595 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264297AbTKTCNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:13:02 -0500
Date: Wed, 19 Nov 2003 18:12:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@24x7linux.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120021258.GB22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@24x7linux.com,
	linux-kernel@vger.kernel.org
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031120002119.GA7875@localhost> <20031119170233.2619ba81.akpm@osdl.org> <20031120011209.GZ22764@holomorphy.com> <20031119175803.65d7dc99.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119175803.65d7dc99.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  Here it is.

On Wed, Nov 19, 2003 at 05:58:03PM -0800, Andrew Morton wrote:
> All the world's an x86 ;)
> This whole patch is getting rather large.
> ARM is doing weird stuff.

I just realized this can all be done in one line by setting the initial
value of ret to VM_FAULT_MINOR in do_no_page(). The ->nopage() methods
not updated will give off compiler warnings and since they think their
third arguments are ordinary integers, they won't update the referenced
content, and the initializer of VM_FAULT_MINOR then comes into play.


-- wli


diff -prauN mm4-2.6.0-test9-1/mm/memory.c mm4-2.6.0-test9-default-2/mm/memory.c
--- mm4-2.6.0-test9-1/mm/memory.c	2003-11-19 00:07:15.000000000 -0800
+++ mm4-2.6.0-test9-default-2/mm/memory.c	2003-11-19 18:08:49.000000000 -0800
@@ -1424,7 +1424,7 @@ do_no_page(struct mm_struct *mm, struct 
 	pte_t entry;
 	struct pte_chain *pte_chain;
 	int sequence = 0;
-	int ret;
+	int ret = VM_FAULT_MINOR;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
