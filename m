Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753493AbWKGMuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbWKGMuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbWKGMuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:50:13 -0500
Received: from main.gmane.org ([80.91.229.2]:46212 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1753493AbWKGMuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:50:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Torsten Wolf <t.wolf@tu-bs.de>
Subject: No AGP/DRI on Intel 875P chipset?
Date: Tue, 7 Nov 2006 12:33:12 +0000 (UTC)
Message-ID: <loom.20061107T131657-596@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.169.46.66 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060830 Firefox/1.5.0.7 (Debian-1.5.dfsg+1.5.0.7-2))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm struggling for days to enable 3D acceleration on the following machine:

P4@3.2GHz, 3GB RAM, Intel i875P chipset and Ati RV280 [Radeon 9200 SE] graphics
card. I tried 2.6.16 and 2.6.18-2 (both Debian kernels) and have the following
issue. As soon as I load agpgart.ko the following line appears in dmesg:

Linux agpgart interface v0.101 (c) Dave Jones

But after loading intel-agp.ko nothing happens i.e. no message which chipset
has been detected and not even that the chipset is unsupported and one should
try agp_try_unsupported. Both proprietary and open source display drivers do
not give a working dri setup but complain e.g.

[agp] unable to acquire AGP, error "xf86_ENODEV"
cannot init AGP

I added some printk to intel-agp.c in agp_intel_probe to see if/why the id of
the chipset does not match, but got no output at all. lspci on this machine
yields

00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub
 (rev 02)
00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Controller
 (rev 02)

and lspci -n

00:00.0 0600: 8086:2578 (rev 02)
00:01.0 0604: 8086:2579 (rev 02)

Via google I found that i875P is supported since 2.5.70/2.4.22 (pciid 0x2578).
In a desperate attempt I added 0x2579 to intel-agp.c but again without effect.
I compared the drivers/char/agp directories of the vanilla kernel and the
debian sources but found not enough differences to give the vanilla kernel
another try. Please help me out of this mess.

Best regards,
Torsten

