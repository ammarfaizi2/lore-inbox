Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265822AbTFVUAz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 16:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbTFVUAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 16:00:55 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:56862 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265822AbTFVUAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 16:00:54 -0400
Date: Sun, 22 Jun 2003 13:15:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alex Goddard <agoddard@purdue.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.73
Message-Id: <20030622131526.0dbb39d0.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.56.0306221453010.1455@dust>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
	<Pine.LNX.4.56.0306221453010.1455@dust>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 20:14:59.0874 (UTC) FILETIME=[F4EE4020:01C338FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Goddard <agoddard@purdue.edu> wrote:
>
> drivers/usb/host/ehci-hcd.c:977: error: pci_ids causes a section type 
> conflict


Yup.

__devinitdata declarations should not be marked const.


--- 25/drivers/usb/host/ehci-hcd.c~ehci_hcd-linkage-fix	2003-06-18 21:48:15.000000000 -0700
+++ 25-akpm/drivers/usb/host/ehci-hcd.c	2003-06-18 21:50:06.000000000 -0700
@@ -974,7 +974,7 @@ static const struct hc_driver ehci_drive
 /* EHCI spec says PCI is required. */
 
 /* PCI driver selection metadata; PCI hotplugging uses this */
-static const struct pci_device_id __devinitdata pci_ids [] = { {
+static struct pci_device_id __devinitdata pci_ids [] = { {
 
 	/* handle any USB 2.0 EHCI controller */
 

_

