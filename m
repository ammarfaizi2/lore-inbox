Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSFTQmL>; Thu, 20 Jun 2002 12:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSFTQmK>; Thu, 20 Jun 2002 12:42:10 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14095 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315278AbSFTQla> convert rfc822-to-8bit; Thu, 20 Jun 2002 12:41:30 -0400
Message-ID: <3D1205B1.2090204@evision-ventures.com>
Date: Thu, 20 Jun 2002 18:41:21 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Paul Bristow <paul@paulbristow.net>,
       Gadi Oxman <gadio@netvision.net.il>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
References: <Pine.SOL.4.30.0206201832420.23175-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Bartlomiej Zolnierkiewicz napisa³:
> On Thu, 20 Jun 2002, Martin Dalecki wrote:
> 
> 
>>U¿ytkownik Jens Axboe napisa³:
>>
>>>On Thu, Jun 20 2002, Martin Dalecki wrote:
>>>
>>>
>>>>U?ytkownik Jens Axboe napisa?:
>>>>
>>>>
>>>>>On Wed, Jun 19 2002, Bartlomiej Zolnierkiewicz wrote:
>>>>>
>>>>>Looks pretty good in general, just one minor detail:
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>+
>>>>>>+/*
>>>>>>+ *	ATAPI packet commands.
>>>>>>+ */
>>>>>>+#define ATAPI_FORMAT_UNIT_CMD		0x04
>>>>>>+#define ATAPI_INQUIRY_CMD		0x12
>>>>>
>>>>>
>>>>>[snip]
>>>>>
>>>>>We already have the "full" list in cdrom.h (GPCMD_*), so lets just use
>>>>>that. After all, ATAPI_MODE_SELECT10_CMD _is_ the same as the SCSI
>>>>>variant (and I think the _CMD post fixing is silly, anyone familiar with
>>>>>this is going to know what ATAPI_WRITE10 means just fine)
>>>>>
>>>>>Same for request_sense, that is already generalized in cdrom.h as well.
>>>>
>>>>I wonder what FreeBSD is using here? I see no need for invention at
>>>>this place.
>>>
>>>
>>>The invention would be adding the ATAPI_* commands, Linux has used the
>>>GPCMD_ convention for quite some time now.
>>
>>Agreed. The ATAPI prefix would be confusing, since those are in reality SCSI
>>commands anyway...
> 
> 
> I think we should use scsi.h and get rid of GPCMD_* convention also.
> Jens, do you want "corrected" patch?

Yes that would be best / modulo possible name space clashes.
The names in scsi/scsi.h look too generic sometimes. Like:

#define TYPE_DISK           0x00
#define TYPE_TAPE           0x01
#define TYPE_PRINTER        0x02
#define TYPE_PROCESSOR      0x03    /* HP scanners use this */
#define TYPE_WORM           0x04    /* Treated as ROM by our system */
#define TYPE_ROM            0x05

or

/*
  *  Status codes
  */

#define GOOD                 0x00
#define BUSY                 0x04



