Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVBBCMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVBBCMQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVBBCMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:12:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:23480 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262205AbVBBCMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:12:01 -0500
Subject: Error reporting API, any work in progress ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 13:11:43 +1100
Message-Id: <1107310304.5624.56.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Is there any work in progress to get some unified error reporting (and
possibly recovery) API for PCI/X/e ?

On pSeries, we have this "EEH" mecanism that allows us, even with
old-style PCI, to get error notification, but also to recover by doing
slot reset and that sort of stuff.

PCI Express has error reporting at least, IBM's implementation will have
similar reset control for recovery.

So I think we should need some generic error reporting capability to be
added to the PCI layer, possibly by adding a function pointer to
pci_driver() that gets called back to report various events, in addition
to the proposed explicit error checking that can bracket IO calls like
it was discussed a while ago on lkml.

In addition, I was thinking about some generic routines the drivers
could call to indicate, upon such errors, that they are willing to
recover after a slot reset. That way, the platform can notify all
drivers of a bus segment that went off, reset the slot, and send
messages to those drivers telling them the slot is back.

If there is already some work in progress for that (PCI driver-level API
for notification), I'd be happy to help there. If not, then I'll propose
something that would fit the need of IBM EEH mecanism and PCI express.

Ben.


