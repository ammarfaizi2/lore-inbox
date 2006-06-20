Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWFTKwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWFTKwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWFTKwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:52:53 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:47234 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S932561AbWFTKww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:52:52 -0400
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
To: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] ide: disable dma for transcend CF
Date: Tue, 20 Jun 2006 14:52:36 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606201452.37905.kirr@mns.spb.ru>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NB: bart/ide-2.6.git seems to be unmaintained,  so I'm sending this directly to -mm

I have a CF card which identifies itself as model=TRANSCEND rev=200508011
The card id labeled as TS512MCF80

hdparm -i /dev/hdci  reports:
...
DMA modes:  mdma0 mdma1 *mdma2

IDE controller:
IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)


but if dma is turned on i get a lot of errors::

    hdc: dma_timer_epiry: dma_status == 0x21
    hdc: DMA timeout error
    hdc: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
    ide: failed opcode was: unknown
    ...


So blacklist this CF model.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Index: linux-2.6.17/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.17.orig/drivers/ide/ide-dma.c	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/ide/ide-dma.c	2006-06-20 11:37:30.000000000 +0400
@@ -129,6 +129,7 @@
 	{ "SanDisk SDP3B-64"	,	"ALL"		},
 	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
 	{ "_NEC DV5800A",               "ALL"           },  
+	{ "TRANSCEND"		,	"20050811"	},
 	{ NULL			,	NULL		}
 
 };



