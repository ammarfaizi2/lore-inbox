Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbUKFRFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUKFRFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 12:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUKFRFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 12:05:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35495 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261424AbUKFRFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 12:05:20 -0500
Message-ID: <418D043E.3090406@pobox.com>
Date: Sat, 06 Nov 2004 12:05:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] WIN_* -> ATA_CMD_* conversion: add new entries to
 ata.h
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com> <20041106032305.GB6060@taniwha.stupidest.org> <418D0066.9040002@pobox.com>
In-Reply-To: <418D0066.9040002@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Chris Wedgwood wrote:
> 
>> ===== include/linux/ata.h 1.19 vs edited =====
>> --- 1.19/include/linux/ata.h    2004-11-02 11:32:44 -08:00
>> +++ edited/include/linux/ata.h    2004-11-05 19:04:41 -08:00
>> @@ -122,6 +122,27 @@
>>      ATA_CMD_SET_FEATURES    = 0xEF,
>>      ATA_CMD_PACKET        = 0xA0,
>>  
>> +    /* ATA devices commands (used by legacy IDE code) */
>> +    ATA_CMD_NOP        = 0x00,
>> +    ATA_CMD_SRST        = 0x08,
>> +    ATA_CMD_RESTORE        = 0x10,
>> +    ATA_CMD_MULTREAD_EXT    = 0x29,
>> +    ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
>> +    ATA_CMD_MULTWRITE_EXT    = 0x39,
>> +    ATA_CMD_SPECIFY        = 0x91, /* set geom */
>> +    ATA_CMD_SMART        = 0xB0,
>> +    ATA_CMD_MULTREAD    = 0xC4,
>> +    ATA_CMD_MULTWRITE    = 0xC5,
>> +    ATA_CMD_MULTSET        = 0xC6,
>> +    ATA_CMD_DOORLOCK    = 0xDE,
>> +    ATA_CMD_DOORUNLOCK    = 0xDF,
>> +    ATA_CMD_STANDBYNOW1    = 0xE0,
>> +    ATA_CMD_IDLEIMMEDIATE    = 0xE1,
>> +    ATA_CMD_ID_ATA_DMA    = 0xEE,
>> +    ATA_CMD_READ_NATIVE_MAX    = 0xF8,
>> +    ATA_CMD_SET_MAX        = 0xF9,
>> +    ATA_CMD_SET_MAX_EXT    = 0x37,

oh, also:

Please check with ATA/ATAPI-7 command names, rather than just using the 
WIN_xxx names with a new prefix.  Sometimes the IDE author (from ages 
past) would pick names that suited them or the code, but diverged from 
the common T13 command name.

Examples:
1) WIN_DIAGNOSE -> ATA_CMD_EDD
2) WIN_QUEUED_SERVICE -> ATA_CMD_SERVICE
3) WIN_STANDBYNOW1 -> ATA_CMD_STANDBY_IMMED
4) WIN_SETIDLE1 -> ATA_CMD_IDLE
5) WIN_CHECKPOWERMODE1 -> ATA_CMD_CHK_PWR_MODE
6) WIN_SLEEPNOW1 -> ATA_CMD_SLEEP
7) some are old ATA-2-era commands, some are vendor-specific commands. 
Not much you can do about the naming of these.
8) remove all xxx_ONCE that are not used
9) hdreg.h lists commands in opcode value order
10) Kill WIN_SRST (dups properly named WIN_DEVICE_RESET)

	Jeff


