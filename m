Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUCPVGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUCPVGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:06:06 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:28816 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261498AbUCPVGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:06:04 -0500
Date: Tue, 16 Mar 2004 21:05:40 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fix ppc compile
Message-ID: <20040316210540.GD24623@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.5rc1 changes this function, but there is no 'dev' argument there.
This makes it look a little more sane, but I've no hardware to test it on.

		Dave

--- linux-2.6.4/arch/ppc/syslib/indirect_pci.c~	2004-03-16 21:03:20.000000000 +0000
+++ linux-2.6.4/arch/ppc/syslib/indirect_pci.c	2004-03-16 21:03:31.000000000 +0000
@@ -44,8 +44,8 @@
 			cfg_type = 1;
 
 	PCI_CFG_OUT(hose->cfg_addr, 					 
-		 (0x80000000 | ((dev->bus->number - hose->bus_offset) << 16) 
-		  | (dev->devfn << 8) | ((offset & 0xfc) | cfg_type)));	
+		 (0x80000000 | ((bus->number - hose->bus_offset) << 16) 
+		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));	
 
 	/*
 	 * Note: the caller has already checked that offset is
