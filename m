Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUGZKrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUGZKrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 06:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUGZKrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 06:47:25 -0400
Received: from dig-image.evro.net ([80.72.64.50]:61190 "EHLO
	batman.fmi.uni-sofia.bg") by vger.kernel.org with ESMTP
	id S265152AbUGZKrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 06:47:23 -0400
Message-ID: <4104E27E.2030006@fmi.uni-sofia.bg>
Date: Mon, 26 Jul 2004 13:52:46 +0300
From: Ognyan Kulev <ogi@fmi.uni-sofia.bg>
Organization: Faculty of Mathematics and Informatics, University of Sofia
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [IDE] OPTi 621, chipset revision 18, hangs with enabled DMA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my laptop (Compaq Armada 4120), I've used for a long time a Linux 
2.4.20 kernel just because newer kernels hang on partition checks.  The 
error was something like the following and it always appeared at 
partition check (this is taken from Internet, but it was similar in my 
case):

Jan 8 22:14:15 darkstar kernel: hda: dma_timer_expiry: dma status == 0x21
Jan 8 22:14:25 darkstar kernel: hda: error waiting for DMA
Jan 8 22:14:25 darkstar kernel: hda: dma timeout retry: status=0x58 { 
DriveReady SeekComplete DataRequest }

After adding "ide=nodma", everything works fine.  I see that code in 2.6 
hasn't changed since 2.4 (except because of the API changes in 2.6, of 
course).

So I would like by default DMA to be disabled for OPTi 621 or there to 
be some other resolution.  Probably removing the following lines will do 
the work, but I haven't tested it:

         if (!noautodma)
                 hwif->autodma = 1;

(Some lines above, there is "hwif->autodma=0;".)

BTW In Linux 2.4.19 source, "grep dma drivers/ide/opti621.c" gives nothing.

Regards,
ogi
