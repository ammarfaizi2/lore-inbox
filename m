Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267824AbRGZXsf>; Thu, 26 Jul 2001 19:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268735AbRGZXsY>; Thu, 26 Jul 2001 19:48:24 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:1042 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S267824AbRGZXsP>;
	Thu, 26 Jul 2001 19:48:15 -0400
Date: Fri, 27 Jul 2001 01:48:20 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: LVM <-> IDE: Wrong usage count?
Message-ID: <20010727014820.A8892@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi!

I've got some little box which consists mainly of a SCSI HDD (used
as system disk) and a LV (to hold data):

db-pg:~# uname -a
Linux mirror 2.4.7 #1 Mon Jul 23 12:56:36 CEST 2001 i686 unknown
db-pg:~# mount
/dev/sda3 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda1 on /boot type ext2 (rw)
/dev/data_vg/data_lv on /home/data type ext2 (rw)

data_vg consists currently of one IDE HDD. Because IDE is not
needed for boot-up, it's build as modules. However, IDE module's
use count is zero ATM, which is a bad think (TM) IMHO:

db-pg:~# lsmod 
Module                  Size  Used by
rtc                     5408   0  (autoclean)
nfs                    73104   1  (autoclean)
lockd                  49104   1  (autoclean) [nfs]
sunrpc                 60880   1  (autoclean) [nfs lockd]
3c59x                  25184   1  (autoclean)
lvm-mod                40624   2 
ide-disk                6784   0 
ide-probe-mod           8240   0 
ide-mod                62000   0  [ide-disk ide-probe-mod]
apm                     9040   0  (unused)
unix                   15040  34  (autoclean)

Is lvm-mod's use count correct? Two seems one too much. And the IDE
module's use count seems to be wrong, too. They should be higher.
I could try to rmmod(8) ide-*, but I fear to loose the volume:-)

Could you please enlighten me WRT LVM's and IDE's use count?

MfG, JBG
