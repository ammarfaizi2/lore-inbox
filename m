Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266071AbUFPCRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUFPCRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUFPCRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:17:13 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:1921 "EHLO crianza")
	by vger.kernel.org with ESMTP id S266071AbUFPCQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:16:40 -0400
Date: Tue, 15 Jun 2004 22:16:33 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040616021633.GB13672@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615162607.5805a97e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 04:26:07PM -0700, Andrew Morton wrote:
> Other than that, the chances of getting this fixed are proportional to your
> skill in finding us a way of reproducing it.  A good start would be to tell
> us exactly which commands were used to set up the LVM and the raid array. 
> That way a raid/LVM ignoramus like me can take a look ;)
> 

In case any of this is of interest...

# cat /proc/mdstat 
Personalities : [raid1] [raid5] 
md0 : active raid5 sde1[4] sdd1[3] sdc1[2] sdb1[1] sda1[0]
      573487616 blocks level 5, 128k chunk, algorithm 2 [5/5] [UUUUU]
      
unused devices: <none>

# pvdisplay /dev/md0
  --- Physical volume ---
  PV Name               /dev/md0
  VG Name               vg0
  PV Size               546.92 GB / not usable 0   
  Allocatable           yes 
  PE Size (KByte)       4096
  Total PE              140011
  Free PE               62699
  Allocated PE          77312
  PV UUID               a76cj4-Fvnf-xkY8-bE0j-Wcdk-jtb0-mq9NbF
   
# vgdisplay vg0
  --- Volume group ---
  VG Name               vg0
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  37
  VG Access             read/write
  VG Status             resizable
  MAX LV                256
  Cur LV                36
  Open LV               36
  Max PV                256
  Cur PV                1
  Act PV                1
  VG Size               546.92 GB
  PE Size               4.00 MB
  Total PE              140011
  Alloc PE / Size       77312 / 302.00 GB
  Free  PE / Size       62699 / 244.92 GB
  VG UUID               EameBy-n1m#-cwNa-rKqz-YqoM-hSEH-BKVeQQ
   
# lvdisplay 
  --- Logical volume ---
  LV Name                /dev/vg0/home
  VG Name                vg0
  LV UUID                yQFLXG-KLog-TdWQ-Rvis-35U1-jUj1-zO0h3M
  LV Write Access        read/write
  LV Status              available
  # open                 1
  LV Size                25.00 GB
  Current LE             6400
  Segments               1
  Allocation             next free (default)
  Read ahead sectors     0
  Block device           253:0
   
[...35 more...]

-ryan
