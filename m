Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTFQCNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 22:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTFQCNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 22:13:09 -0400
Received: from holomorphy.com ([66.224.33.161]:13471 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264534AbTFQCNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 22:13:07 -0400
Date: Mon, 16 Jun 2003 19:26:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71-bk2-wli-1
Message-ID: <20030617022658.GI26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030617005807.GR20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617005807.GR20413@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 05:58:07PM -0700, William Lee Irwin III wrote:
> + highpmd fixes
> 	a few mm/memory.c functions forgot to pass pmd pointers by reference

Woops, I missed one:


diff -prauN wli-2.5.71-bk2-8/mm/memory.c wli-2.5.71-bk2-9/mm/memory.c
--- wli-2.5.71-bk2-8/mm/memory.c	2003-06-16 14:59:11.000000000 -0700
+++ wli-2.5.71-bk2-9/mm/memory.c	2003-06-16 17:45:05.000000000 -0700
@@ -1002,7 +1002,7 @@ int remap_page_range(struct vm_area_stru
 		error = remap_pmd_range(vma, &pmd, from, end - from, phys_addr + from, prot);
 		if (error)
 			break;
-		pmd_unmap(pmd);
+		pmd_unmap(pmd - 1);
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (from && (from < end));
