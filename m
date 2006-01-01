Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWAAWXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWAAWXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWAAWXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 17:23:16 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:51608 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932276AbWAAWXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 17:23:15 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Steven J. Hathaway" <shathawa@e-z.net>, andre@linux-ide.org,
       axobe@suse.de, linux-kernel@vger.kernel.org, andre@linuxdiskcert.org
Subject: Re: PROBLEM: Linux ATAPI CDROM ->FIX: SAMSUNG CD-ROM SC-140
Date: Mon, 02 Jan 2006 09:23:03 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <8mkgr1p00i4c6jf3ej9t77rbd3kpo7s001@4ax.com>
References: <43B6146C.60E044FF@e-z.net> <1136030788.28365.49.camel@localhost.localdomain>
In-Reply-To: <1136030788.28365.49.camel@localhost.localdomain>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 12:06:28 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>On Gwe, 2005-12-30 at 21:17 -0800, Steven J. Hathaway wrote:
>> The fix is to add the following record to the drive_blacklist[] table.
>> 
>>      { "SAMSUNG CD-ROM SC-140",  "ALL" },
>
>This is not a fix since you said before the drive worked back in 2.4.20.
>You need to find out what in 2.4.20-21 broke the support rather than
>just turning it off.
>
>You could equally just use hdparm -d0 until you fix it.

I have a similar issue with a 'SAMSUNG SC-140B' CDROM in 2.4.latest 
and also 2.6.latest.  

hdparm -d0 /dev/hdc + hdparm -X8 /dev/hdc fixes it :(  

I updated the CDROM firmware, no change.  With 2.4.33-pre1:
syslog:
Jan  2 09:02:33 niner kernel: hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Jan  2 09:02:33 niner kernel: hdc: drive_cmd: error=0x04Aborted Command
Jan  2 09:02:52 niner kernel: hdc: CHECK for good STATUS
Jan  2 09:03:26 niner kernel: hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }

CDROM is stuck at the moment:
root       279  0.0  0.3   1688   612 ttyp1    D+   09:03   0:00 mount /dev/hdc /mnt/cdrom/

Should I ignore this and replace the CDROM or blacklist the thing?

The box here is a s/h thing I've had for only a month, no history 
for you.  What other testing you suggest to narrow the thing down?

Hmm, while I wrote this, the driver recovered, syslog:
Jan  2 09:18:28 niner kernel: hdc: media error (bad sector): error=0x34
Jan  2 09:18:28 niner kernel: end_request: I/O error, dev 16:00 (hdc), sector 60
Jan  2 09:18:43 niner kernel: hdc: DMA interrupt recovery
Jan  2 09:18:43 niner kernel: hdc: lost interrupt
Jan  2 09:18:43 niner kernel: hdc: status timeout: status=0xd0 { Busy }
Jan  2 09:18:43 niner kernel: hdc: status timeout: error=0x00
Jan  2 09:18:43 niner kernel: hdc: drive not ready for command
Jan  2 09:18:43 niner kernel: hdc: ATAPI reset complete

Box info: http://bugsplatter.mine.nu/test/boxen/niner/ this is same 
box I tickled an oops out of under 2.6.14.5 playing with the CDROM.

Thanks,
Grant.
