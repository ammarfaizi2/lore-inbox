Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275754AbRI0Drp>; Wed, 26 Sep 2001 23:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275755AbRI0Drf>; Wed, 26 Sep 2001 23:47:35 -0400
Received: from alb-66-24-188-79.nycap.rr.com ([66.24.188.79]:29057 "EHLO
	nycap.rr.com") by vger.kernel.org with ESMTP id <S275754AbRI0Dra>;
	Wed, 26 Sep 2001 23:47:30 -0400
Message-ID: <3BB2A19D.1FB6D91A@nycap.rr.com>
Date: Wed, 26 Sep 2001 23:48:45 -0400
From: Ken Zalewski <kennyz@nycap.rr.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kennyz@nycap.rr.com, zalewski@docdev.com
Subject: linux kernel 2.4.10 possibly breaks LILO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:

Modifying /etc/lilo.conf and running "lilo" when using kernel version
2.4.10 does not appear to modify the boot sector accordingly, even
though I receive no errors or warnings.  On next reboot, LILO is
configured as it was previous to my changes.  I am therefore unable to
modify LILO configuration in any way while using 2.4.10.


Machine summary:

AMD Athlon 1 GHz
VIA 686b southbridge
512 MB PC133 SDRAM
/dev/hda = 30 GB Western Digital ATA-100 drive
/dev/hda1 is root partition and active partition
Linux 2.4.10
LILO 21.7-5


Details:

I recently built the latest 2.4.10 kernel from source and installed it
(upgraded from 2.4.7).  Ran "lilo", and the new image booted and I was
happily running 2.4.10.  I then made some changes to /etc/lilo.conf,
re-ran "lilo", and rebooted.  On reboot, the my changes were not
apparent, and the previous configuration was used.

I began experimenting more, making drastic changes to /etc/lilo.conf. 
No matter what I did to lilo.conf (even changing from "linear" to
"lba32" and back), running "lilo" produced no change to the startup.

I used a floppy to boot into 2.4.7, ran "lilo", rebooted, and noticed
that my changes had registered.

I then built kernel version 2.4.9, and did the same experiment.  My
change to /etc/lilo.conf registered fine on the next reboot.

As a result, I have concluded that something has changed between 2.4.9
and 2.4.10 that causes LILO to be unable to overwrite the boot sector of
the active partition.  I also tried using LILO 22.0-beta, and the
problem persisted.

My kernel configurations for both 2.4.9 and 2.4.10 are almost identical.

I do not know if this is something specific to my own machine, but it is
consistently reproducible.  I have used versions 2.4.5, 2.4.7, 2.4.9,
and 2.4.10, and LILO fails to work ONLY on 2.4.10.  No errors are
printed by LILO, and doing "lilo -q -v" before rebooting seems to
indicate that everything happened properly (though I think that only
reads the map file, not the actual boot sector).

I would appreciate a response regarding this issue.  I have not seen
anything posted about this yet, so it could be something specific to my
machine - it's just strange that it just started happening on 2.4.10.

Thanks for any assistance you can provide.

-- 
Ken Zalewski -- Director of Information Technology
Document Development Corporation
1223 Peoples Avenue, Troy, NY 12180
kennyz@nycap.rr.com   http://www.cs.rpi.edu/~kennyz/
