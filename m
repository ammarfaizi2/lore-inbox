Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUC1MZA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUC1MZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:25:00 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:64777 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261654AbUC1MY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:24:57 -0500
Date: Sun, 28 Mar 2004 14:24:47 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, dahinds@users.sourceforge.net
Subject: [PATCH-2.4.26] cardbus cleanup
Message-ID: <20040328122447.GF24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

in cardbus.c, cb_scan_slot() calls pci_scan_device() which is
undefined. Since it does not appear in any include, I added an
external reference to it in the file to kill the warning.

Please apply.
Willy

--- ./drivers/pcmcia/cardbus.c.orig	Sun Mar 28 13:57:34 2004
+++ ./drivers/pcmcia/cardbus.c	Sun Mar 28 13:59:24 2004
@@ -221,6 +221,8 @@
 	return -1;
 }
 
+extern struct pci_dev * __devinit pci_scan_device(struct pci_dev *temp);
+
 struct pci_dev *cb_scan_slot(struct pci_dev *temp, struct list_head *list)
 {
 	struct pci_dev *dev;

