Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbQLGSer>; Thu, 7 Dec 2000 13:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLGSeh>; Thu, 7 Dec 2000 13:34:37 -0500
Received: from 212-140-94-250.btopenworld.com ([212.140.94.250]:39431 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130093AbQLGSeV>;
	Thu, 7 Dec 2000 13:34:21 -0500
Date: Thu, 7 Dec 2000 18:05:09 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test9 Root no longer permitted to format floppies?
In-Reply-To: <Pine.LNX.3.95.1001207114503.171A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0012071802050.2182-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there was an issue with floppy ioctls and permission checks in block
device ->open routine recently. Just use test12-pre7 or other sufficiently
recent kernel and it will work.

If you _do_ want to know what's going on -- look for the thread where I
reported that floppies can't me mounted readonly, then AV proposed the
fix, then it turned out that Alain Knaff forgot to put his name in the
MAINTAINERS file so we didn't tell him about the fix and it apparently
broke some userspace tools. Later on, it was fixed in a way that makes
everyone happy.

Regards,
Tigran

 On Thu, 7 Dec 2000, Richard B. Johnson
wrote:

> 
> Script started on Thu Dec  7 11:44:01 2000
> # fdformat /dev/fd0h1440
> Double-sided, 80 tracks, 18 sec/track. Total capacity 1440 kB.
> Formatting ... 
> ioctl(FDFMTBEG): Operation not permitted
> # exit
> exit
> Script done on Thu Dec  7 11:44:42 2000
> 
> Who do you have to be in order to format floppy drives? Or have all
> the ioctl numbers been changed since 2.2.18 ?
> 
> write(1, "Double-sided, 80 tracks, 18 sec/"..., 63) = 63
> write(1, "Formatting ... ", 15)         = 15
> ioctl(3, 0x247, 0)                      = -1 EPERM (Operation not permitted)
> brk(0)                                  = 0x804af98
> brk(0x804afe8)                          = 0x804afe8
> brk(0x804b000)                          = 0x804b000
> brk(0x804c000)                          = 0x804c000
> 
> 
> It looks like they should still be okay?
> 
> fd.h:#define FDFMTBEG _IO(2,0x47)
> fd.h:#define	FDFMTTRK _IOW(2,0x48, struct format_descr)
> fd.h:#define FDFMTEND _IO(2,0x49)
> 
> Maybe a broken MACRO?
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
