Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbTCKVY3>; Tue, 11 Mar 2003 16:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbTCKVY2>; Tue, 11 Mar 2003 16:24:28 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:41220 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261607AbTCKVY1>;
	Tue, 11 Mar 2003 16:24:27 -0500
Date: Tue, 11 Mar 2003 22:35:04 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Dave Jones <davej@suse.de>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Would the real 82801E_9 please stand up. (fwd)
Message-ID: <20030311213504.GA4550@win.tue.nl>
References: <20030311192945.GA16212@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311192945.GA16212@fs.tum.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 08:29:45PM +0100, Adrian Bunk wrote:
> The issue described in Dave's mail below is still present:
> 
> 2.4.21-pre5-ac1:
> #define PCI_DEVICE_ID_INTEL_82801E_9    0x2459
> #define PCI_DEVICE_ID_INTEL_82801E_11   0x245B
> 
> 
> 2.5.64-ac3:
> #define PCI_DEVICE_ID_INTEL_82801E_9    0x245b
> #define PCI_DEVICE_ID_INTEL_82801E_11   PCI_DEVICE_ID_INTEL_82801E_9

The 82801E has seven device IDs:
B1:D8:F0	2459	Ethernet Controller 0
B1:D9:F0	245d	Ethernet Controller 1
 D30:F0		245e	PCI Hub
 D31:F0		2450	LPC I/F
 D31:F1		245b	IDE
 D31:F2		2452	USB
 D31:F3		2453	SMBus

Clearly, the 2.5.64 uses are for IDE and must be 0x245b.
PCI_DEVICE_ID_INTEL_82801E_9 does not occur in 2.5.64,
apart from its definition.

Conclusion: 2.4 is right.

--- /linux/2.5/linux-2.5.64/linux/include/linux/pci_ids.h       Wed Mar  5 10:47:31 2003
+++ /linux/2.5/linux-2.5.64a/linux/include/linux/pci_ids.h      Tue Mar 11 22:31:53 2003
@@ -1831,8 +1831,8 @@
 #define PCI_DEVICE_ID_INTEL_82801E_0	0x2450
 #define PCI_DEVICE_ID_INTEL_82801E_2	0x2452
 #define PCI_DEVICE_ID_INTEL_82801E_3	0x2453
-#define PCI_DEVICE_ID_INTEL_82801E_9	0x245b
-#define PCI_DEVICE_ID_INTEL_82801E_11	PCI_DEVICE_ID_INTEL_82801E_9
+#define PCI_DEVICE_ID_INTEL_82801E_9	0x2459
+#define PCI_DEVICE_ID_INTEL_82801E_11	0x245b
 #define PCI_DEVICE_ID_INTEL_82801E_13	0x245d
 #define PCI_DEVICE_ID_INTEL_82801E_14	0x245e
 #define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480

Andries

