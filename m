Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130642AbRAEXmZ>; Fri, 5 Jan 2001 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRAEXmU>; Fri, 5 Jan 2001 18:42:20 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:60604 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S131035AbRAEXmD>; Fri, 5 Jan 2001 18:42:03 -0500
Date: Sat, 6 Jan 2001 00:41:56 +0100
From: David Weinehall <tao@acc.umu.se>
To: Tim Waugh <twaugh@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: suser() check audit Was: [patch] 2.4.0: lp superuser check
Message-ID: <20010106004156.C27416@khan.acc.umu.se>
In-Reply-To: <20010105171632.N5253@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010105171632.N5253@redhat.com>; from twaugh@redhat.com on Fri, Jan 05, 2001 at 05:16:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 05:16:32PM +0000, Tim Waugh wrote:
> Here is a patch that changes the superuser check in lp to use
> capabilities instead.

Just for the fun (?) of it, I made a grep/visual inspection for all
occurences of suser/fsuser, and found the following:

./fs/ufs/balloc.c -- 1 occurence of fsuser
./include/linux/sched.h -- def. of suser/fsuser
./include/linux/compatmac.h -- compability-macro for suser
./drivers/net/wan/lmc/lmc_main.c -- 7 occurences of suser
./drivers/net/pcmcia/xircom_tulip_cb.c -- 1 occurence of suser
./drivers/block/cciss.c -- 2 occurences of suser
./drivers/block/cpqarray.c -- 3 occurences of suser
./drivers/block/swim3.c -- 1 occurence of suser
./drivers/block/swim_iop.c -- 1 occurence of suser
./drivers/char/console.c -- 2 occurences of suser
./drivers/char/tty_ioctl.c -- 4 occurences of suser
./drivers/char/tty_io.c -- 1 occurence of suser
./drivers/char/lp.c -- 1 occurence of suser
./drivers/char/vt.c -- 4 occurences of suser
./drivers/char/esp.c -- 1 occurences of suser
./drivers/char/tpqic02.c -- 2 occurences of suser
./drivers/char/rocket.c -- 1 occurence of suser
./drivers/char/sx.c -- 1 occurence of suser
./drivers/char/dz.c -- 1 occurence of suser
./drivers/char/isicom.c -- 1 occurence of suser
./drivers/char/mxser.c -- 2 occurence of suser
./drivers/char/serial167.c -- 1 occurence of suser
./drivers/char/ip2main.c -- 1 occurence of suser
./drivers/char/rio/rio_linux.c -- 1 occurence of suser
./drivers/char/moxa.c -- 1 occurence of suser
./drivers/scsi/cpqfcTSinit.c -- 1 occurence of suser
./drivers/sbus/char/vfc_dev.c -- 1 occurence of suser
./drivers/sbus/char/aurora.c -- 1 occurence of suser
./drivers/tc/zs.c -- 1 occurence of suser
./drivers/pcmcia/ds.c -- 1 occurence of suser
./drivers/s390/block/mdisk.c -- 2 occurences of suser
./drivers/media/video/zr36120.c -- 1 occurence of suser
./arch/i386/kernel/mtrr.c --  9 occurences of suser
./arch/sparc/kernel/pcic.c -- 2 occurences of suser
./arch/m68k/bvme6000/rtc.c -- 1 occurence of suser
./arch/m68k/mvme16x/rtc.c -- 1 occurence of suser
./arch/sparc64/kernel/ioctl32.c -- 1 occurence of suser


Anyone who recognises his/her area of responsibility here or feels
guilty about it anyway, should have a look to see what capability is
best to replace it with.

A goal that isn't too unrealistic IMHO is to have all calls to suser/fsuser
and the calls themselves removed by v2.4.5 or so.

Comments?!


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
