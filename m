Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262028AbSJDUtv>; Fri, 4 Oct 2002 16:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSJDUtu>; Fri, 4 Oct 2002 16:49:50 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:42255 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262028AbSJDUts>;
	Fri, 4 Oct 2002 16:49:48 -0400
Date: Fri, 4 Oct 2002 13:52:23 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004205222.GB8346@kroah.com>
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004205121.GA8346@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.674.3.3 -> 1.674.3.4
#	drivers/char/rocket.c	1.12    -> 1.13   
#	drivers/scsi/inia100.c	1.10    -> 1.11   
#	 drivers/sbus/sbus.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	greg@kroah.com	1.674.3.4
# PCI: fixed remaining usages of pcibios_present() that I missed previously.
# --------------------------------------------
#
diff -Nru a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c	Fri Oct  4 13:47:29 2002
+++ b/drivers/char/rocket.c	Fri Oct  4 13:47:29 2002
@@ -1993,7 +1993,7 @@
 			isa_boards_found++;
 	}
 #ifdef CONFIG_PCI
-	if (pcibios_present()) {
+	if (pci_present()) {
 		if(isa_boards_found < NUM_BOARDS)
 			pci_boards_found = init_PCI(isa_boards_found);
 	} else {
diff -Nru a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
--- a/drivers/sbus/sbus.c	Fri Oct  4 13:47:29 2002
+++ b/drivers/sbus/sbus.c	Fri Oct  4 13:47:29 2002
@@ -312,7 +312,7 @@
 		nd = prom_searchsiblings(topnd, "sbus");
 		if(nd == 0) {
 #ifdef CONFIG_PCI
-			if (!pcibios_present()) {	
+			if (!pci_present()) {
 				prom_printf("Neither SBUS nor PCI found.\n");
 				prom_halt();
 			} else {
diff -Nru a/drivers/scsi/inia100.c b/drivers/scsi/inia100.c
--- a/drivers/scsi/inia100.c	Fri Oct  4 13:47:29 2002
+++ b/drivers/scsi/inia100.c	Fri Oct  4 13:47:29 2002
@@ -208,7 +208,7 @@
 	/*
 	 * PCI-bus probe.
 	 */
-	if (pcibios_present()) {
+	if (pci_present()) {
 		/*
 		 * Note: I removed the struct pci_device_list stuff since this
 		 * driver only cares about one device ID.  If that changes in
