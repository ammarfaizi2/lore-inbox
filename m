Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWFUMxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWFUMxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWFUMxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:53:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:28886 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750859AbWFUMxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:53:08 -0400
Subject: powerpc new irq remapper patches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1veqvb9tr.fsf@ebiederm.dsl.xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	 <11508425183073-git-send-email-ebiederm@xmission.com>
	 <11508425191381-git-send-email-ebiederm@xmission.com>
	 <11508425192220-git-send-email-ebiederm@xmission.com>
	 <11508425191063-git-send-email-ebiederm@xmission.com>
	 <1150842520235-git-send-email-ebiederm@xmission.com>
	 <11508425201406-git-send-email-ebiederm@xmission.com>
	 <1150842520775-git-send-email-ebiederm@xmission.com>
	 <11508425213394-git-send-email-ebiederm@xmission.com>
	 <115084252131-git-send-email-ebiederm@xmission.com>
	 <1150847764.1901.64.camel@localhost.localdomain>
	 <m1veqvb9tr.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 22:52:48 +1000
Message-Id: <1150894368.16303.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, here are some patches to look at. It's not complete yet but
it should give you an idea of where things are going.

At that url, you'll find a serie that applies on top of -mm 

http://gate.crashing.org/~benh/irq-WIP/

First set is just some random pending cell patches to make it boot on a
cell blade, and are irrelevant.

Then, there is a serie that ports almost all of arch/powerpc to genirq:

powerpc-use-generic_handle_irq.diff
powerpc-move-mpic-genirq.diff
powerpc-move-xics-genirq.diff
powerpc-move-8259-genirq.diff
powerpc-move-pmac-pic-genirq.diff
powerpc-move-iseries-genirq.diff
genirq-fasteoi-allow-retrigger.diff
powerpc-move-cell-genirq.diff

And then, the meat:

powerpc-add-irq-of-parsing.diff
powerpc-copy-i8259-to-ppc.diff
powerpc-add-irq-remapper-core.diff
powerpc-remove-old-of-parsing.diff
powerpc-fixup-legacy-serial.diff
powerpc-fixup-rtas-pci.diff
powerpc-fixup-hvsi.diff
powerpc-new-irq-port-xics.diff
powerpc-new-irq-port-i8259.diff
genirq-add-irq-type-mask.diff
powerpc-new-irq-port-mpic.diff
powerpc-new-irq-adapt-pseries.diff
powerpc-new-irq-adapt-iseries.diff

What you really want to look at is powerpc-add-irq-remapper-core.diff
which is the new irq remapping I was talking about.

The serie of patches is still very much WIP since as it is, only pseries
and iseries will build (the new core stuff breaks all powerpc platforms,
there is no way around that, and that patch serie only ports pseries and
iseries, still fixing up the other ones).

But at least it should give you a good idea of where things are going on
my side. Geoff: you should be able to start from there as you have no
dependency on any of the other platofrms PIC stuff.

Hopefully, I'll have a complete patch set that ports all of the powerpc
archs in a few days.

Cheers,
Ben.


