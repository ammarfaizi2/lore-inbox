Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTFTIEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 04:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTFTIEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 04:04:48 -0400
Received: from mail.consultit.no ([213.239.74.125]:50617 "EHLO
	kosat.consultit.no") by vger.kernel.org with ESMTP id S262431AbTFTIEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 04:04:47 -0400
Date: Fri, 20 Jun 2003 10:18:46 +0200
From: Eivind Tagseth <eivindt@multinet.no>
To: linux-kernel@vger.kernel.org
Subject: Problems with PCMCIA Compact Flash adapter in 2.5.72
Message-ID: <20030620081846.GB2451@tagseth-trd.consultit.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Kingston Compact Flash adapter that I use to mount the flash
card of my digital camera.  I've had several problems with the kernel
with this, both 2.4.20, 2.5.69 and 2.5.72.

Both 2.4.20 and 2.5.69 works though, but oopses if I remove the card.
2.5.72 doesn't work at all:

(using yenta.ko)
Jun 18 21:09:19 [cardmgr] initializing socket 1
Jun 18 21:09:19 [cardmgr] socket 1: ATA/IDE Fixed Disk
Jun 18 21:09:19 [cardmgr] product info: "SanDisk", "SDP", "5/3 0.6"
Jun 18 21:09:19 [cardmgr] manfid: 0x0045, 0x0401  function: 4 (fixed disk)
Jun 18 21:09:19 [cardmgr] executing: 'modprobe ide-cs'
Jun 18 21:09:19 [cardmgr] bind 'ide-cs' to socket 1 failed: Invalid argument

I'm not sure what cardmgr tries to do with ide-cs, but it works with
2.5.69 but seems to have stopped working in 2.5.70 or 2.5.71 (didn't try
2.5.70) and is still not working in 2.5.72.  stracing cardmgr didn't help,
as the interesting parts are hidden inside a vfork which strace won't follow.

2.5.69 works (using yenta_socket.ko) and logs this:
Jun 15 20:43:19 [kernel] cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jun 15 20:43:19 [cardmgr] socket 1: ATA/IDE Fixed Disk
Jun 15 20:43:20 [cardmgr] executing: 'modprobe ide-cs'
Jun 15 20:43:23 [kernel] hdc: Flash Card, CFA DISK drive
Jun 15 20:43:23 [kernel] hdc: max request size: 128KiB
Jun 15 20:43:23 [kernel] hdc: task_no_data_intr: status=0x51 { DriveReady SeekCo
mplete Error }
Jun 15 20:43:23 [kernel] hdc: 1006992 sectors (516 MB) w/0KiB Cache, CHS=999/16/
63
Jun 15 20:43:23 [kernel]  /dev/ide/host1/bus0/target0/lun0: p1
Jun 15 20:43:23 [cardmgr] executing: './ide start hdc'


Cardmgr is 3.2.4, pcmcia-cs is 3.2.4, gcc is 3.2.2.


I always seem to forget some vital information when reporting bugs, 
please don't hesitate to ask for more info.  I'll be happy to try any
patches to the kernel and/or cardmgr if needed.



Eivind
