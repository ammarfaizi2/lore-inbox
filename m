Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVBWBbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVBWBbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 20:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVBWBbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 20:31:13 -0500
Received: from it4systems-kln-gw.de.clara.net ([212.6.222.118]:29529 "EHLO
	frankbuss.de") by vger.kernel.org with ESMTP id S261381AbVBWBbH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 20:31:07 -0500
From: "Frank Buss" <fb@frank-buss.de>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Cc: <rmk+lkml@arm.linux.org.uk>
Subject: 
Date: Wed, 23 Feb 2005 02:31:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcUZR1eJK15ELao0TDWR9vDxj7TZZQ==
Message-Id: <20050223013106.473AF5B8AD@frankbuss.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Since we map the whole lot in one go, if you get one page, there's no
> reason why you shouldn't get the lot.  This is why I'm wondering if
> it has something to do with your other modifications.

my colleage has found the bug: in the function dma_mmap in
arch/arm/mm/consistent.c the call to remap_pfn_range uses user_size in
PAGE_SIZE units, but looks like it is expected in bytes. When using
(user_size << PAGE_SHIFT), it works.

I don't know, where to fix it: Should the lower level calls get the size in
bytes (most function arguments in Linux kernel sources are not commented),
this means fixing the dma_mmap, or should PAGE_SIZE be used, then the lower
level functions needs to be fixed.

-- 
Frank Buß, fb@frank-buss.de
http://www.frank-buss.de, http://www.it4-systems.de

