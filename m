Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUGCP6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUGCP6W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 11:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUGCP6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 11:58:22 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:32902 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S265141AbUGCP6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 11:58:20 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 03 Jul 2004 16:58:16 +0100
Message-Id: <1088870296.3733.29.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: yenta_socket dies on rewriting configuration registers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 19:40:56 +0100)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.7 on a Thinkpad 240X, if I allow the PCI registers on my
cardbus bridge to be rewritten after ACPI resume, the system dies with
slightly strange symptoms. Every other character of kernel messages is
written, with blank spaces in between. After a few lines of message, the
system stops. If I do a resume with an unpatched kernel, it appears to
get through to thawing processes before hanging - if I put debug
statements in the resume path, it hangs within device_resume. I get this
behaviour even if the yenta_socket driver is not loaded due to the
generic 2.6.7 resume code. Commenting out both calls to
pci_restore_state (from the driver itself and from the generic PCI code)
results in suspend working correctly. The bridge is a Texas Instruments
PCI1211.

The driver works correctly with my Thinkpad X40, which has a Ricoh
RL5c476 II
-- 
Matthew Garrett | mjg59@srcf.ucam.org

