Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWHSAP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWHSAP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWHSAP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:15:26 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:13979 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1422657AbWHSAPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:15:25 -0400
Date: Sat, 19 Aug 2006 02:15:23 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Seewer Philippe <philippe.seewer@bfh.ch>, Jeff Garzik <jeff@garzik.org>,
       Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
Message-ID: <20060819001523.GA6440@boogie.lpds.sztaki.hu>
References: <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net> <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr> <44E42900.1030905@PicturesInMotion.net> <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr> <44E56804.1080906@bfh.ch> <44E5B672.1010407@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E5B672.1010407@tmr.com>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 08:45:38AM -0400, Bill Davidsen wrote:

> For discussion I suggest /proc/ata/devices, a single flat file matching 
> a name meaningful to open() with a vendor string and whatever other info 
> is handy, like serial number and the like.

Why just ATA? Let it contain all disk-like devices in the system, and
add an extra field showing the transport method
(IDE/USB/SCSI/SATA/whatever) the device is currently using.

Hmm, /sys/block already contains all the kernel-internal device names,
/sys/block/*/device already gives the physical location. We might just
need a couple additional attributes (like "serial") for user
convenience, and a little shell script that walks /sys/block and emits
an unified device list?

Alternatively, the shell scipt could use blktool to collect the data not
already present under /sys/block, so there would be no need to modify
the kernel at all. blktool could be modified to accept a path name under
/sys/block as well as a device node, and print some more data the serial
number when using the "id" command, but I think that's doable.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
