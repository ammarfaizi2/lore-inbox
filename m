Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSLBQEl>; Mon, 2 Dec 2002 11:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSLBQEl>; Mon, 2 Dec 2002 11:04:41 -0500
Received: from [209.48.37.1] ([209.48.37.1]:40165 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S264004AbSLBQEk>;
	Mon, 2 Dec 2002 11:04:40 -0500
Date: Mon, 2 Dec 2002 08:11:52 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200212021611.gB2GBqD00707@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.18 8139too.c driver fix for mii-tool
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mii-tool doesn't work with the 8139too.c driver (RTL8139 based network cards).
Internally the driver uses phy ID #'s 32+, but when ioctls are used to
access the phy registers, the ID is masked down to 0-0x1f, so none of them
work properly, and mii-tool fails.

The fix is to change the masking done in the top of netdev_ioctl:
	if (cmd != SIOCETHTOOL) {
		/* With SIOCETHTOOL, this would corrupt the pointer.  */
		data->phy_id &= 0x3f; // was 0x1f (DA) 20021202
		data->reg_num &= 0x1f;
	}

-Dave
