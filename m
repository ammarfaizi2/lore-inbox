Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUIOVsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUIOVsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIOVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:46:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31701 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267595AbUIOVor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:44:47 -0400
Date: Wed, 15 Sep 2004 23:45:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040915214550.GA30140@elte.hu>
References: <20040915125356.GA11250@elte.hu> <20040915143355.11ef40bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915143355.11ef40bf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > +		if (c == ' ' && !memcmp(from, "vmalloc=", 8))
> > +			__VMALLOC_RESERVE = memparse(from+8, &from);
> 
> u o akpm an update to kernel-parameters.txt, please.

here you go:

--- Documentation/kernel-parameters.txt.orig
+++ Documentation/kernel-parameters.txt
@@ -453,6 +453,11 @@ running once the system is up.
 	hd?=		[HW] (E)IDE subsystem
 	hd?lun=		See Documentation/ide.txt.
 
+	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
+			size of <nn>. This works even on boxes that have no
+			highmem otherwise. This also works to reduce highmem
+			size on bigger boxes.
+
 	hisax=		[HW,ISDN]
 			See Documentation/isdn/README.HiSax.
 
@@ -1280,6 +1285,12 @@ running once the system is up.
 			This is actually a boot loader parameter; the value is
 			passed to the kernel using a special protocol.
 
+	vmalloc=nn[KMG]	[KNL,BOOT] forces the vmalloc area to have an exact
+			size of <nn>. This can be used to increase the
+			minimum size (128MB on x86). It can also be used to
+			decrease the size and leave more room for directly
+			mapped kernel RAM.
+
 	vmhalt=		[KNL,S390]
 
 	vmpoff=		[KNL,S390] 
