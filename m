Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTKCXqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTKCXqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 18:46:30 -0500
Received: from messenger.kasenna.org ([208.253.201.3]:16393 "EHLO
	messenger.kasenna.org") by vger.kernel.org with ESMTP
	id S263498AbTKCXq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 18:46:28 -0500
Message-ID: <3FA6E8CE.6040208@kasenna.com>
Date: Mon, 03 Nov 2003 15:46:22 -0800
From: Shirley Shi <shirley@kasenna.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: All filesystems hang under long periods of heavy load (read and write)
 on a filesystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone know why all filesystems hang under periods of heavy load on 
one of the filesystem? Once the filesystems hang, any command related to 
the filesystem, like 'ls', 'cat',etc., will stick forever until re-power 
cycling the machine.

I kept running the following script to read and write the data on a same 
filesystem(ext2 or XFS) since we need do some tests for the storage. Is 
half day, onn the beginning, the system was running well. But after 
running the script for a long time, such a half day, one day or two 
days,  all filesystems would get hung, including the root filesystem 
although I didn't do any heavy load on it. The file(M.1) I used for 
reading and writing is about 2.5GB.


@ total = 115
while (1)
  @ cc = 2
  while ($cc <= $total)
     dd bs=512k if=/data/M.1 of=/data/M.$cc
    echo "copying $cc  of   $total..."
    @ cc = $cc + 1
  end
  rm -f  /data/M.*
end


I tried RH8.0 with kernel 2.4.18 and kernel 2.4.21 with XFS and patch 
rmap15j. I have the same issue running with the two kernels. Basically I 
have two filesytems configured. One for the root configured with ext3, 
and another is for the data configured with ext2 or XFS. With either 
ext2 or XFS, I have the same problem.

I also tried on different Dual CPU machines as follows, but saw the same 
problem.

- A dual-CPU machine with an on-board 320 SCSI controller(running 
AIC79XX.o driver) connecting a disk drive as the root system and a 
MegaRAID 320-4X controller connecting to several disk drives. I created 
two H/W logical RAID devices and built the data filesystem with the S/W 
RAID0(/dev/md0).
- A HP dual-CPU machine with the HP Smart Array 5i connecting to a disk 
drive as the root system and a 160 SCSI controller connecting with 13 
disk drives and configured as a S/W RAID0(/dev/md0) the data filesystem.
- A dual-CPU machine with an on-board 320 SCSI controller(with AIC79XX.o 
driver) connecting a disk drive as the root system and a FC controller 
connecting to a RAID storage.

Any comment would be appreciated.

Thanks,

Shirley


