Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSIWSnr>; Mon, 23 Sep 2002 14:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbSIWSnK>; Mon, 23 Sep 2002 14:43:10 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261322AbSIWSmP>;
	Mon, 23 Sep 2002 14:42:15 -0400
Date: Mon, 23 Sep 2002 16:41:44 +0100
From: Matthew Wilcox <willy@debian.org>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Configure/compile error with 2.5.38
Message-ID: <20020923164144.B27458@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got an interesting one here; this combination fails to link:

CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_IDEPCI is not set

Why not?  Well.. cmd640.c is in drivers/ide/pci/ which is only
entered if CONFIG_BLK_DEV_IDEPCI, and if CONFIG_BLK_DEV_CMD640 is set,
drivers/ide/ide.c contains a reference to cmd640_vlb which is defined
in cmd640.c.

The "obvious" solution to make CMD640 depend on IDEPCI is not correct
because of the aforementioned VLB controllers.  Maybe we could just add
the line:
obj-$(CONFIG_BLK_DEV_CMD640)            += pci/
to drivers/ide/Makefile which is a bit of a kludge..

-- 
Revolutions do not require corporate support.
