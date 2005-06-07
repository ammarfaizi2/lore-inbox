Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVFGL4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVFGL4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVFGL4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:56:49 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:31685 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261838AbVFGL4m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:56:42 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Date: Tue, 07 Jun 2005 12:56:33 +0100
Message-Id: <1118145393.6648.232.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: yenta_socket: no PCI interrupts after resume if intel-agp loaded
	on HP 1105
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I boot a kernel without any modules loaded and then load intel-agp, I
can successfully suspend and resume this machine via ACPI. However, the
b44 module is then unable to determine its MAC address correctly, and
ipw2100 claims that it can't find a device. yenta_socket gives 

Yenta : Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x00001000, devctl 0x66
Yenta TI: socket 0000:02:06.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:02:06.0 falling back to parallel PCI interrupts
Yenta TI: socket 0000:02:06.0 no PCI interrupts. Fish. Please report.

The only output from the AGP driver is:

agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 32M @ 0xe2000000

If I have all of these drivers loaded at suspend, resume fails. Without
intel-agp, I can suspend and resume happily (well, X won't start after
resume, but that's potentially an entirely separate issue)
-- 
Matthew Garrett | mjg59@srcf.ucam.org

