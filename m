Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVBSUuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVBSUuj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 15:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVBSUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 15:50:39 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:7856 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261802AbVBSUuf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 15:50:35 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
Date: Sat, 19 Feb 2005 15:50:15 -0500
User-Agent: KMail/1.7.92
Cc: linux-kernel@vger.kernel.org, scjody@modernduck.com
References: <200502191136.05584.david-b@pacbell.net>
In-Reply-To: <200502191136.05584.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502191550.15929.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 February 2005 02:36 pm, David Brownell wrote:
> The cost of creating the dma_pool is the cost of one small kmalloc()
> plus (the expensive part) the /sys/devices/.../pools sysfs attribute
> is created along with the first pool.  (Use that instead of slabinfo
> for those pool allocations.)  That's why the normal spot to create and
> destroy dma pools is in driver probe() and remove() methods.

What's the format of /sys/devices/.../pools (Name of pool, ? ? ? ?) ?  Can the 
memory consumption be derived from it? 
Here is what the ohci pools look during data read (Kino->Capture) and after 
closing Kino -

During Kino Capture
[root@localhost pci0000:00]# cat ./0000:00:0a.0/0000:02:00.0/pools
poolinfo - 0.1
ohci1394 rcv prg   16  256   16  1 ------------------> This one is in question
ohci1394 trm prg   32   64   64  1
ohci1394 trm prg   32   64   64  1
ohci1394 rcv prg    4  256   16  1
ohci1394 rcv prg    4  256   16  1

After Closing Kino
[root@localhost pci0000:00]# cat ./0000:00:0a.0/0000:02:00.0/pools
poolinfo - 0.1
ohci1394 trm prg   32   64   64  1
ohci1394 trm prg   32   64   64  1
ohci1394 rcv prg    4  256   16  1
ohci1394 rcv prg    4  256   16  1

Parag
