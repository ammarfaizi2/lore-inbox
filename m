Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265131AbUF1TFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265131AbUF1TFX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbUF1TFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:05:23 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:9674 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S265131AbUF1TFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:05:10 -0400
Date: Mon, 28 Jun 2004 14:04:37 -0500 (CDT)
From: Pat Gefre <pfg@sgi.com>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
In-Reply-To: <Pine.SGI.4.53.0406280719080.581376@subway.americas.sgi.com>
Message-ID: <Pine.SGI.3.96.1040628140341.36430F-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

We think we should stick with the major/minor set we have proposed.  We
don't like hacking the 8250 code, dynamic allocation doesn't work (once
that works we will update our driver to use it), registering for our
own major/minor may not work (if we DO get one we will update the
driver to reflect it) but in the meantime we need to get something in
the community that works.

-- Pat





On Mon, 28 Jun 2004, Erik Jacobson wrote:

+ > If you're going to do that, why not just disable 8250 in the kernels
+ > configuration?  It has exactly the same effect.  With the change you
+ > propose, you can't even use 8250 for PCMCIA serial cards.
+ 
+ I know this was touched on - but just to confirm.  We need to be able to
+ work with standard distributions.
+ 
+ Regarding the "hack" to 8250.c - in fact, I put something very similar in
+ so I could test the driver out in some ways internally.  It does work.
+ 
+ What would really just solve the problem, in my opinion, is if we could
+ simply get our major/minor registered.  Then everybody wins, right?
+ 
+ In 2.6.7, someone changed kernel/setup.c that made things worse for us
+ with our CURRENT char/sn_serial.c driver.  This might be what was mentioned
+ in this thread earlier.
+ 
+ Bad things happen when 8250 is in the kernel and then our CURRENT
+ char/sn_serial driver is also in the kernel as of 2.6.7.  Our fix for
+ that issue was to put back this line (see below).
+ 
+ We were hoping to not propose this as a patch and just have our NEW console
+ driver get in.
+ 
+ We're in a really bad spot now where, as of 2.6.7, our old driver doesn't
+ work any more due to the setup.c change and our new driver is getting
+ resistance - mostly due to lack of registered major/minor.
+ 
+ Here is the fix for the CURRENT driver.  I think we might need to propose
+ that this change be put back in the kernel if it doesn't look like our
+ NEW driver (serial/sn_console) will be accepted.  But having this fix
+ in place does not help us with the problem we're trying to solve with the
+ NEW driver.  It just makes it so we at least have something that works.
+ 
+ Index: linux/arch/ia64/kernel/setup.c
+ ===================================================================
+ --- linux.orig/arch/ia64/kernel/setup.c 2004-06-15 11:01:24.000000000 -0500
+ +++ linux/arch/ia64/kernel/setup.c      2004-06-15 12:02:31.000000000 -0500
+ @@ -333,7 +333,7 @@ setup_arch (char **cmdline_p)
+  #endif
+         {
+                 extern unsigned char acpi_legacy_devices;
+ -               if (!efi.hcdp)
+ +               if (!efi.hcdp && !ia64_platform_is("sn2"))
+                         setup_serial_legacy();
+         }
+  #endif
+ 
+ 
+ --
+ Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
+ 


