Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTLHERx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 23:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbTLHERx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 23:17:53 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:61199 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265326AbTLHERu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 23:17:50 -0500
Message-ID: <3FD3FFB9.40305@nishanet.com>
Date: Sun, 07 Dec 2003 23:36:09 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord hangs my computer
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org> <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org> <20031206220227.GA19016@work.bitmover.com>
In-Reply-To: <20031206220227.GA19016@work.bitmover.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>On Sat, Dec 06, 2003 at 01:57:03PM -0800, Linus Torvalds wrote:
>  
>
>>>		 On every PC I have that has an ide cd drive, I use
>>>ide-scsi.  I like the fact that scd0 is the cdrom drive.
>>>      
>>>
>>And you liked the fact that you were supposed to write "dev=0,0,0" or
>>something strange like that? What a piece of crap it was.
>>    
>>
>
>Hey, that "piece of crap" has burned one heck of a lot of ISO images of
>Linux over the years.  How about a nod of thanks to the author before you
>tell him you don't like his interface?  And how about acknowledgement that
>he made that "piece of crap" work on a lot of different Unix platforms?
>  
>
Naming "1,0,0" won't work everywhere for me.

I started using a 3ware ide card because promise and siig sis
were crashing nforce2, so it's a unified concept ;-) to use
ide-scsi scsi-sg for hd's on 3ware and for cdr cdrw. I can rip from
cdr through pipes to yamaha cdrw, pre-emptive kernel, anticipatory
sched, use dma, devfs. The only quirk is naming "1,0,0" won't work
everywhere--

#/etc/default/cdrecord
CDR_DEVICE=ATAPI:/dev/scsi/host1/bus0/target0/lun0/generic
# ATAPI:1,0,0 won't work in CDR_DEVICE but below it does--
yamaha=   ATAPI:1,0,0   -1      -1      ""

#/usr/src/linux/.config--
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_IDEDISK is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y

# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=y

-Bob D



