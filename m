Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271967AbTGYIou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 04:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271968AbTGYIou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 04:44:50 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:62226 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S271967AbTGYIoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 04:44:46 -0400
Date: Fri, 25 Jul 2003 11:01:23 +0200
From: Jerome Chantelauze <jerome.chantelauze@finix.eu.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre6-ac1
Message-ID: <20030725090123.GA18894@i486X33>
References: <200307181212.h6ICCQ925343@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307181212.h6ICCQ925343@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 08:12:26AM -0400, Alan Cox wrote:
> Took rather longer than planned but here we are:
> 
> Linux 2.4.22-pre6-ac1

Hi Alan

Linux 2.4.22-pre6-ac1 doesn't build with the option 
"Old hard disk (MFM/RLL/IDE) driver" (CONFIG_BLK_DEV_HD_ONLY=y).

This (trivial) patch fixes the problem. Please consider including it in
the next -ac kernel.

=========
--- drivers/ide/Makefile.orig   Fri Jul 25 10:09:02 2003
+++ drivers/ide/Makefile        Fri Jul 25 10:18:24 2003
@@ -54,6 +54,7 @@
   obj-y                += arm/idedriver-arm.o
 else
   ifeq ($(CONFIG_BLK_DEV_HD_ONLY),y)
+       subdir-$(CONFIG_BLK_DEV_HD_ONLY) += legacy
        obj-y   += legacy/idedriver-legacy.o
   endif
 endif
=========

I proposed this patch one month ago (Linux 2.4.21-pre8) and though you
approved it on Friday June 13, it has never been included in the 2.4.22
kernels.

Regards

--
Jerome Chantelauze.
