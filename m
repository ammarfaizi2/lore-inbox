Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWFIDnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWFIDnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWFIDnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:43:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55524 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751378AbWFIDnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:43:40 -0400
Message-ID: <4488EE68.9000605@garzik.org>
Date: Thu, 08 Jun 2006 23:43:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: "zhao, forrest" <forrest.zhao@intel.com>, htejun@gmail.com,
       randy_dunlap <rdunlap@xenotime.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] ATA host-protected area (HPA) device mapper?
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com> <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488E6F6.10306@pobox.com>
In-Reply-To: <4488E6F6.10306@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I just mentioned on linux-ide in another email:
libata should -- like drivers/ide -- call the ATA "set max" command to 
fully address the hard drive, including the special "host-protected 
area" (HPA).  We should do this because the Linux standard is to export 
the raw hardware directly, making 100% of the hardware capability 
available to the user (and, in this case, Linux-based BIOS and recovery 
tools).

However, there are rare bug reports and general paranoia related to 
presenting 100% of the ATA hard drive "native" space, rather than the 
possibly-smaller space that the BIOS chose to present to the user.

My thinking is that [someone] should create an optional, ATA-specific 
device mapper module.  This module would layer on top of an ATA block 
device, and present two block devices:  the BIOS-presented space, and 
the HPA.

Such a module would make it trivial for users to ensure that partition 
tables and RAID metadata formats know what the BIOS (rather than 
underlying hard drive) considers to be end-of-disk.

Comments?  Questions?  Am I completely insane?  ;-)

	Jeff



