Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSJJVpb>; Thu, 10 Oct 2002 17:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSJJVpa>; Thu, 10 Oct 2002 17:45:30 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:31246 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262410AbSJJVoM>;
	Thu, 10 Oct 2002 17:44:12 -0400
Date: Thu, 10 Oct 2002 14:45:49 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug fixes for 2.4.20-pre10
Message-ID: <20021010214549.GC27523@kroah.com>
References: <20021010214455.GA27523@kroah.com> <20021010214527.GB27523@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010214527.GB27523@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.738   -> 1.739  
#	drivers/hotplug/cpqphp_pci.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	Dan.Zink@hp.com	1.739
# [PATCH] Compaq PCI Hotplug bug fix 2
# 
# Your patch may fix the issue, but I think there is an
# easier way.  I found another bug that was preventing the
# existing scheme from working.  It looks like the function
# "pcibios_set_irq_routing" is returning 1 for success, but
# the hot plug driver was interpreting it as failure.
# 
# The attached 2 line patch fixes it for me.  I am able to
# add an Intel NIC on an ML370 G2 and receive interrupts from
# it.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Thu Oct 10 14:44:42 2002
+++ b/drivers/hotplug/cpqphp_pci.c	Thu Oct 10 14:44:42 2002
@@ -358,8 +358,8 @@
 	    dev_num, bus_num, int_pin, irq_num);
 	rc = pcibios_set_irq_routing(&fakedev, int_pin - 0x0a, irq_num);
 	dbg(__FUNCTION__":rc %d\n", rc);
-	if (rc)
-		return rc;
+	if (!rc)
+		return !rc;
 
 	// set the Edge Level Control Register (ELCR)
 	temp_word = inb(0x4d0);
