Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTJSPzF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTJSPzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:55:04 -0400
Received: from nebula.skynet.be ([195.238.2.112]:61356 "EHLO nebula.skynet.be")
	by vger.kernel.org with ESMTP id S261719AbTJSPyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:54:53 -0400
Subject: problems with Seagate 120 GB drives when mutlwrite = 16
From: kris <kris.buggenhout@skynet.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066578892.3091.11.camel@borg-cube.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 19 Oct 2003 17:54:52 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (nebula.skynet.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed some problems with recent large drives, connected to a
variety of controllers.

I tested with nforce ide controller, a CMD649 based controller and an
Intel 870 cghipset. all have same or similar symptoms.

Linux 2.4.22 kernel : (Linux borg-cube 2.4.22-xfs #2 SMP Tue Oct 7
20:53:04 CEST 2003 i686 unknown)

Oct  6 15:52:12 borg-cube kernel: hdg: dma_timer_expiry: dma status ==
0x21
Oct  6 15:52:22 borg-cube kernel: hdg: timeout waiting for DMA
Oct  6 15:52:22 borg-cube kernel: hdg: timeout waiting for DMA
Oct  6 15:52:22 borg-cube kernel: hdg: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Oct  6 15:52:22 borg-cube kernel:
Oct  6 15:52:22 borg-cube kernel: hdg: drive not ready for command
Oct  6 15:52:22 borg-cube kernel: hdg: status timeout: status=0xd0 {
Busy }
Oct  6 15:52:22 borg-cube kernel:
Oct  6 15:52:22 borg-cube kernel: hdg: no DRQ after issuing WRITE
Oct  6 15:52:22 borg-cube kernel: ide3: reset: success

same in 2.4.20 ( kernel from Suse)

2.6.0-test6 :

Oct  9 09:43:09 borg-cube kernel: hdg: dma_timer_expiry: dma status ==
0x21
Oct  9 09:43:18 borg-cube kernel:
Oct  9 09:43:19 borg-cube kernel: hdg: DMA timeout error
Oct  9 09:43:19 borg-cube kernel: hdg: dma timeout error: status=0x58 {
DriveReady SeekComplete DataRequest }
Oct  9 09:43:19 borg-cube kernel:
Oct  9 09:43:19 borg-cube kernel: hdg: status timeout: status=0xd0 {
Busy }
Oct  9 09:43:19 borg-cube kernel:
Oct  9 09:43:19 borg-cube kernel: hdg: no DRQ after issuing MULTWRITE
Oct  9 09:43:20 borg-cube kernel: ide3: reset: success

same in 2.6.0-test8 

so behaviour is consistent.

I can avoid this with either turning off dma access or disabling the
multwrite ( hdparm -m0 /dev/hdg)

is this a known bug, or should I file one ?

kind regards, Kris

