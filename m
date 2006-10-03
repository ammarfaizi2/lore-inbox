Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWJCBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWJCBQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWJCBQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:16:31 -0400
Received: from ozlabs.org ([203.10.76.45]:47746 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030217AbWJCBQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:16:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17697.47589.788457.877617@cargo.ozlabs.ibm.com>
Date: Tue, 3 Oct 2006 11:16:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: Undefined '.bus_to_virt',
	'.virt_to_bus' causes compile error on Powerpc 64-bit
In-Reply-To: <20061002214954.GD665@shell0.pdx.osdl.net>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judith,

> For the automated cross-compile builds at OSDL, powerpc 64-bit 
> 'allmodconfig' is failing.  The warnings/errors below appear in 
> the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.

virt_to_bus and bus_to_virt are old interfaces that have been
deprecated for, oh, at least 5 years now, and can't be implemented
sanely on machines with an IOMMU - which includes all 64-bit powerpc
machines.

Unless someone pops up and volunteers to fix those old drivers, which
is unlikely, the only solution is to fix the Kconfig files to prevent
them from being selected on platforms that don't have virt_to_bus and
bus_to_virt.

Paul.
