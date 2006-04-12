Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWDLD5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWDLD5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 23:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWDLD5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 23:57:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44955 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750940AbWDLD5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 23:57:11 -0400
Message-ID: <443C7A92.6010604@garzik.org>
Date: Tue, 11 Apr 2006 23:57:06 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andreas Schnaiter <schnaiter@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16 -  SATA read performance drop ~50% on Intel 82801GB/GR/GH
References: <200604120136.28681.schnaiter@gmx.net>
In-Reply-To: <200604120136.28681.schnaiter@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.8 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.8 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schnaiter wrote:
> Hi,
> 
> after upgrading from linux 2.6.15.7 to 2.6.16.2 I noticed an extreme slowdown 
> of the SATA disks on my system. Writing/reading a 8GB file showed that 
> reading performes with less than half the speed on 2.6.16 (strangely hdparm 
> shows almost no difference).
> The two affected disks are connected to the Intel 82801GB/GR/GH (ICH7 Family)  
> Serial ATA Controller.
> Disks on the Silicon Image/Intel IDE Controllers are not affected.
> I didn't have the chance yet to test if this problem also exists on the 
> Silicon Image SATA Controller.

hdparm usually skips the usual layers, and benchmarks the ATA command 
submission itself.  So if hdparm didn't change, that may indicate the 
problem is either in the block (scheduler?) or filesystem layers.

Tests:

1) Try with Silicon Image controller, as you mentioned.  Try in same 
machine with same device, if possible.

2) Eliminate the filesystem layer by doing dd directly to the block 
device (dd ... of=/dev/sda1) rather than dd'ing to a file on a filesystem.

3) Try decreasing the block size to 4k or 8k.

4) Finally, the thing that will help us kernel hackers the most, use 
'git bisect' to definitively discover the changeset that causes your 
problems.

	Jeff



