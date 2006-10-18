Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWJROiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWJROiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWJROiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:38:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:16146 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161043AbWJROiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:38:21 -0400
Date: Wed, 18 Oct 2006 10:38:20 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Brian King <brking@us.ibm.com>
cc: Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, Adam Belay <abelay@MIT.EDU>
Subject: Re: [linux-pm] [PATCH] Block on access to temporarily unavailable
 pci device
In-Reply-To: <45354A59.3010109@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610181035140.6766-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006, Brian King wrote:

> Nack. This changes pci_block_user_cfg_access such that it can now sleep,
> which does not work for the ipr driver, which uses it to block during BIST.
> The ipr driver needs to be able to call this function at interrupt level
> when it receives an interrupt that its scsi adapter has received a fatal
> error and requires BIST to recover. The only way I see for ipr to be able
> to use the changed interface would require I create a kernel thread in
> the ipr driver for this specific purpose.

How about calling execute_in_process_context()?

You have to do _something_, because a user task could be about to read the
configuration space at the exact moment you want to start the BIST.  That
means ipr would have to wait until the user access is finished, which
means it has to be prepared to sleep one way or another.

Alan Stern

