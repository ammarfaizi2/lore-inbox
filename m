Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130252AbRB1QRN>; Wed, 28 Feb 2001 11:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRB1QRB>; Wed, 28 Feb 2001 11:17:01 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22917 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130252AbRB1QQ3>; Wed, 28 Feb 2001 11:16:29 -0500
Date: Wed, 28 Feb 2001 11:16:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jens Axboe <axboe@suse.de>
cc: Holluby István <holluby@interware.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: mke2fs /dev/loop0
In-Reply-To: <20010228164151.H21518@suse.de>
Message-ID: <Pine.LNX.3.95.1010228111048.5030A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Jens Axboe wrote:

> On Wed, Feb 28 2001, Richard B. Johnson wrote:
> > `mke2fs /dev/loop0`  requires an additional parameter (file size to
> > create). Otherwise, it will try to use all the RAM in your system, plus...
> > 
> > If it worked before, it was because of luck. FYI, this is not the
> > way to create a ramdisk. Normally you use the loop device to mount
> > a file as a file-system, i.e., `mount -o loop filename /mnt`.
> > So, I don't know what you are trying to do except crash your system.
> 
> This could not be more wrong. mke2fs will query the size of the
> loop device, and make the correct size file system regardless
> of whether it's file or block device backed. And it will not
> try to use all RAM in the system?! This is loop, not a ramdisk.
> Dirty buffers will be flushed to loop like any other block
> device in the system, if that doesn't work then we have a mm
> bug.
> 
> The previous answer was right -- loop has been broken for quite
> some time, but use -ac latest on top of 2.4.2 and it should work
> flawlessly for you.
> 

Wrong. The report showed a response to a command. Nothing was reported
to have been mounted through the loop device. Instead, the raw command
`mke2fs /dev/loop0` was reported. Performing such a command on early
linux versions resulted in this:

Script started on Wed Feb 28 11:10:11 2001
mke2fs /dev/loop0
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
mke2fs: Device size reported to be zero.  Invalid partition specified, or
	partition table wasn't reread after running fdisk, due to
	a modified partition being busy and in use.  You may need to reboot
	to re-read your partition table.

# exit
exit

Script done on Wed Feb 28 11:10:33 2001

This prevented you from killing the system during such a dumb command.

Later versions, resulted in the system halting with no activity. Again,
a pretty good result for such a dumb command.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


