Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTISTVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbTISTVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:21:54 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:3978 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261707AbTISTVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:21:52 -0400
Message-ID: <3F6B5897.3070407@pacbell.net>
Date: Fri, 19 Sep 2003 12:27:19 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, jtholmes <jtholmes@jtholmes.com>
CC: linux-kernel@vger.kernel.org, jtholmesjr@comcast.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: irq 11: nobody cared! is back
References: <3F6B0671.1070603@jtholmes.com> <20030919190856.GJ6624@kroah.com>
In-Reply-To: <20030919190856.GJ6624@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------070906010505050805090504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070906010505050805090504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

> Hm, can you apply this patch with -R and see if it fixes your problem?
> 

Or this one _without_ "-R".


--------------070906010505050805090504
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.44/drivers/usb/host/uhci-hcd.c	Fri Jul 18 06:22:32 2003
+++ edited/drivers/usb/host/uhci-hcd.c	Fri Sep 19 12:23:54 2003
@@ -1960,8 +1960,9 @@
 {
 	unsigned int io_addr = uhci->io_addr;
 
-	/* Global reset for 50ms */
+	/* Global reset for 50ms, and don't interrupt me */
 	uhci->state = UHCI_RESET;
+	outw(0, io_addr + USBINTR);
 	outw(USBCMD_GRESET, io_addr + USBCMD);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout((HZ*50+999) / 1000);
@@ -2187,6 +2188,7 @@
 	/* Maybe kick BIOS off this hardware.  Then reset, so we won't get
 	 * interrupts from any previous setup.
 	 */
+	outw(0, uhci->io_addr + USBINTR);
 	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
 	reset_hc(uhci);
 	return 0;

--------------070906010505050805090504--

