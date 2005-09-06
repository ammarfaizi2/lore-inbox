Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVIFBIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVIFBIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVIFBIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:08:05 -0400
Received: from main.gmane.org ([80.91.229.2]:14057 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965041AbVIFBIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:08:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jack Byer <ojbyer@usa.net>
Subject: legacy megaraid driver bug in mm-series
Date: Mon, 05 Sep 2005 21:05:40 -0400
Message-ID: <dfiq14$1b2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 69.37.187.190
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050902
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My AMI megaraid card no longer works with recent mm-series kernels. The
bug appears on mm- kernels newer than 2.6.12-rc6-mm1; mainline kernels
are not affected.

The driver will load and detect both devices on the card (sda and sdb).
It will scan each device and read the partition table successfully,
however the megaraid driver message will include the following errors:

sda: sector size 0 reported, assuming 512.
sda: asking for cache data failed.
sda: assuming drive cache: write through

When the kernel tries to mount the root file system, I get the following
error:

ReiserFS: sda3: warning: sh-2006: read_super_block: bread failed (dev
sda3, block 2, size 4096)
ReiserFS: sda3: warning: sh-2006: read_super_block: bread failed (dev
sda3, block 16, size 4096)
VFS: Cannot open root device "sda3" or unknown-block(0,3)

Here is a summary of the kernels I have tested for this bug:

2.6.11-mm1:	works
2.6.11-mm4:	works
2.6.12-rc5-mm1:	will not compile
2.6.12-rc6-mm1:	works
2.6.12-mm1:	will not compile megaraid driver
2.6.12-mm2:	broken
2.6.13-mm1:	broken

2.6.12:		works
2.6.13:		works

