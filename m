Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUBYQYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUBYQYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:24:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17070 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261416AbUBYQWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:22:42 -0500
Subject: Re: new driver (hvcs) review request and sysfs questions
From: Dave Hansen <haveblue@us.ibm.com>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, greg@kroah.com,
       boutcher@us.ibm.com, rsa@us.ibm.com,
       Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com>
References: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com>
Content-Type: text/plain
Message-Id: <1077726152.22018.403.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 08:22:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- pristine/linux-2.5/drivers/char/hvcs.c	...
+++ working/linux-2.5/drivers/char/hvcs.c	...

It's standard practice to create patches so that they apply with -p1. 
See Documentation/SubmittingPatches

Don't just indiscriminately run lindent.  It makes the code look awful
in some spots.  Remember that it's OK to exceed 80 columns in some
places, especially with things like function declarations.

in hvcs_write():

	count = min(count, (int)PAGE_SIZE);

assumes that count and PAGE_SIZE are in the same units: bytes.  If
that's true, no need for the sizeof() here:

charbuf = kmalloc(sizeof(unsigned char *) * count,  GFP_KERNEL);

hvcs_next_partner() shares code with lparcfg_write() and a bunch of the
other hypervisor calls.  Can you combine them with a function that just
checks the return codes from hcalls?  All of those switches look
redundant.   

hvcs_get_partner_info() is a bit long.  Can that while loop go into its
own function?

-- dave

