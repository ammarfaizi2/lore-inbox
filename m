Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTFYXVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264612AbTFYXVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:21:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53438 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264494AbTFYXVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:21:16 -0400
Date: Thu, 26 Jun 2003 00:35:25 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] pci_name()
Message-ID: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd kind of like to get rid of pci_dev->slot_name.  It's redundant with
pci_dev->dev.bus_id, but that's one hell of a search and replace job.
So let me propose pci_name(pci_dev) as a replacement.  That has the
benefit of being shorter than either of the others and lets us do fun
& interesting things later (maybe construct it on the fly for systems
that want to save 20 bytes per device?).  We can transition it in over
2.5/2.6/2.7 and kill pci_dev->slot_name for 2.8.

Oh, and without killing slot_name immediately, we can save 4 bytes on
32-bit platforms by turning it into a pointer to the dev.bus_id.

Comments?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
