Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUHCFej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUHCFej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 01:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUHCFej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 01:34:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12445 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264953AbUHCFei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 01:34:38 -0400
Subject: struct pci_bus, no release() function?
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <gregkh@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1091477728.23381.24.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 15:15:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At probe time, pci_scan_bus_parented() allocates and registers a struct
device for each PCI bus it scans.  This generic device structure never
gets assigned a "release" function.  

Attempts to unregister such a PCI Bus at runtime result in a kernel
message like:
Device 'pci0001:00' does not have a release() function, it is broken and
must be fixed.

Are architectures free to assign their own release function for
"devices" associated with struct pci_bus?  If so, does this have to
happen at boot, or can it happen right before the remove?

Thanks-
John

