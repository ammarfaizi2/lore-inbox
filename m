Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbUKFFDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbUKFFDu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 00:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUKFFDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 00:03:49 -0500
Received: from cantor.suse.de ([195.135.220.2]:41442 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261315AbUKFFDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 00:03:48 -0500
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, dominik.karall@gmx.net
Subject: Re: 2.6.10-rc1-mm3: modprobe oopses [x86]
References: <200411060223.26516.bero@arklinux.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Nov 2004 06:03:47 +0100
In-Reply-To: <200411060223.26516.bero@arklinux.org.suse.lists.linux.kernel>
Message-ID: <p73oeib7emk.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> writes:

> modprobe ohci1394 leads to:

Apply this patch. 

-Andi

diff -up linux-2.6.10rc1-mm3/mm/vmalloc.c-o linux-2.6.10rc1-mm3/mm/vmalloc.c
--- linux-2.6.10rc1-mm3/mm/vmalloc.c-o	2004-11-05 11:42:00.000000000 +0100
+++ linux-2.6.10rc1-mm3/mm/vmalloc.c	2004-11-05 14:49:25.000000000 +0100
@@ -213,7 +213,7 @@ int map_vm_area(struct vm_struct *area, 
 			err = -ENOMEM;
 			break;
 		}
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
+		next = (address + PML4_SIZE) & PML4_MASK;
 		if (next < address || next > end)
 			next = end;
 		if (map_area_pgd(pgd, address, next, prot, pages)) {

 
