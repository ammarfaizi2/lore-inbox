Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWAERkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWAERkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWAERkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:40:19 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:9140 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751864AbWAERkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:40:18 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <autofs@linux.kernel.org>, <raven@themaw.net>
Subject: Re: [linux-usb-devel] Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs uninterruptable sleep
References: <Pine.LNX.4.44L0.0601051143480.5520-100000@iolanthe.rowland.org>
Date: Thu, 05 Jan 2006 17:39:52 +0000
In-Reply-To: <Pine.LNX.4.44L0.0601051143480.5520-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Thu, 5 Jan 2006 11:45:31 -0500 (EST)")
Message-ID: <87fyo2k1zr.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Alan Stern <stern@rowland.harvard.edu> writes:

> On Thu, 5 Jan 2006, Roger Leigh wrote:
>
>> With some further testing with both usb-storage and ub, both show the
>> same behaviour when using autofs4 _or_ autofs.  When mounting by hand,
>> the problem does not occur.  While broken on 2.6.15 and 2.6.14, it
>> does appear to work on 2.6.13; I can't test earlier kernels at the
>> moment because of udev--I'll have to remove it first.
>
> By any chance, does autofs or autofs4 mount your device with -o sync?  
> Doing that with flash memory devices is a grave mistake -- although it 
> shouldn't cause the sort of lock-up you described.

Yes.  I have

pen-secure  -fstype=ext2,sync,nodev,nosuid,noatime  :/dev/sda2

in /etc/auto.misc.  Removing the sync option does prevent the lockups.
I just added it back and it locked up immediately.

The usb/usb-storage logs are attached (device mount + command which
broke it).  Would you like any more information?


Regards,
Roger

-- 
Roger Leigh
                Printing on GNU/Linux?  http://gimp-print.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your mail.

--=-=-=
Content-Disposition: inline; filename=log
Content-Description: kern.log

Jan  5 17:31:44 hardknott kernel: usb-storage: queuecommand called
Jan  5 17:31:44 hardknott kernel: usb-storage: *** thread awakened.
Jan  5 17:31:44 hardknott kernel: usb-storage: Command WRITE_10 (10 bytes)
Jan  5 17:31:44 hardknott kernel: usb-storage:  2a 00 00 02 fc 02 00 00 04 00
Jan  5 17:31:44 hardknott kernel: usb-storage: Bulk Command S 0x43425355 T 0xea L 2048 F 0 Trg 0 LUN 0 CL 10
Jan  5 17:31:44 hardknott kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jan  5 17:31:44 hardknott kernel: usb-storage: Status code 0; transferred 31/31
Jan  5 17:31:44 hardknott kernel: usb-storage: -- transfer complete
Jan  5 17:31:44 hardknott kernel: usb-storage: Bulk command transfer result=0
Jan  5 17:31:44 hardknott kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 2048 bytes, 1 entries
Jan  5 17:31:44 hardknott kernel: usb-storage: Status code 0; transferred 2048/2048
Jan  5 17:31:44 hardknott kernel: usb-storage: -- transfer complete
Jan  5 17:31:44 hardknott kernel: usb-storage: Bulk data transfer result 0x0
Jan  5 17:31:44 hardknott kernel: usb-storage: Attempting to get CSW...
Jan  5 17:31:44 hardknott kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jan  5 17:31:44 hardknott kernel: usb-storage: Status code 0; transferred 13/13
Jan  5 17:31:44 hardknott kernel: usb-storage: -- transfer complete
Jan  5 17:31:44 hardknott kernel: usb-storage: Bulk status result = 0
Jan  5 17:31:44 hardknott kernel: usb-storage: Bulk Status S 0x53425355 T 0xea R 0 Stat 0x0
Jan  5 17:31:44 hardknott kernel: usb-storage: scsi cmd done, result=0x0
Jan  5 17:31:44 hardknott kernel: usb-storage: *** thread sleeping.
Jan  5 17:31:55 hardknott kernel: usb-storage: queuecommand called
Jan  5 17:31:55 hardknott kernel: usb-storage: *** thread awakened.
Jan  5 17:31:55 hardknott kernel: usb-storage: Command WRITE_10 (10 bytes)
Jan  5 17:31:55 hardknott kernel: usb-storage:  2a 00 00 02 fc 0a 00 00 02 00
Jan  5 17:31:55 hardknott kernel: usb-storage: Bulk Command S 0x43425355 T 0xeb L 1024 F 0 Trg 0 LUN 0 CL 10
Jan  5 17:31:55 hardknott kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jan  5 17:31:55 hardknott kernel: usb-storage: Status code 0; transferred 31/31
Jan  5 17:31:55 hardknott kernel: usb-storage: -- transfer complete
Jan  5 17:31:55 hardknott kernel: usb-storage: Bulk command transfer result=0
Jan  5 17:31:55 hardknott kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 1024 bytes, 1 entries
Jan  5 17:31:55 hardknott kernel: usb-storage: Status code 0; transferred 1024/1024
Jan  5 17:31:55 hardknott kernel: usb-storage: -- transfer complete
Jan  5 17:31:55 hardknott kernel: usb-storage: Bulk data transfer result 0x0
Jan  5 17:31:55 hardknott kernel: usb-storage: Attempting to get CSW...
Jan  5 17:31:55 hardknott kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jan  5 17:31:55 hardknott kernel: usb-storage: Status code 0; transferred 13/13
Jan  5 17:31:55 hardknott kernel: usb-storage: -- transfer complete
Jan  5 17:31:55 hardknott kernel: usb-storage: Bulk status result = 0
Jan  5 17:31:55 hardknott kernel: usb-storage: Bulk Status S 0x53425355 T 0xeb R 0 Stat 0x0
Jan  5 17:31:55 hardknott kernel: usb-storage: scsi cmd done, result=0x0
Jan  5 17:31:55 hardknott kernel: usb-storage: *** thread sleeping.

--=-=-=--
