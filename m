Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTKUNIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 08:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTKUNIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 08:08:24 -0500
Received: from holomorphy.com ([199.26.172.102]:9138 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261956AbTKUNIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 08:08:23 -0500
Date: Fri, 21 Nov 2003 05:08:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4
Message-ID: <20031121130810.GQ22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20031118225120.1d213db2.akpm@osdl.org> <3FBDCCDF.9010304@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBDCCDF.9010304@gmx.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 21, 2003 at 09:29:19AM +0100, Prakash K. Cheemplavam wrote:
> kernel BUG at arch/i386/mm/fault.c:357!
> invalid operand: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c011da40>]    Tainted: PF  VLI
> EFLAGS: 00210293
> EIP is at do_page_fault+0x3a0/0x53a
> eax: f6415dc0   ebx: f6415dc0   ecx: 00000000   edx: f6415dc0
> esi: f6415de0   edi: f69f9180   ebp: f6c3dfb4   esp: f6c3df0c
> ds: 007b   es: 007b   ss: 0068


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
