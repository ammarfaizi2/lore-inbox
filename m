Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbTI3VVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTI3VU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:20:59 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:8954 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S261770AbTI3VU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:20:57 -0400
Subject: Re: 2.6.0-test6: a few __init bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030930191117.GA20054@kroah.com>
References: <1064872693.5733.42.camel@dooby.cs.berkeley.edu>
	<20030929221113.GB2720@kroah.com>
	<1064946634.5734.106.camel@dooby.cs.berkeley.edu> 
	<20030930191117.GA20054@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Sep 2003 14:20:53 -0700
Message-Id: <1064956854.5733.233.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 12:11, Greg KH wrote:
> Hm, care to send in a patch that adds a comment to that __init call so
> that others don't make the same mistake in a year or so?

Here's the patch you requested, but I recommend against applying it
since it's the sort of comment that can easily become wrong, leading to
missed bugs in future kernels.  Thanks again for your help.

Best,
Rob

--- drivers/pci/quirks.c.orig	Tue Sep 30 14:17:40 2003
+++ drivers/pci/quirks.c	Tue Sep 30 14:16:57 2003
@@ -869,6 +869,9 @@
 
 void pci_fixup_device(int pass, struct pci_dev *dev)
 {
+	/* Note: Many of the hooks in pci_fixups are declared __init
+           or __devinit, but this is ok because, currently, none of
+           the devices with quirk hooks are hot-pluggable. */
 	pci_do_fixups(dev, pass, pcibios_fixups);
 	pci_do_fixups(dev, pass, pci_fixups);
 }


