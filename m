Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265614AbTFNL4I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 07:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTFNL4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 07:56:07 -0400
Received: from cs.huji.ac.il ([132.65.16.30]:49160 "EHLO cs.huji.ac.il")
	by vger.kernel.org with ESMTP id S265669AbTFNLz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 07:55:57 -0400
Date: Sat, 14 Jun 2003 15:09:38 +0300
From: Tom Alsberg <alsbergt@cs.huji.ac.il>
To: "Andrey V. Savochkin" <saw@saw.sw.com.sg>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCI ID Patch for Intel Ether Express Pro 100 VE (82801BA)
Message-ID: <20030614120938.GA1058@cs.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Face: "5"j@Y1Peoz1;ftTv>\|['ox-csmV+:_RDNdi/2lSe2x?0:HVAeVW~ajwQ7RfDlcb^18eJ;t,O,s5-aNdU/DJ2E8h1s,..4}N9$27u`pWmH|;s!zlqqVwr9R^_ji=1\3}Z6gQBYyQ]{gd5-V8s^fYf{$V2*_&S>eA|SH@Y\hOVUjd[5eah{EO@gCr.ydSpJHJIU[QsH~bC?$C@O:SzF=CaUxp80-iknM(]q(W<UR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

We got a new machine here a few days ago - an Intel ICH D865 PERL 
board based Pentium IV machine, with an on-board Intel EtherExpress 
Pro 100 VE.

After Linux was installed on it, I was called to see why the network 
adapter does not work.  The module was not loaded automatically (it 
was Red Hat something - don't remember, don't use it normally, but it 
has some sort of hardware detection), and loading the eepro100 
modules failed (no such device).

After a few minutes, I traced it to the PCI ID (8086:1050) not being 
in the module's table (new chip or something, apparently).  Having 
added it, it seems to work.

Following is a trivial patch for it:

<patch>
--- drivers/net/eepro100.c.orig	Sat Jun 14 14:51:26 2003
+++ drivers/net/eepro100.c	Sat Jun 14 14:51:08 2003
@@ -2392,6 +2392,7 @@
 	{ PCI_VENDOR_ID_INTEL, 0x103C, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x103D, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x103E, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, 0x1050, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x1059, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x1227, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, 0x1228, PCI_ANY_ID, PCI_ANY_ID, },
</patch>

I am not sure how reliable it is, and whther other modifications 
should be made, but it worked fine for now.

I tried the alternative e100 driver - didn't originally work as well, 
but I did not bother to try patching it too.

Anyway, I would like it to be added to the driver, so that new 
machines with that adapter will work out of the box.

  Thanks,
  -- Tom

-- 
  Tom Alsberg - hacker (being the best description fitting this space)
  Web page:	http://www.cs.huji.ac.il/~alsbergt/
DISCLAIMER:  The above message does not even necessarily represent what
my fingers have typed on the keyboard, save anything further.
