Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUBRC4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUBRC4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:56:10 -0500
Received: from watson.far.bakerst.org ([209.167.125.194]:50324 "EHLO
	moran.bakerst.org") by vger.kernel.org with ESMTP id S261744AbUBRC4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:56:07 -0500
Subject: Tuner bug(?) and fix
From: Neal Stephenson <neal@bakerst.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Very Little
Message-Id: <1077072961.23671.11.camel@moran.bakerst.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 21:56:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	In 2.6.2, I noticed that my modprobe.conf line for tuner "options tuner
type=2" no longer worked. It even failed with insmod "insmod tuner.ko
type=2". dmesg reported

vmunix: tuner: chip found @ 0xc0
vmunix: tuner: type set to 19 (Temic PAL* auto (4006 FN5))
vmunix: tuner: type forced to 19 (Temic PAL* auto (4006 FN5)) [insmod]

I noticed that the a line had been removed from 2.6.1 and when it is
added everything works again. patch attached

--- -   2004-02-17 21:53:57.000000000 -0500
+++ /usr/src/linux-2.6.2-skas/drivers/media/video/tuner.c      
2004-02-17 21:39:06.000000000 -0500
@@ -1040,6 +1040,7 @@
  
         i2c_attach_client(client);
        if (type < TUNERS) {
+               t->type = type;
                printk("tuner: type forced to %d (%s) [insmod]\n",
                       t->type,tuners[t->type].name);
                set_type(client,type);


