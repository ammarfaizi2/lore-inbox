Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRKFAdU>; Mon, 5 Nov 2001 19:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKFAdL>; Mon, 5 Nov 2001 19:33:11 -0500
Received: from genesis.westend.com ([212.117.67.2]:45189 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S276132AbRKFAdC>; Mon, 5 Nov 2001 19:33:02 -0500
Date: Tue, 6 Nov 2001 01:32:54 +0100
From: Christian Hammers <ch@westend.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Hammers <ch@westend.com>
Subject: Kernel BUG at namei.c:330!
Message-ID: <20011106013254.A7269@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This evening I experienced the following error on a system with kernel
2.4.11-pre6 with an Adaptex 7892A SCSI controller, a EasyRAIDII external 
RAID controller and an HP C1537A tape streamer on the same bus.
The error occured while the tape was writing (I reported similar problems 
a couple of weeks ago, but all patches on this list and all newer kernels
failed to fix it).

The messages (roughly transscripted from console before rebooting):
...
I/O error: dev: 08:02, sector 65704 		# mounted as "/"
...
Kernel BUG at namei.c:330!
invalid operand: 0000
CPU:0
EIP 0010:<c015c7e3> Not Tainted 	# c015c760 t reiserfs_find_entry
...
<4>st0: Error with sense data: Attention. Additional sense indicates
Poweron,reset,or bus device reset occur
I/O error: dev 08:02, secor 139192
...

/fs/reiserfs/namei.c at line 330:
       if (retval == IO_ERROR)
            // FIXME: still has to be dealt with

                                /* I want you to conform to our error
                                   printing standard.  How many times
                                   do I have to ask? -Hans */

            BUG ();
Well... "has to be dealt with"... the latest 2.4.14 at least says:
        if (retval == IO_ERROR)
            // FIXME: still has to be dealt with
            reiserfs_panic (dir->i_sb, "zam-7001: io error in " __FUNCTION__ "\n"


The error itself occured several times now, with slightly different error
messages (sometimes with nothing left on the console) but always
immediately or somewhen during the tape backup.

Thank you for reading this far and hopefully this mail helps anybody to 
improve anything. Contact me if you need further information.

thanks,

 -christian-

-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

