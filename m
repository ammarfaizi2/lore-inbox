Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUCVFBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 00:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUCVFBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 00:01:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:36585 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261717AbUCVFBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 00:01:08 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jaroslav Kysela <perex@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403201920560.28447@montezuma.fsmlabs.com>
References: <20040320133025.GH9009@dualathlon.random>
	 <20040320144022.GC2045@holomorphy.com>
	 <20040320150621.GO9009@dualathlon.random>
	 <20040320154419.A6726@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz>
	 <20040320160911.B6726@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz>
	 <20040320222341.J6726@flint.arm.linux.org.uk>
	 <20040320224518.GQ2045@holomorphy.com>
	 <20040320235445.B24744@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403201920560.28447@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1079930812.900.180.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 15:46:52 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Doesn't DRI also suffer from the same issues?

Well, it depends. Most of the time, DRI uses AGP which is a different
story altogether.

DRI suffers from similar issue when using PCI GART, but then, it also
doesn't use the consistent alloc routines, it gets pages with GFP,
mmap those into userland, and does pci_map_single in the kernel on
each individual page to obtain the bus addresses. This will not be
pretty on non-coherent architectures though.

Ben.


