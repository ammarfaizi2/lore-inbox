Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318151AbSGWRPT>; Tue, 23 Jul 2002 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318156AbSGWRPS>; Tue, 23 Jul 2002 13:15:18 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:62985 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318151AbSGWRPR>; Tue, 23 Jul 2002 13:15:17 -0400
Date: Tue, 23 Jul 2002 14:17:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: David F Barrera <dbarrera@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0,
 mode:0x0
In-Reply-To: <OFA7B7DCC3.8F04308C-ON85256BFF.005DA646@pok.ibm.com>
Message-ID: <Pine.LNX.4.44L.0207231417110.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, David F Barrera wrote:

> I should have stated that the problem is occurring on the 2.5.26 kernel,
> NOT 2.4.26.  My mistake.  Also, the hardware is an IBM eServer 8-way
> x370 with 12GB or RAM, SCSI drives, 2GB swap.

Does the attached patch fix it ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


===== mm/rmap.c 1.3 vs edited =====
--- 1.3/mm/rmap.c	Tue Jul 16 18:46:30 2002
+++ edited/mm/rmap.c	Tue Jul 23 14:01:23 2002
@@ -163,7 +163,7 @@
 void page_remove_rmap(struct page * page, pte_t * ptep)
 {
 	struct pte_chain * pc, * prev_pc = NULL;
-	unsigned long pfn = pte_pfn(*ptep);
+	unsigned long pfn = page_to_pfn(page);

 	if (!page || !ptep)
 		BUG();

