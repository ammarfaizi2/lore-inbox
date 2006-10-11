Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161252AbWJKUlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWJKUlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWJKUlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:41:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:4874 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161252AbWJKUlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:41:24 -0400
Date: Wed, 11 Oct 2006 16:41:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Bug in PCI core
Message-ID: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a PCI device is suspended, its driver calls pci_save_state() so that
the config space can be restored when the device is resumed.  Then the
driver calls pci_set_power_state().

However pci_set_power_state() calls pci_block_user_cfg_access(), and that 
routine calls pci_save_state() again.  This overwrites the saved state 
with data in which memory, I/O, and bus master accesses are disabled.  As 
a result, when the device is resumed it doesn't work.

Obviously pci_block_user_cfg_access() needs to be fixed.  I don't know the 
right way to fix it; hopefully somebody else does.

Alan Stern

