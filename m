Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbVIZAFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbVIZAFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 20:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbVIZAFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 20:05:09 -0400
Received: from savages.net ([66.93.39.90]:59049 "EHLO mail.savages.net")
	by vger.kernel.org with ESMTP id S1751571AbVIZAFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 20:05:07 -0400
Message-ID: <43373B3D.10602@savages.net>
Date: Sun, 25 Sep 2005 17:05:17 -0700
From: Shaun Savage <savages@savages.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: get partition size of block device from another block device.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI All

I am writing a block device driver that uses another block device for 
its "base storage". 

First the block device sturctures questions.
there is one 'struct gendisk' per disk. with partitions under this   
->part[N].
there is one 'struct block_device' is the file system device, one per 
disk or one part partition?
Is ther one kobject for each disk or partition?

-----------------------------------

one of the module parameters passed in is the base device.  eather 
/dev/hda1 or 0x0301, which format is the best?
module_parm_array(str_dev, charp, &dev_cnt,0);
or
module_parm_array(dev_dev, ushort, &dev_cnt,0);

from string to  gendisk
bdev = lookup_bdev(str_dev);                             then finds the 
block_device
gd = get_gendisk(bdev->bd_dev,MINOR(bdev->bd_dev))  

OR

gd= get_gendisk(dev_dev,MINOR(dev_dev))
bdev = bdget_disk(gd, MINOR(dev_dev))
This confuses me, if there is one gendisk per disk why does get_gendisk 
need a partition number?

OR

something with kobject?

----------------------------------------------------------
Now to get ther size.
numberOfSectors =gd->part[MINOR(dev)]->nr_sects

Now I need to 'open' the device for r/w 
bd_claim()
or
open_bdev_excl()

Now read and write data to the sub block device


