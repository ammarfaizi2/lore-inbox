Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTATPsK>; Mon, 20 Jan 2003 10:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTATPsJ>; Mon, 20 Jan 2003 10:48:09 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:45255 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266161AbTATPsI>;
	Mon, 20 Jan 2003 10:48:08 -0500
Date: Mon, 20 Jan 2003 15:54:35 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: propagating failures down to pci_module_init()
Message-ID: <20030120155435.GA29238@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a wierd situation with a certain chipset for agpgart.
There are a few cases where I want to be able to use the existing
pci_driver api to detect the right PCI device, and call
the relevant .probe routine. No problem there.

The problem is that in these cases, I want to be able to read
a certain register in that device, and if a bit is 0, bail out
of the .probe function with -ENODEV, and make the loading of
the module fail.

The problem is that the ENODEV in my .probe routine doesn't
propagate back down as far as pci_module_init().

Ideas ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
