Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTFFUEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 16:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTFFUEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 16:04:24 -0400
Received: from fmr01.intel.com ([192.55.52.18]:31446 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262263AbTFFUEQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 16:04:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] ethtool_ops
Date: Fri, 6 Jun 2003 13:17:46 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D8CD@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ethtool_ops
Thread-Index: AcMsOCMl3FNUgn9ATeutLiuVEQL/VgAHa3DQ
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Matthew Wilcox" <willy@debian.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
X-OriginalArrivalTime: 06 Jun 2003 20:17:46.0640 (UTC) FILETIME=[B1B8B900:01C32C68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right now, each network driver which supports the ethtool 
> ioctl has its own implementation of everything from decoding 
> which ethtool ioctl it is, copying data to and from 
> userspace, marshalling and unmarshalling data from ethtool 
> packets, etc.  The current setup makes it impossible to use 
> alternative interfaces to get at the same data (eg sysfs) and 
> it's not exactly typesafe.

This is really cool!  Thanks for doing this Matthew.

Some questions:

* On get_gregs, for example, would it make sense to ->get_drvinfo
  so you'll know regdump_len and therefore can kmalloc an ethtool_regs
  with enough space to pass to ->get_regs?  Keep the kmalloc and
  kfree together.  Same for self_test, get_strings, and get_stats.
  For get_strings, size = max{n_stats, testinfo_len)*sizeof(u64).

* If the above is done, can we have one function type for the
ethtool_ops
  functions?  int f(struct netdev *, struct ethtool_cmd *).  The 
  drawback is the driver needs to cast to the specific ethtool_* struct.

* Can we get an HAVE_ETHTOOL_OPS defined in netdevice.h to support
  backward compat?

-scott
