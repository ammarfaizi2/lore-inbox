Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUH3OCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUH3OCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUH3OCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:02:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:37510 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268094AbUH3OCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:02:37 -0400
Date: Mon, 30 Aug 2004 10:02:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Celistica with AMD chip-set
Message-ID: <Pine.LNX.4.53.0408300955470.21607@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

The Celistica server with the AMD chip-set has very poor
PCI performance with Linux (and probably W$ too).

The problem was traced to incorrect bridge configuration
in the HyperTransport(tm) chips that connect up pairs
of slots.

I don't know how to make a generic chip-set bug-fix, and
probably a new BIOS will come out with the correct values
in the registers. But right now, the following initialization
code will fix the box.



//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//  Some kind of problem, here. If the HyperTransport(tm) bridge
//  is found, one of the register values needs to be changed to
//  fix the bus performance. Need to turn back on prefetch.
//

    while((pdev = pci_find_device(0x1022, 0x7450, pdev)) != NULL)
        pci_write_config_dword(pdev,  0x4c, 0x2ec1);



Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
          "DMA used to run at 180 Mb/s. With the new hardware it's only
           30 Mb/s. Must be a software problem......." -actual complaint.
            Note 96.31% of all statistics are fiction.


