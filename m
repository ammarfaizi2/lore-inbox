Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVFMSOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVFMSOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVFMSOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:14:16 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:18577 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261177AbVFMSOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:14:08 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
Date: Tue, 14 Jun 2005 04:13:58 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <hlira1pdvh0hsk3mui9m9ghk949ljm4v0l@4ax.com>
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com> <42AD6362.1000109@rainbow-software.org> <1118669975.13260.23.camel@localhost.localdomain>
In-Reply-To: <1118669975.13260.23.camel@localhost.localdomain>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005 14:39:37 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>On Llu, 2005-06-13 at 11:43, Ondrej Zary wrote:
>> I see this problem too with i430TX chipset (the south bridge and thus 
>> IDE controller is the same as in i440LX/EX and BX/ZX).
>
>Make sure you have pre-empt disabled and the antcipatory I/O scheduler
>disabled. 
I don't set pre-empt, not sure about scheduler, recheck that in daytime,
SATA (Via chipset) on different box doesn't have the problem, neither 
another box with SATA and ICH5, this is Via chipset, two runs after boot:

Linux 2.4.31-sp

root@sempro:~# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   1172 MB in  2.00 seconds = 586.00 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
 Timing buffered disk reads:  172 MB in  3.02 seconds =  56.95 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
root@sempro:~# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   1056 MB in  2.00 seconds = 528.00 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
 Timing buffered disk reads:  170 MB in  3.00 seconds =  56.67 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
root@sempro:~#

Linux 2.6.11.12a

/dev/sda:
 Timing cached reads:   1308 MB in  2.00 seconds = 653.77 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
 Timing buffered disk reads:  170 MB in  3.00 seconds =  56.60 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
root@sempro:~# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   1124 MB in  2.00 seconds = 560.96 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
 Timing buffered disk reads:  170 MB in  3.00 seconds =  56.66 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
root@sempro:~#

HDD specified as 58MB/s at the fast end, so these figures look reasonable.
http://scatter.mine.nu/test/boxen/sempro/ for hardware / config info

--Grant.

