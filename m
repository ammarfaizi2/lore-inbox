Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268236AbTBNHkT>; Fri, 14 Feb 2003 02:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268234AbTBNHkT>; Fri, 14 Feb 2003 02:40:19 -0500
Received: from pcp470010pcs.westk01.tn.comcast.net ([68.47.207.140]:36784 "EHLO
	shed.7house.org") by vger.kernel.org with ESMTP id <S268229AbTBNHkR>;
	Fri, 14 Feb 2003 02:40:17 -0500
Message-ID: <3E4C9FAA.FC8A2DC7@y12.doe.gov>
Date: Fri, 14 Feb 2003 02:50:02 -0500
From: David Dillow <dillowd@y12.doe.gov>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: 3Com 3cr990 driver release
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, after too many delays, I am pleased to announce the release of my
driver for 3Com's 3cr990 family of network cards.

This initial release is endian clean, tested on x86 and sparc64, and does
 - NAPI
 - Zerocopy Tx
 - TCP segmentation
 - Hardware VLAN accel

It does *not* do IPSEC crypto offload as of yet. I have a version for the 2.4
series of kernels, but it is an ugly, ugly kludge, and would be shot if seen
in public. I will be working on integrating the hardware with the IPSEC
support in 2.5.x.

There are a few issues with the firmware -- DMA to a 2 byte aligned address
hangs the firmware, so we cannot easily align the IP header, and the firmware
will always strip the VLAN tags on packet reception, regardless of our
desires. I hope to work with 3Com to resolve these issues.

The code is available via BK at
http://typhoon.bkbits.net/typhoon-2.4
http://typhoon.bkbits.net/typhoon-2.5

Diffstats:

typhoon-2.4:

 Documentation/Configure.help   |   18
 MAINTAINERS                    |    6
 drivers/net/Config.in          |    3
 drivers/net/Makefile           |    1
 drivers/net/typhoon-firmware.h | 4108 ++++++++++++++++++++++++++++++++++++
 drivers/net/typhoon.c          | 2505 ++++++++++++++++++++
 drivers/net/typhoon.h          |  613 ++++++
 include/linux/pci_ids.h        |    8
 8 files changed, 7262 insertions(+)


typhoon-2.5:

 MAINTAINERS                    |    6
 drivers/net/Kconfig            |   20
 drivers/net/Makefile           |    1
 drivers/net/Makefile.lib       |    1
 drivers/net/typhoon-firmware.h | 4108 ++++++++++++++++++++++++++++++++++++
 drivers/net/typhoon.c          | 2505 ++++++++++++++++++++
 drivers/net/typhoon.h          |  613 ++++++
 include/linux/pci_ids.h        |    8
 8 files changed, 7262 insertions(+)


I'd like to thank 3Com's engineers for finding me documentation and putting up
with my questions, and my project manager for navigating the bureaucracy so
that this work may see public use. I couldn't have received a better going
away present on my last day on the job.

Enjoy!
David Dillow
dillowd@y12.doe.gov (old)
dave@thedillows.org (new)
