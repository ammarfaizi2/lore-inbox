Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161182AbVIPQmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbVIPQmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 12:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbVIPQmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 12:42:55 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59797 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161182AbVIPQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 12:42:54 -0400
Date: Fri, 16 Sep 2005 12:42:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Unusually long delay in the kernel
Message-ID: <Pine.LNX.4.44L0.0509161236440.4523-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code excerpt is taken from the start of the control thread for the 
usb-storage driver in 2.6.14-rc1:


static int usb_stor_control_thread(void * __us)
{
	struct us_data *us = (struct us_data *)__us;
	struct Scsi_Host *host = us_to_host(us);

printk(KERN_INFO "Before thread start\n");
	lock_kernel();

	/*
	 * This thread doesn't need any user-level access,
	 * so get rid of all our resources.
	 */
	daemonize("usb-storage");
	current->flags |= PF_NOFREEZE;
	unlock_kernel();
printk(KERN_INFO "After thread start\n");


The code between the two printk's takes a long time to run.  I don't have 
precise numbers, but it feels like more than 1 second.

(1) Can anyone explain why, or indicate how to speed it up?

(2) Are the {un}lock_kernel calls really needed?

Thanks,

Alan Stern

