Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbTAOTQj>; Wed, 15 Jan 2003 14:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267114AbTAOTQj>; Wed, 15 Jan 2003 14:16:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:47633 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267025AbTAOTQf>;
	Wed, 15 Jan 2003 14:16:35 -0500
Date: Wed, 15 Jan 2003 21:25:20 +0200
From: Dan Aloni <da-x@gmx.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.57
Message-ID: <20030115192520.GA13444@callisto.yi.org>
References: <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 10:44:25AM -0800, Linus Torvalds wrote:

> And special mention for Brian Gerst, who figured out and fixed a x86 page
> table initialization fix that would leave old machines unable to boot
> 2.5.x. That might explain a number of the "I can't run 2.5.x" that weren't
> seen by developers (most developers tend to have hardware studly enough
> that they'd never see the problem).

We can get most hardware to boot a little faster if we add this part of 
the patch which seems to have been dropped out, comparing to Brian's 
patch from 6 months ago.

--- linux-2.5.57/arch/i386/mm/init.c      2003-01-13 20:17:41.000000000 +0200
+++ linux-2.5.57/arch/i386/mm/init.c      2003-01-14 00:01:19.000000000 +0200
@@ -112,9 +112,7 @@
 
                pmd = pmd_offset(pgd, vaddr);
                for (; (pmd_ofs < PTRS_PER_PMD) && (vaddr != end); pmd++, pmd_ofs++) {
-                       if (pmd_none(*pmd)) 
-                               one_page_table_init(pmd);
-
+                       one_page_table_init(pmd);
                        vaddr += PMD_SIZE;
                }
                pmd_ofs = 0;


 
-- 
Dan Aloni
da-x@gmx.net
