Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTFFOQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTFFOQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:16:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23968 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261702AbTFFOQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:16:18 -0400
Date: Fri, 6 Jun 2003 15:29:51 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [PATCH] ethtool_ops
Message-ID: <20030606142951.GB28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch is 40k, so I'm not going to post it inline.
http://ftp.linux.org.uk/pub/linux/willy/patches/ethtool.diff

Right now, each network driver which supports the ethtool ioctl has its
own implementation of everything from decoding which ethtool ioctl it is,
copying data to and from userspace, marshalling and unmarshalling data
from ethtool packets, etc.  The current setup makes it impossible to
use alternative interfaces to get at the same data (eg sysfs) and it's
not exactly typesafe.

This patch introduces ethtool_ops and converts tg3 to use it.
Drivers don't access userspace on their own under this scheme; they
just do the requested operation and return the appropriate value(s).
Compile-tested only; design approved by jgarzik.  Comments welcomed.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
