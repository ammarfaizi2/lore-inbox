Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWFRRBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWFRRBm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWFRRBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:01:42 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45246 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932256AbWFRRBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:01:41 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 18 Jun 2006 19:00:54 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc6-mm2 3/6] ieee1394: make module parameter
 ignore_drivers writable
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.7fb54747c3c78ac1@s5r6.in-berlin.de>
Message-ID: <tkrat.68482958a026ceaa@s5r6.in-berlin.de>
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
 <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson>
 <20060610183703.GA1497@infradead.org> <44944D8A.6090808@s5r6.in-berlin.de>
 <tkrat.7edcc575e6bfd4ed@s5r6.in-berlin.de>
 <tkrat.285947e88a3d529f@s5r6.in-berlin.de>
 <tkrat.7fb54747c3c78ac1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.043) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nodemgr's ignore_drivers variable is exposed as a module load parameter
(therefore also as a sysfs attribute below /sys/module) and additionally
as an attribute below /sys/bus/ieee1394.  Since the latter is writable,
make the former writable too.

Note, the bus's attribute ignore_drivers is only relevant to newly added
units, not to present or suspended or resuming units.  Those have their
own attribute ignore_driver.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-06-18 09:15:45.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-06-18 11:27:13.000000000 +0200
@@ -27,7 +27,7 @@
 #include "nodemgr.h"
 
 static int ignore_drivers;
-module_param(ignore_drivers, int, 0444);
+module_param(ignore_drivers, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_drivers, "Disable automatic probing for drivers.");
 
 struct nodemgr_csr_info {


