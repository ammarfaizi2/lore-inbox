Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129372AbRB1Xdp>; Wed, 28 Feb 2001 18:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129364AbRB1Xdg>; Wed, 28 Feb 2001 18:33:36 -0500
Received: from munch-it.turbolinux.com ([38.170.88.129]:6383 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S129372AbRB1Xd1>;
	Wed, 28 Feb 2001 18:33:27 -0500
Date: Wed, 28 Feb 2001 15:37:09 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: linux-kernel@vger.kernel.org
Subject: Verbose debug messages when accessing /dev/fd0
Message-ID: <20010228153709.C10049@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkml.

	when i do a
	fd = open( "/dev/fd0", O_WRONLY );

	in 2.4.2 series kernels, i get these messages on the console:

psubash kernel: floppy0: reschedule timeout lock fdc
psubash kernel: floppy0: reschedule timeout redo fd request
psubash kernel: floppy0: reschedule timeout redo fd request
psubash kernel: floppy0: checking disk change line for drive 0
psubash kernel: floppy0: jiffies=34789296
psubash kernel: floppy0: disk change line=80
psubash kernel: floppy0: flags=2
psubash kernel: queue fd request dtime=2
psubash kernel: floppy0: reschedule timeout floppy start
psubash kernel: floppy0: setting NEWCHANGE in floppy_start
psubash kernel: floppy0: calling disk change from floppy_ready
psubash kernel: floppy0: checking disk change line for drive 0
psubash kernel: floppy0: jiffies=34789296
psubash kernel: floppy0: disk change line=80
psubash kernel: floppy0: flags=6
psubash kernel: floppy0: calling disk change from seek
psubash kernel: recalibrate floppy: dtime=2
psubash kernel: recal interrupt: dtime=2
psubash kernel: floppy0: calling disk change from floppy_ready
psubash kernel: floppy0: checking disk change line for drive 0
psubash kernel: floppy0: jiffies=34789296
psubash kernel: floppy0: disk change line=80
psubash kernel: floppy0: flags=6
psubash kernel: floppy0: calling disk change from seek
psubash kernel: seek command: dtime=2
psubash kernel: seek interrupt: dtime=3
psubash kernel: floppy0: clearing NEWCHANGE flag because of effective seek=

psubash kernel: floppy0: jiffies=34789297
psubash kernel: floppy0: calling disk change from floppy_ready
psubash kernel: floppy0: checking disk change line for drive 0
psubash kernel: floppy0: jiffies=34789299
psubash kernel: floppy0: disk change line=80
psubash kernel: floppy0: flags=2
psubash kernel: floppy0: calling disk change from seek
psubash kernel: floppy0: checking disk change line for drive 0
psubash kernel: floppy0: jiffies=34789299
psubash kernel: floppy0: disk change line=80
psubash kernel: floppy0: flags=2
psubash kernel: floppy0: reschedule timeout request done 0
psubash kernel: end_request: I/O error, dev 02:00 (floppy), sector 0
psubash kernel: floppy0: calling disk change from set_dor
psubash kernel: floppy0: checking disk change line for drive 0
psubash kernel: floppy0: jiffies=34789590
psubash kernel: floppy0: disk change line=80
psubash kernel: floppy0: flags=12

the last 4 lines showup after 2-3 seconds as I guess they are from the bottom halves.

To prevent this from writing all over my text based app I have to flank the open() with syslog()'s.

On a 2.2 kernel I get 2 debug lines instead (from end_request).

Are the log levels correct for these debug messages ?

Thanks,
-- 
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | Your heart is pure, and your mind clear,
of a GNU generation   -o)  | and your soul devout. 
Kernel 2.4.2-ac3      /\\  | 
on a i686            _\\_v | 
                           | 
------------------------------------------------------------------------
