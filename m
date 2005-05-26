Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVEZEIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVEZEIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 00:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVEZEIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 00:08:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:27624 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261189AbVEZEH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 00:07:59 -0400
Subject: [RFC] Changing pci_iounmap to take 'bar' argument
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:07:34 +1000
Message-Id: <1117080454.9076.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On ppc and ppc64 platforms, pci_iounmap() currently does nothing, which
is bogus (leak of ioremap space for mmio). It needs to iounmap for MMIOs
and do nothign for IO space.

The problem is that wether it's IO or MMIO cannot be easily deduced from
the virtual address. We _could_ change the whole thing on ppc32 to play
tricks with the top address bits, and we could compare the virtual
address with the known regions containing PHBs IO space, but that sounds
to me like working around a bad API in the first place.

What about, instead, just adding the "int bar" argument to pci_iounmap()
like we pass to pci_iomap() so it can access the resource flags ?

If it's ok with you, I'll send a patch doing it later today.

Ben.


