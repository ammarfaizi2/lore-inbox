Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbUKWHIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUKWHIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUKWHIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:08:30 -0500
Received: from fmr14.intel.com ([192.55.52.68]:913 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262235AbUKWHI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:08:26 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stian Jordet <stian_web@jordet.nu>
In-Reply-To: <Pine.LNX.4.58.0411222048120.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de>
	 <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
	 <1101151780.20006.69.camel@d845pe>
	 <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
	 <1101155893.20007.125.camel@d845pe>
	 <Pine.LNX.4.58.0411221815460.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411222048120.20993@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1101193585.20006.533.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Nov 2004 02:06:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 23:57, Linus Torvalds wrote:
> 
> On Mon, 22 Nov 2004, Linus Torvalds wrote:
> >

> Len, how about this patch - it re-enables the link disable and then
> re-codes the ELCR setting to match.
> 
> Basically it just computes the new ELCR: if acpi_noirq is set, it
> leaves it at the old value, otherwise it zeroes it - and in both cases
> it fixes the SCI entry.

> Your argument for doing this ended up being convincing, so the only
> difference between this and your debug patch is really just the
> obvious organizational ones, and the test for "acpi_noirq", which I
> think is needed (since if acpi_noirq is set, we're not going to
> disable and re-enable the PCI interrupts, so we'll just have to trust
> ELCR).

I think your use of acpi_noirq in acpi_pic_sci_set_trigger() was clever
-- maybe more clever than the name of the routine suggests -- but it
looks correct.

thanks for restoring pci_link.c

-Len


