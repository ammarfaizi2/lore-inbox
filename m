Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267195AbTAFWbU>; Mon, 6 Jan 2003 17:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267194AbTAFWbU>; Mon, 6 Jan 2003 17:31:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10374
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267195AbTAFWbT>; Mon, 6 Jan 2003 17:31:19 -0500
Subject: IDE changes that affect upper layer drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041895478.18831.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 23:24:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm about to enable the vmda logic for non disk drivers. That means IDE
tape, scsi, cd and friends need updating to follow the new rules

Before it was simply:
	->dma = 1   - do DMA

Some devices and a lot of upcoming ones support DMA to the host while
doing PIO to the device "Virtual DMA". That means the drivers now
need to do

	DMA	VDMA
	 0	  X		PIO
	 1	  0		Issue PIO commands, set up for DMA xfers
	 1        1		Issue DMA commands, set up for DMA xfers


Alan

