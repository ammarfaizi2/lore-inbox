Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbSLFGM6>; Fri, 6 Dec 2002 01:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbSLFGM5>; Fri, 6 Dec 2002 01:12:57 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:30916 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267609AbSLFGM5>; Fri, 6 Dec 2002 01:12:57 -0500
Date: Thu, 05 Dec 2002 22:15:33 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] generic device DMA implementation
To: linux-kernel@vger.kernel.org
Message-id: <3DF04085.3050909@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm all in favor of making the driver model support dma mapping,
so usb won't need to try any more.  I'd expect that to make some
dma model issues for the sa1100 and uml usb ports vanish, and
ideally to eliminate some code now in usbcore.


 > empty before adding new requests.  I think that the Linux OHCI
 > controller currently only queues one request per bulk or control
 > endpoint, so I don't think it uses this feature, if it were to, it

In 2.5, all hcds are supposed to queue all kinds of usb requests,
including ohci.  (The ohci driver has supported that feature as
long as I recall.)  Storage is using that by default now, which
lets high speed disks talk using big scatterlist dma requests.

That's a big change from 2.4, where queueing mostly worked but
wasn't really used by many drivers.  In particular, storage
rarely queued more than one page ... now I've seen it queueing
several dozen pages, so faster devices can reach their peak
transfer speeds.  (Tens of MByte/sec, sure.)

- Dave




