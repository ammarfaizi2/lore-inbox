Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWDRNGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWDRNGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWDRNGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:06:37 -0400
Received: from bay105-f28.bay105.hotmail.com ([65.54.224.38]:22137 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750842AbWDRNGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:06:36 -0400
Message-ID: <BAY105-F2814461145B361479E76BDA3C40@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Cc: tobiasoed@hotmail.com, andre@linux-ide.org
Subject: [patch] Kill useless fcn call
Date: Tue, 18 Apr 2006 09:06:32 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Apr 2006 13:06:35.0537 (UTC) FILETIME=[EBD7F010:01C662E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
this patch against 2.6.17-mm3 for pdc202xx_old.c removes a call
to hwif->tuneproc() on the error path of config_chipset_for_dma(),
as its single caller (pdc202xx_config_drive_xfer_rate()) will do the call
in that case.
Tobias

Signed-off-by: Tobias Oed <tobiasoed@hotmail.com>

--- pdc202xx_old.c.orig 2006-04-18 13:10:54.000000000 +0200
+++ pdc202xx_old.c    2006-04-18 13:12:47.000000000 +0200
@@ -370,7 +370,6 @@
        if (!(speed)) {
                /* restore original pci-config space */
                pci_write_config_dword(dev, drive_pci, drive_conf);
-               hwif->tuneproc(drive, 5);
                return 0;
        }

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement

