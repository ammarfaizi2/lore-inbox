Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVBNU04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVBNU04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVBNU04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:26:56 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:6822 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261560AbVBNU0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:26:54 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 14 Feb 2005 20:26:09 +0000
Message-Id: <1108412769.4085.119.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Video cards and PCI power states
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radeons need certain registers set in order to power down fully when set
to D3 state. This support has been added to radeonfb, but it would be
nice to be able to support this with text consoles as well. I've written
a small userspace application that sets the registers correctly, but the
device still needs to be put into D3 during suspend. The kernel won't do
this as no module is loaded to claim the device. In theory, it's
possible to do this from userspace. I've written an app to set a device
to D3 state, and it seems to work in most cases. 

However, if I try to run it against a Radeon in a Thinkpad, the device
seems to power itself back up again immediately. A similar effect can be
produced if I provide a dummy module that does nothing other than bind
to the device and provide suspend and resume functions - echo -n 3
>power/state doesn't actually seem to power the device down. However,
this module /is/ sufficient to power it down correctly on suspend.

Does anyone know why it appears impossible to power down the device
while the system is running, while doing so during suspend results in
correct functionality? 
-- 
Matthew Garrett | mjg59@srcf.ucam.org

