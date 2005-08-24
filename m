Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVHXNNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVHXNNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 09:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVHXNNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 09:13:49 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:27031 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750956AbVHXNNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 09:13:48 -0400
Date: Wed, 24 Aug 2005 09:13:47 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050824131347.GO28551@csclub.uwaterloo.ca>
References: <3AEC1E10243A314391FE9C01CD65429B03CB99@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B03CB99@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 02:03:16PM +0530, Mukund JB. wrote:
> Dear Lenneart,
> 
> One good news
> I have implemented the partition support in the driver.
> I am able to mount the partition of the individual device.
> I partition them using the fdisk and mounted them.
> The architecture this some thing like this
> The whole device is represented by tfa0
> And rest of the partitions by tfa0p1, tfa0p2 and so on...
> If there is a device in second socket, the whole device is represented
> by tfa1 and rest of the partitions by tfa1p1, tfa1p2 and so on... I am
> following the above conventions. Is the is what in general all Linux
> devices follow. 

Most common for disk devices is XXYZ where XX is some name for the
driver (hd for ide, sd for scsi, other things for other drive types), Y
is a letter (a for first, b for second, c for third, etc) and Z is the
partition number.  So in your case you could have:

tfaa for first slot
tfaa1 for first partition on first slot.
tfab for second slot
tfab4 for 4th partition on second slot.

Or call it tf and use tfa1 tfb4 etc.

> I have four sockets on which I have to support individual device with
> partitions on them. Is there a better conventional way to represent all
> the four devices? My driver also supports 4 such controllers. To support
> first socket device on the second controller I am using tfb0, tfb0p1,
> tfb0p2...

Well at least ide and scsi don't care which controller, they still just
name them in order.  You could just use tfa up to tfp for the devices.
That is what I would do unless the seperate controllers really make more
sense to users (counting to slot 16 might be a bit much using letters
for some users).

Maybe tf1a2 for controller 1 slot a partition 2 would be nicer to the
user.  Some raid cards do use /dev/raidname/c1d2p3 for card 1 device 2
partition 3.  Maybe you prefer that arangement.

> I have left with handling lot of generalization in the code.

Len Sorensen
