Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265858AbVBFBpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265858AbVBFBpb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 20:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265826AbVBFBpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 20:45:31 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:42045 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263696AbVBFBpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 20:45:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=aG7ijGm69c291FS1PC1X7zcC31D4n5ZN+9KBKel44mDx8Wl7LhImj2q/677OwkfS1AUgm+UXLna5lO8V0BaJAjotDdD5cn71dbgY2qei03GyrPQNFL6aCEp+YpvZdbsCS1ZYOWSN2Ai6XxrFzcJ5JT+4kwyjYFwyeNfrOYQFgo8=
Message-ID: <9e4733910502051745c25d6f@mail.gmail.com>
Date: Sat, 5 Feb 2005 20:45:19 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Intel AGP support attaching to wrong PCI IDs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an i875 chipset with these two devices:

8086:2578 - 00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory
Controller Hub (rev 02)
8086:2579 - 00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP
Controller (rev 02)

In the legacy io space thread we are talking about making a device
driver for host bridges.  The Intel AGP drivers (in my case
agpgart-intel-mch) are attaching to the PCI IDs of the host bus device
instead of the AGP bridge. This blocks us from making a host bridge
driver.
PCI_DEVICE_ID_INTEL_82875_HB 0x2578

Shouldn't they be attaching to device 0x2579? It looks like all of the
drivers have this problem and are attaching to the host bus PCI IDs
instead of the AGP bridge ID.

[root@jonsmirl pci]# cat devices
0000    80862578        0       ec000008        00000000       
00000000        00000000        00000000        00000000       
00000000      04000000 00000000        00000000        00000000       
00000000        00000000        00000000        agpgart-intel-mch
0008    80862579        0       00000000        00000000       
00000000        00000000        00000000        00000000       
00000000      00000000 00000000        00000000        00000000       
00000000        00000000        00000000

Am I correct in thinking that in all cases there has to be two PCI
IDs, one for the host bridge and one for the APG bridge?

-- 
Jon Smirl
jonsmirl@gmail.com
