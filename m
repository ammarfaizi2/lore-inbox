Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVCKWp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVCKWp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVCKWo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:44:26 -0500
Received: from ozlabs.org ([203.10.76.45]:63139 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261726AbVCKWme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:42:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16946.7941.404582.764637@cargo.ozlabs.ibm.com>
Date: Sat, 12 Mar 2005 09:43:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: AGP bogosities
In-Reply-To: <1110563965.4822.22.camel@eeyore>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<200503102002.47645.jbarnes@engr.sgi.com>
	<1110515459.32556.346.camel@gaston>
	<200503110839.15995.jbarnes@engr.sgi.com>
	<1110563965.4822.22.camel@eeyore>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas writes:

> HP ia64 and parisc boxes are similar.  The host bridges do not appear
> as PCI devices.  We discover them via ACPI on ia64 and PDC on parisc.

On PPC/PPC64 machines, the host bridges generally do not appear as PCI
devices either.  *However*, the AGP spec requires a set of registers
in PCI config space for controlling the target (host) side of the AGP
bus.  In other words you are required to have a PCI device to
represent the host side of the AGP bus, with a capability structure in
its config space which contains the standard AGP registers.

The lspci that was posted showed no such device, which was why Ben was
querying it.  Maybe your systems aren't fully AGP-compliant, in which
case much of the generic code won't be usable on your systems.

Paul.
