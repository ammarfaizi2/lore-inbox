Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135451AbRA0Ux3>; Sat, 27 Jan 2001 15:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135476AbRA0UxT>; Sat, 27 Jan 2001 15:53:19 -0500
Received: from smtp-rt-8.wanadoo.fr ([193.252.19.51]:26523 "EHLO
	lantana.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S135451AbRA0UxD>; Sat, 27 Jan 2001 15:53:03 -0500
Message-ID: <3A733529.667E22DB@iupmime.univ-lemans.fr>
Date: Sat, 27 Jan 2001 21:52:57 +0100
From: Yann Droneaud <yann.droneaud@iupmime.univ-lemans.fr>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: check_dis(c|k)_change(|d): duplicated code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking up linux code to find why /proc/partitions report 'hdc' instead
of 'ide/host0/bus1/target0/lun0/cd'

example:
--------
major minor  #blocks  name

   8     0    1048575 scsi/host0/bus0/target6/lun0/disc
   3     0    3140928 ide/host0/bus0/target0/lun0/disc
   3     1       4000 ide/host0/bus0/target0/lun0/part1
   3     2    3132864 ide/host0/bus0/target0/lun0/part2
   3    64    3167640 ide/host0/bus0/target1/lun0/disc
   3    65          1 ide/host0/bus0/target1/lun0/part1
   3    67     899136 ide/host0/bus0/target1/lun0/part3
   3    68     165312 ide/host0/bus0/target1/lun0/part4
   3    69    1052289 ide/host0/bus0/target1/lun0/part5
   3    70     983776 ide/host0/bus0/target1/lun0/part6
   3    71      64480 ide/host0/bus0/target1/lun0/part7
  22     0     648180 hdc


I found a strange thing 
     in 'fs/block_dev.c' there's a function  'check_disk_change'
 and in 'fs/devfs/base.c' there's a function 'check_disc_changed'
 They done exactly the same job. I think that one of these must be rewritted to
 call the other and it's not to me to tell you which one :-).

--
Yann Droneaud <yann.droneaud@iupmime.univ-lemans.fr>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
