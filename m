Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270643AbTGNOzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270446AbTGNOxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:53:43 -0400
Received: from stud.tb.fh-muenchen.de ([129.187.138.35]:59832 "HELO
	stud.fh-muenchen.de") by vger.kernel.org with SMTP id S270631AbTGNOws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:52:48 -0400
Subject: 2.6.0-test1: include/linux/pci.h inconsistency?
From: Lars Duesing <ld@stud.fh-muenchen.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: University of Applied Sciences, Students Council
Message-Id: <1058195165.4131.6.camel@ws1.intern.stud.fh-muenchen.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 14 Jul 2003 17:06:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people!
After having problems compiling nforce2-drivers for 2.6.0-test1, I had a
look after include/linux/pci.h.
There is some inconsistency in there:

   pci_driver->driver_data is not there any more BUT in pci_dynids it is
referenced:

       unsigned int use_driver_data:1; /* pci_driver->driver_data is
used */

attached a dirty patch:


diff -u linux-2.6.0-test1/include/linux/pci.h
linux-2.6.0-test1.new/include/linux/pci.h
--- linux-2.6.0-test1/include/linux/pci.h       2003-07-14
05:34:02.000000000 +0200
+++ linux-2.6.0-test1.new/include/linux/pci.h   2003-07-14
16:48:30.000000000 +0200
@@ -501,7 +501,7 @@
 struct pci_dynids {
        spinlock_t lock;            /* protects list, index */
        struct list_head list;      /* for IDs added at runtime */
-       unsigned int use_driver_data:1; /* pci_driver->driver_data is
used */
+       unsigned int use_driver_data:0; /* pci_driver->driver_data is
NOT there any more */
 };


btw: this driver_data is used by the networking part of the
nforce2-driver. If anybody knows a hint, tell me. 
Else I will try to wake up someone at nvidia.

Greetings,

      Lars Duesing
	Munich University Of Applied Sciences, Students' Council

