Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVHJNHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVHJNHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVHJNHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:07:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59107 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965093AbVHJNHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:07:21 -0400
Date: Wed, 10 Aug 2005 06:07:09 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linus Torvalds <torvalds@osdl.org>, kiran@scalex86.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ide-disk.c oops caused by hwif == NULL
In-Reply-To: <Pine.LNX.4.62.0508101310300.18940@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.62.0508100604020.12126@schroedinger.engr.sgi.com>
References: <200508100459.j7A4xTn7016128@hera.kernel.org>
 <Pine.LNX.4.62.0508101310300.18940@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Geert Uytterhoeven wrote:

> On Tue, 9 Aug 2005, Linux Kernel Mailing List wrote:
> > tree 518f62158f0923573decb8f072ac7282fb7575cb
> > parent aeb3f76350e78aba90653b563de6677b442d21d6
> > author Christoph Lameter <christoph@lameter.com> Wed, 10 Aug 2005 09:59:21 -0700
> > committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 10 Aug 2005 10:21:31 -0700
> > 
> > [PATCH] Fix ide-disk.c oops caused by hwif == NULL
> 
> How can this patch fix that? It still dereferences hwif without checking for a
> NULL pointer.

Correct. So we need to indeed go back to a version that does check for 
NULL that I initially proposed.

Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h	2005-08-09 19:47:14.000000000 -0700
+++ linux-2.6/include/linux/ide.h	2005-08-10 06:05:44.000000000 -0700
@@ -1503,7 +1503,7 @@
 
 static inline int hwif_to_node(ide_hwif_t *hwif)
 {
-	if (hwif->pci_dev)
+	if (hwif && hwif->pci_dev)
 		return pcibus_to_node(hwif->pci_dev->bus);
 	else
 		/* Add ways to determine the node of other busses here */
