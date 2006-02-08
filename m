Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWBHW0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWBHW0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWBHW0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:26:00 -0500
Received: from fmr22.intel.com ([143.183.121.14]:4490 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964916AbWBHWZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:25:59 -0500
Message-Id: <200602082224.k18MOpg24612@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adrian Bunk'" <bunk@stusta.de>, "Jes Sorensen" <jes@sgi.com>
Cc: "'Keith Owens'" <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
Date: Wed, 8 Feb 2006 14:24:51 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYs+DS9IqDfRJRpTDukxy/9UEr1FwABMOUw
In-Reply-To: <20060208213825.GQ3524@stusta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote on Wednesday, February 08, 2006 1:38 PM
> > Not really, it helps a bit by selecting some things we know we need
> > for all GENERIC builds. True we can't make it bullet proof, but whats
> > there is better than removing it.
> 
> Like the bug of allowing the illegal configuration NUMA=y, FLATMEM=y?


You can't even compile a kernel with that combination ...
Just about every arch except ia64 turns off ARCH_FLATMEM_ENABLE if NUMA=y.
ia64 can just do the same thing.  Instead of mucking around with select,
fix the bug at its source. The real culprit is in mm/Kconfig, it shouldn't
enable ARCH_FLATMEM_ENABLE if NUMA=y.



Fix ARCH_FLATMEM_ENABLE dependency in ia64 arch.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./arch/ia64/Kconfig.orig	2006-02-08 14:57:40.597354431 -0800
+++ ./arch/ia64/Kconfig	2006-02-08 15:04:15.552427718 -0800
@@ -298,7 +298,8 @@ config ARCH_DISCONTIGMEM_ENABLE
  	  See <file:Documentation/vm/numa> for more.
 
 config ARCH_FLATMEM_ENABLE
-	def_bool y
+	depends on !NUMA
+	def_bool y if !NUMA
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y


