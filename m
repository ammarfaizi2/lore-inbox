Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTKWBSL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 20:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTKWBSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 20:18:11 -0500
Received: from holomorphy.com ([199.26.172.102]:28854 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262297AbTKWBSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 20:18:10 -0500
Date: Sat, 22 Nov 2003 17:18:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 oops
Message-ID: <20031123011805.GT22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
References: <20031122054904.GA3656@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031122054904.GA3656@middle.of.nowhere>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 06:49:04AM +0100, Jurriaan wrote:
> Nov 21 21:25:40 middle kernel: ------------[ cut here ]------------
> Nov 21 21:25:40 middle kernel: kernel BUG at arch/i386/mm/fault.c:357!
> Nov 21 21:25:40 middle kernel: invalid operand: 0000 [#1]


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
