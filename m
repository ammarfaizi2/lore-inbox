Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVH3Eie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVH3Eie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVH3Eie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:38:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:25558 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932120AbVH3Eid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:38:33 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no
In-Reply-To: <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
References: <200508261859.j7QIxT0I016917@hera.kernel.org>
	 <1125369485.11949.27.camel@gaston> <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 14:33:51 +1000
Message-Id: <1125376431.11949.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What you want is a "zombie state", where we write the partial information 
> to hardware. It's what we used to do, but it's certainly no more logical 
> than what it does now, and it led to problem reports.
> 
> Btw, why does this happen on powerpc, but not x86? I'm running a radeon 
> laptop right now myself. Hmm..

It's using the RAM shadow at c0000 on these ...

I'm still not convinced that having the struct resource allocated and
mismatched with the BAR value is a good thing... But anyway, so the bug
would then be pci_map_rom who is writing the enable bit without fixing
the rest of the BAR...

So what about fixing pci_map_rom() to call pcibios_resource_to_bus() and
then write the resource back to the BAR ? I'm still a bit annoyed that
we re-allocate the address while the original one was perfectly good
(though not enabled) but the above would work.

Ben.


