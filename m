Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131546AbQK2O4F>; Wed, 29 Nov 2000 09:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131559AbQK2Ozz>; Wed, 29 Nov 2000 09:55:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30336 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S131546AbQK2Ozl>; Wed, 29 Nov 2000 09:55:41 -0500
Date: Wed, 29 Nov 2000 09:24:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Hugh Dickins <hugh@veritas.com>
cc: Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.LNX.4.21.0011291147170.4021-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1001129091726.14820A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Hugh Dickins wrote:

> On Tue, 28 Nov 2000, Andries Brouwer wrote:
> > On Tue, Nov 28, 2000 at 03:04:31PM +0100, Rogier Wolff wrote:
> > 
> > > Ok, so if you read the standard carefully you get a bogus result. 
> > 
> > Why bogus? Things could have been otherwise, but the important
> > part is that all Unices do things the same way.
> 
> Yes, and I think you'll have difficulty, Andries, finding
> any other Unices which interpret the standard as you and
> Linux do: Solaris, HP-UX, UnixWare and OpenServer all allow
> writing to a device node (or FIFO) on read-only filesystem.
> 
> Hugh
> 

So does Linux. There may be a problem with access(), or a problem
with interpreting what it's supposed to do, but device-files and
FIFOs can be opened for write on a read/only file-system.

Script started on Wed Nov 29 09:14:36 2000
# mount -o remount,ro /alt
# cd /alt
# >foo
bash: foo: Read-only file system
# cd dev
# ls >tty   # Write to /dev/tty
FIRE	     hdb	   ptybe  ptyte   sda	     ttybb  ttytb    vcs31
GPIB	     hdb1	   ptybf  ptytf   sda1	     ttybc  ttytc    vcs32
MAKEDEV      hdb10	   ptyc0  ptyu0   sda10      ttybd  ttytd    vcs33
MAKEDEV.new  hdb11	   ptyc1  ptyu1   sda11      ttybe  ttyte    vcs34
NVRAM	     hdb12	   ptyc2  ptyu2   sda12      ttybf  ttytf    vcs35
VXI	     hdb13	   ptyc3  ptyu3   sda13      ttyc0  ttyu0    vcs36
[Snipped...]


hda9	     ptybd	   ptytd  scd1	  ttyba      ttyta  vcs30
# exit
exit

Script done on Wed Nov 29 09:15:49 2000

Linux `man` states that access() checks, in addition to a file, but
also any "file-system object". However, SunOS 5.5.1 talks about files
only.

It may be that access() is not supposed to be used to check the
accessibility of devices, and that only the Linux man page is incorrect.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
