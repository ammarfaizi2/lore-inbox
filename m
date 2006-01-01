Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWAAXUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWAAXUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 18:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAAXUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 18:20:54 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:54450 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932286AbWAAXUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 18:20:53 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gcoady@gmail.com, "Steven J. Hathaway" <shathawa@e-z.net>,
       andre@linux-ide.org, axobe@suse.de, linux-kernel@vger.kernel.org,
       andre@linuxdiskcert.org
Subject: Re: PROBLEM: Linux ATAPI CDROM ->FIX: SAMSUNG CD-ROM SC-140
Date: Mon, 02 Jan 2006 10:20:49 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <moogr199qip5umq269ol1qscjon3tr1a07@4ax.com>
References: <43B6146C.60E044FF@e-z.net> <1136030788.28365.49.camel@localhost.localdomain> <8mkgr1p00i4c6jf3ej9t77rbd3kpo7s001@4ax.com> <1136154895.23870.16.camel@localhost.localdomain>
In-Reply-To: <1136154895.23870.16.camel@localhost.localdomain>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Jan 2006 22:34:55 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>On Llu, 2006-01-02 at 09:23 +1100, Grant Coady wrote:
>> Jan  2 09:02:33 niner kernel: hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
>> Jan  2 09:02:33 niner kernel: hdc: drive_cmd: error=0x04Aborted Command
>> Jan  2 09:02:52 niner kernel: hdc: CHECK for good STATUS
>> Jan  2 09:03:26 niner kernel: hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
>
>Thats showing a media error. Shouldn't have caused a hang however.
>
Solved (sort of):
login as: root
Authenticating with public key "grant@peetoo" from agent
Last login: Mon Jan  2 10:10:08 2006 from magpie.squishybuglet.mine.nu
Linux 2.4.33-pre1.

The grass is always greener on the other side of your sunglasses.

root@niner:~# dmesg |grep hdc
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: LTN526D, ATAPI CD/DVD-ROM drive
hdc: attached ide-cdrom driver.
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
root@niner:~# mount /dev/hdc /mnt/cdrom/
mount: block device /dev/hdc is write-protected, mounting read-only
root@niner:~# ls /mnt/cdrom/
CHECKSUMS.md5  CHECKSUMS.md5.asc  FILELIST.TXT  README.TXT  pasture/  source/  zipslack/
root@niner:~# hdparm -I /dev/hdc

/dev/hdc:

ATAPI CD-ROM, with removable media
        Model Number:       LTN526D
        Serial Number:
        Firmware Revision:  9S01
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

That's the same (stamped) CD I used before with the Samsung, maybe I 
can use the Samsung for error testing libata PATA when it gets here ;)

Cheers,
Grant.
