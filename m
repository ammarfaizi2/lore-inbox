Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269632AbRHMAy3>; Sun, 12 Aug 2001 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269631AbRHMAyU>; Sun, 12 Aug 2001 20:54:20 -0400
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:40579 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S269621AbRHMAyM>; Sun, 12 Aug 2001 20:54:12 -0400
Message-ID: <XFMail.20010812205406.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sun, 12 Aug 2001 20:54:06 -0400 (EDT)
From: f.duncan.m.haldane@worldnet.att.net
To: linux-kernel@vger.kernel.org
Subject: PCI spec question/possible VIA quirk?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Can anyone tell me what the PCI specs say config registers 0x2c:0x2f 
should contain? 

------------------------lspci -x says:------------------------------
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00: 06 11 05 83 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 00 f6 f0 f7 00 fc f0 fd 00 00 00 00 43 10 2f 80 <====== Here!
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
---------------------------------------------------------------------

In drivers/pci/pci.c (all 2.4.x kernels) pci_read_bridge_bases() 
is reading "mem_limit_hi" from them.  
(PCI_PREF_LIMIT_UPPER32 = 0x2c in pci.h) 

This seems to need to be 00 00 00 00 for the pci setup to work 
properly.  A non-zero value leads to the error:

"PCI: Unable to handle 64-bit address space for %s\n"

(Hacking in a line that resets mem_limit_hi to 0 seems to make 
everything work fine; without it the AGP card doesnt get set up 
correctly for accelerated modes)

Are the strange values in these registers maybe a VIA quirk?
(most of the pci devices have such values.)  

Any suggestions would be appreciated!

Duncan Haldane
(please cc: any reply to me)

----------------------------------
E-Mail: f.duncan.m.haldane@worldnet.att.net
Date: 12-Aug-2001
Time: 20:46:29

This message was sent by XFMail
----------------------------------
