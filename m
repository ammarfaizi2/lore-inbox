Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265880AbUFITsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265880AbUFITsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUFITsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:48:23 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:60938 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265880AbUFITr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:47:57 -0400
Subject: Re: swsusp "not enough swap space" 2.6.5-mm6.
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Mark Gross <mgross@linux.jf.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200406090927.51206.mgross@linux.intel.com>
References: <200406080829.35120.mgross@linux.intel.com>
	 <20040608230450.GA13916@elf.ucw.cz>
	 <200406090832.04064.mgross@linux.intel.com>
	 <200406090927.51206.mgross@linux.intel.com>
Content-Type: multipart/mixed; boundary="=-Sipj/sSkH+Y8jKHe2ExZ"
Date: Wed, 09 Jun 2004 21:48:00 +0200
Message-Id: <1086810480.1982.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sipj/sSkH+Y8jKHe2ExZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-06-09 at 09:27 -0700, Mark Gross wrote:
> On Wednesday 09 June 2004 08:32, Mark Gross wrote:
> > On Tuesday 08 June 2004 16:04, Pavel Machek wrote:
> > > Hi!
> > >
> > > > I'm sorry for not having more information, but the failing computer is
> > > > my home laptop (I'll get more details after work or I'll bring it in
> > > > tomorrow for more details).
> > > >
> > > > Anyway, this thing does software suspend using the 2.6.2-mm1 kernel,
> > > > and last night I was updating it to 2.6.5-mm6, and I started getting
> > > > these not enough disk space errors.
> > > >
> > > > I found your bug fix patch,
> > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=107806008626357&w=2
> > > >  and checked that it is included in the 2.6.5-mm6 kernel I'm using.
> > > >
> > > > Without more information does this problem ring any bells?
> > > >
> > > > Can you recommend a "good" kernel version that does reliable swsusp?
> > >
> > > Get 2.6.6, and set swappiness to 100.
> > >
> > > 								Pavel
> >
> > 2.6.6 still fails, just like the failure reported by the thread independent
> > of swappiness:
> >
> > http://marc.theaimsgroup.com/?t=107806010900002&r=1&w=2
> >
> > However; as hinted in the thread turning off premption does seem to fix the
> > problem.
> >
> 
> Spoke too soon.  My build tree that had the success was 2.6.6-mm6, so I 
> re-built a clean 2.6.6 from tarball using the .config from the successful 
> run, CONFIG_PREEMPT=n.  It fails.  2.6.6-mm5 works, but only if 
> CONFIG_PREEMPT=n.
> 
> I have to get to my day job now, but whats up with the flakieness of the 
> swsusp?  Shouldn't it be mostly working by now?

It's working flawlessly for me with 2.6.7-rc3-mm1. I also applied the
following patches (who knows)...

--=-Sipj/sSkH+Y8jKHe2ExZ
Content-Disposition: attachment; filename=swsusp-leak.fix
Content-Type: text/plain; name=swsusp-leak.fix; charset=utf-8
Content-Transfer-Encoding: 7bit

>From linux-kernel-owner@vger.kernel.org Wed Jun  9 16:00:10 2004
Return-Path:
	<linux-kernel-owner+felipe_alfaro=40linuxmail.org-s263939abufinft@vger.kernel.org>
Received: from kerberos.felipe-alfaro.com ([unix socket]) by
	kerberos.felipe-alfaro.com (Cyrus v2.2.3) with LMTP; Wed, 09 Jun 2004
	16:00:10 +0200
X-Sieve: CMU Sieve 2.2
Received: from localhost (localhost.localdomain [127.0.0.1]) by
	kerberos.felipe-alfaro.com (Postfix) with ESMTP id 3306C42E3D for
	<yo@felipe-alfaro.com>; Wed,  9 Jun 2004 16:00:10 +0200 (CEST)
Delivered-To: felipe_alfaro:linuxmail.org@linuxmail.org
Received: from pop24.pr.outblaze.com [205.158.62.125] by localhost with
	POP3 (fetchmail-6.1.0) for yo@felipe-alfaro.com (single-drop); Wed, 09 Jun
	2004 16:00:10 +0200 (CEST)
