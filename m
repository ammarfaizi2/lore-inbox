Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264754AbTF3Sg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 14:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbTF3Sg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 14:36:27 -0400
Received: from fmr01.intel.com ([192.55.52.18]:48870 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264754AbTF3SgT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 14:36:19 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] ethtool_ops
Date: Mon, 30 Jun 2003 11:46:16 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107DA41@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ethtool_ops
Thread-Index: AcM/JQbIMszpaCqQS+WgOt2bqBeAkAAERo+Q
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Matthew Wilcox" <willy@debian.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
X-OriginalArrivalTime: 30 Jun 2003 18:46:17.0164 (UTC) FILETIME=[E3A728C0:01C33F37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 06, 2003 at 01:17:46PM -0700, Feldman, Scott wrote:
> > * On get_gregs, for example, would it make sense to ->get_drvinfo
> >   so you'll know regdump_len and therefore can kmalloc an 
> ethtool_regs
> >   with enough space to pass to ->get_regs?  Keep the kmalloc and
> >   kfree together.  Same for self_test, get_strings, and get_stats.
> >   For get_strings, size = max{n_stats, testinfo_len)*sizeof(u64).
> 
> That would be one possibility, but get_drvinfo is quite 
> heavyweight. I think I'd prefer to not do that unless there's 
> a strong feeling about thing.

I'm pretty sure you want to do this.  The less work done in the drivers,
the better.  See Jeff's response on this as well.
 
> > * Can we get an HAVE_ETHTOOL_OPS defined in netdevice.h to support
> >   backward compat?
> 
> I'm hoping to avoid that by getting compatibility code merged 
> into 2.4.22.

I'm not sure what compatibility code you're referring to.  We need to
target older kernels with the same code base, so a simple
HAVE_ETHTOOL_OPS would make this easy.  I'd really like to move over to
ethtool_ops for e100/e1000/ixgb, but it's problematic if we need to
manage multiple code bases.

-scott
