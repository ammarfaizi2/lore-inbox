Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317277AbSGOPb6>; Mon, 15 Jul 2002 11:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317381AbSGOPb5>; Mon, 15 Jul 2002 11:31:57 -0400
Received: from proxy.ATComputing.nl ([195.108.229.1]:19691 "EHLO
	atcmpg.ATComputing.nl") by vger.kernel.org with ESMTP
	id <S317277AbSGOPb4>; Mon, 15 Jul 2002 11:31:56 -0400
Date: Mon, 15 Jul 2002 17:34:50 +0200
From: Daniel Tuijnman <daniel@ATComputing.nl>
To: linux-kernel@vger.kernel.org
Subject: Block device driver info in /proc?
Message-ID: <20020715173450.B21106@ATComputing.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm looking for a robust way to match block devices with the
corresponding device driver modules. Not just IDE and SCSI disks, but
also disks attached to disk array controllers as the Compaq IDA or
CCISS. All these modules present info in the /proc filesystem.

My question is, is there a uniform way to find it, i.e., is there a
standard for the /proc layout?

Or should I resort to make my own table to match device names to module
names? That's a solution I don't like, as it means adapting my program
each time a new device comes to the market.

Background of this question: I'm writing a Linux installer, and I need
to add the right entries to /etc/modules.conf
(e.g.: alias block-major-82 cpqarray),
and to pass the right modules to mkinitrd so Linux can be booted from
a disk attached to such a device. So then I need to find out which
(loaded) modules correspond to which devices. I can read in
/proc/partitions which disks there are, with their device names and 
major numbers, but how can I relate this to the module that drives it?

For the Compaq IDA controller, for instance, /proc/partitions tells me I
have a disk /dev/ida/c0d0 with major device number 82,
then /proc/devices tells me block device 82 is named ida0, and then I
can find a file /proc/driver/block/cpqarray/ida0 from which I can infer
that the module name is cpqarray. Does this work for other drivers the
same? Or is there another way to match the two?

Cheers,
Daniel Tuijnman