Received: (qmail 14692 invoked by uid 0); 9 Jun 2004 13:07:17 -0000
X-OB-Received: from unknown (205.158.62.147) by mta45-1.us4.outblaze.com; 9
	Jun 2004 13:07:17 -0000
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244]) by
	spf5-2.us4.outblaze.com (Postfix) with ESMTP id BBEDB19A93B for
	<felipe_alfaro@linuxmail.org>; Wed,  9 Jun 2004 13:07:16 +0000 (GMT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S263939AbUFINFT (ORCPT <rfc822;felipe_alfaro@linuxmail.org>); Wed, 9 Jun
	2004 09:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbUFINFT
	(ORCPT <rfc822;linux-kernel-outgoing>); Wed, 9 Jun 2004 09:05:19 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:62337 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263939AbUFINFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Jun 2004 09:05:06 -0400
Received: by amd.ucw.cz (Postfix, from userid 8) id 7DD432BDBB; Wed,  9 Jun
	2004 15:04:51 +0200 (CEST)
Date:	Wed, 9 Jun 2004 15:04:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Fix memory leak in swsusp
Message-ID: <20040609130451.GA23107@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Evolution-Source: imap://falfaro;auth=GSSAPI@192.168.0.1/
Content-Transfer-Encoding: 8bit

Hi!

This fixes 2 memory leaks in swsusp: during relocating pagedir, eaten
pages were not properly freed in error path and even regular freeing
path was freeing one page too little. Please apply,

								Pavel

--- linux-cvs/kernel/power/swsusp.c	2004-05-22 19:39:01.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-06-06 00:30:09.000000000 +0200
@@ -503,6 +503,9 @@
 		if (!pbe)
 			continue;
 		pbe->orig_address = (long) page_address(page);
+		/* Copy page is dangerous: it likes to mess with
+		   preempt count on specific cpus. Wrong preempt count is then copied,
+		   oops. */
 		copy_page((void *)pbe->address, (void *)pbe->orig_address);
 		pbe++;
 	}
@@ -923,8 +952,9 @@
 	suspend_pagedir_t *new_pagedir, *old_pagedir = pagedir_nosave;
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
+	int ret = 0;
 
-	printk("Relocating pagedir");
+	printk("Relocating pagedir ");
 
 	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
 		printk("not necessary\n");
@@ -941,22 +971,23 @@
 		c = eaten_memory;
 	}
 
-	if (!m)
-		return -ENOMEM;
-
-	pagedir_nosave = new_pagedir = m;
-	copy_pagedir(new_pagedir, old_pagedir);
+	if (!m) {
+		printk("out of memory\n");
+		ret = -ENOMEM;
+	} else {
+		pagedir_nosave = new_pagedir = m;
+		copy_pagedir(new_pagedir, old_pagedir);
+	}
 
 	c = eaten_memory;
