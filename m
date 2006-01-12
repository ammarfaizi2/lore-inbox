Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161375AbWALWlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161375AbWALWlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161376AbWALWlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:41:49 -0500
Received: from CPE0050fc332afc-CM00407b861c34.cpe.net.cable.rogers.com ([69.197.25.155]:45021
	"EHLO nuku.localdomain") by vger.kernel.org with ESMTP
	id S1161375AbWALWlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:41:49 -0500
Date: Thu, 12 Jan 2006 17:41:39 -0500
From: Rashkae <rashkae@tigershaunt.com>
To: linux-kernel@vger.kernel.org
Subject: ATAPI DVD Drive looses dma settings on reset, keepsettings=1
Message-ID: <20060112224139.GA4562@tigershaunt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with Linux 2.6.15 and 2.6.13.3

I have an ATAPI DVD drive as a master(single) device on my
secondary IDE (hdc).

The normal hdparm settings are:
IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 readonly     =  0 (off)
 readahead    = 256 (on)


However, if I force a reset with hdparm -w (or the Kernel does
when I insert a disc that the drive takes too long to identify),
DMA gets turned off.  Dmesg reports:

hdc: DMA disabled
hdc: ATAPI reset complete


In the case where inserting a disc causes the reset, dmesg
reports:


hdc: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdc: DMA disabled
hdc: ATAPI reset complete

Is there a way I can increate the irq timeout?

It was my understanding that with keepsettings on, the driver
would retain the dma setting on reset.  If there is a way correct
this, or I have mis-understood the purpose of keepsettings,
please CC me the response. 

Thanks. 