-	while(c) {
+	while (c) {
 		printk(":");
-		f = *c;
+		f = c;
 		c = *c;
-		if (f)
-			free_pages((unsigned long)f, pagedir_order);
+		free_pages((unsigned long)f, pagedir_order);
 	}
 	printk("|\n");
-	return 0;
+	return ret;
 }
 
 /*


--=-Sipj/sSkH+Y8jKHe2ExZ
Content-Disposition: attachment; filename=swsusp-swappiness.patch
Content-Type: text/x-patch; name=swsusp-swappiness.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

>From linux-kernel-owner@vger.kernel.org Sun May 30 22:00:15 2004
Return-Path:
	<linux-kernel-owner+felipe_alfaro=40linuxmail.org-s264331abue3tse@vger.kernel.org>
Received: from kerberos.felipe-alfaro.com ([unix socket]) by
	kerberos.felipe-alfaro.com (Cyrus v2.2.3) with LMTP; Sun, 30 May 2004
	22:00:15 +0200
X-Sieve: CMU Sieve 2.2
Received: from localhost (localhost.localdomain [127.0.0.1]) by
	kerberos.felipe-alfaro.com (Postfix) with ESMTP id 3BE1B42E7B for
	<yo@felipe-alfaro.com>; Sun, 30 May 2004 22:00:15 +0200 (CEST)
Delivered-To: felipe_alfaro:linuxmail.org@linuxmail.org
Received: from pop24.pr.outblaze.com [205.158.62.125] by localhost with
	POP3 (fetchmail-6.1.0) for yo@felipe-alfaro.com (single-drop); Sun, 30 May
	2004 22:00:15 +0200 (CEST)
Received: (qmail 30523 invoked by uid 0); 30 May 2004 19:50:03 -0000
X-OB-Received: from unknown (205.158.62.147) by mta45-1.us4.outblaze.com;
	30 May 2004 19:50:03 -0000
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244]) by
	spf5-2.us4.outblaze.com (Postfix) with ESMTP id 2EFE019AA00 for
	<felipe_alfaro@linuxmail.org>; Sun, 30 May 2004 19:50:01 +0000 (GMT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S264331AbUE3TsE (ORCPT <rfc822;felipe_alfaro@linuxmail.org>); Sun, 30 May
	2004 15:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbUE3TsE
	(ORCPT <rfc822;linux-kernel-outgoing>); Sun, 30 May 2004 15:48:04 -0400
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:55680 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264331AbUE3Tr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>); Sun, 30 May 2004 15:47:59 -0400
Received: by amd.ucw.cz (Postfix, from userid 8) id F361E2BA5C; Sun, 30 May
	2004 21:47:31 +0200 (CEST)
Date:	Sun, 30 May 2004 21:47:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Andrew Morton <akpm@zip.com.au>, Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040530194731.GA895@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net>
	 <20040528215642.GA927@elf.ucw.cz>
	 <200405291905.20925.cef-lkml@optusnet.com.au>
	 <40B85024.2040505@linuxmail.org> <20040529223648.GB1535@elf.ucw.cz>
	 <40B94546.4040605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B94546.4040605@yahoo.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Evolution-Source: imap://falfaro;auth=GSSAPI@192.168.0.1/
Content-Transfer-Encoding: 8bit

Hi!

> >Andrew, in 2.6.6 shrink_all_memory() does not work if swappiness ==
> >0. shrink_all_memory() calls balance_pgdat(), that calls
> >shrink_zone(), and that calls refill_inactive_zone(), which looks at
> >swappiness.
> >
> >Additional parameter to all these calls neutralizing swappiness would
> >help, as would temporarily setting swappiness to 100 in
> >shrink_all_memory. Is there a less ugly solution?
> 
> I have a cleanup patch that allows this sort of thing to easily
> be passed into the lower levels of reclaim functions. I don't
> know if it would be to Andrew's taste though...
> 
> It basically replaces all function parameters in vmscan.c with
> 
> struct scan_control {
> 	unsigned long nr_to_scan;
> 	unsigned long nr_scanned;
> 	unsigned long nr_reclaimed;
> 	unsigned int gfp_mask;
> 	struct page_state ps;
> 	int may_writepage;
> };
> 
> So you could easily add a field for swsusp.
> 
> Until something like this goes through, please don't fuglify
> vmscan.c any more than it is... do the saving and restoring
> thing that Nigel suggested please.

Okay, this should solve it.
							Pavel

--- clean/mm/vmscan.c	2004-05-20 23:08:37.000000000 +0200
+++ linux/mm/vmscan.c	2004-05-30 21:45:41.000000000 +0200
@@ -1098,10 +1098,13 @@
 	pg_data_t *pgdat;
 	int nr_to_free = nr_pages;
 	int ret = 0;
+	int old_swappiness = vm_swappiness;
 	struct reclaim_state reclaim_state = {
 		.reclaimed_slab = 0,
 	};
 
+	vm_swappiness = 100;
+
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
@@ -1115,6 +1118,8 @@
 			break;
 	}
 	current->reclaim_state = NULL;
+
+	vm_swappiness = old_swappiness;
 	return ret;
 }
 #endif

--=-Sipj/sSkH+Y8jKHe2ExZ--

