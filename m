Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbTDBTDB>; Wed, 2 Apr 2003 14:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbTDBTDB>; Wed, 2 Apr 2003 14:03:01 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:30463 "EHLO
	pd6mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S263143AbTDBTC6>; Wed, 2 Apr 2003 14:02:58 -0500
Date: Wed, 02 Apr 2003 11:14:42 -0800
From: Nehal <nehal@canada.com>
Subject: Re: mount hfs on SCSI cdrom = segfault
In-reply-to: <200304022101.40921.kiza@gmx.net>
To: Oliver Feiler <kiza@gmx.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <3E8B36A2.8030801@canada.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
References: <3E87477C.3050208@canada.com> <3E8B28B9.5090400@canada.com>
 <20030402104922.737d2ae9.rddunlap@osdl.org> <200304022101.40921.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yes, that's the one! its in grow_buffers ... there are 3 BUG() 's in
this function, but my guess he is getting the same BUG()

hmm, he didnt specify his cd-rom drive... but could it be
part of the problem?

Nehal

>Hi,
>
>is this the same problem as this one?
>http://marc.theaimsgroup.com/?l=linux-kernel&m=102890250915062&w=2
>
>Nobody ever answered on that, though.
>
>
>On Wednesday 02 April 2003 12:49, Randy.Dunlap wrote:
>  
>
>>First post said Linux 2.4.20... that's good info.
>>That info has been deleted from subsequent postings.
>>
>>Would it make sense for the BUG() message to include a kernel
>>version number???  I'm wondering since people do omit that data.
>>
>>~Randy
>>
>>On Wed, 02 Apr 2003 10:15:21 -0800 Nehal <nehal@canada.com> wrote:
>>| > i have a hybrid cd (both HFS, ISO9660) , i have two CD drives,
>>| > one IDE CD-Rom (actima 32x), and one SCSI CD-burner (yamaha 6416)
>>| > on an advansys cfg-510 ISA scsi card
>>| >
>>| > when i try to mount on IDE using hfs with:
>>| >
>>| >    mount -v -r -t hfs /dev/hdc /cdrom
>>| >
>>| > it works fine, yet when i try on scsi with:
>>| >
>>| >    mount -v -r -t hfs /dev/scd0 /cdrom
>>| >
>>| > i get a "Segmentation fault" error, no more output given,
>>| > it also locks the drive, and sometimes i can use the
>>| > 'eject' command to eject it, sometimes i cant and i gotta reboot
>>| >
>>| > note: when i try to mount the cd using regular iso9660 fs, it
>>| > works perfectly on both cd drives,
>>| > also i have tried 2 hybrid cd's, both times i have trouble mounting
>>| > hfs on the scsi drive only
>>| >
>>| > Nehal
>>|
>>| ok i updated firmware of writer from 1.0c to 1.0d with no help,
>>| but i found when i do 'dmesg' after mounting i get this error:
>>| ========
>>| kernel BUG at buffer.c:2518!
>>| invalid operand: 0000
>>| CPU:    0
>>| EIP:    0010:[<c013c329>]    Not tainted
>>| EFLAGS: 00013206
>>| eax: 000007ff   ebx: 00000b00   ecx: 00000800   edx: c11ee640
>>| esi: 00000b00   edi: 00000200   ebp: 00000b00   esp: c3425db4
>>| ds: 0018   es: 0018   ss: 0018
>>| Process mount (pid: 514, stackpage=c3425000)
>>| Stack: c6d0d760 c3425e48 c0257a59 c7f1c574 00000000 00000b00 00000200
>>| 00000000
>>|        c0139f66 00000b00 00000000 00000200 00000000 00000001 c7568400
>>| 00000000
>>|        c013a1e0 00000b00 00000000 00000200 00000000 c019280a 00000b00
>>| 00000000
>>| Call Trace:    [<c0257a59>] [<c0139f66>] [<c013a1e0>] [<c019280a>]
>>| [<c019188a>]
>>|   [<c01925ff>] [<c0285c30>] [<c013cdca>] [<c013e908>] [<c013d64b>]
>>| [<c013cd3c>]
>>|   [<c013d9a1>] [<c014fcf3>] [<c0150020>] [<c014fe69>] [<c0150441>]
>>| [<c01090ff>]
>>|
>>| Code: 0f 0b d6 09 9a 2b 33 c0 8d 87 00 fe ff ff 3d 00 0e 00 00 76
>>|
>>| root@Nehal:~#
>>| ========
>>| then when i try it again it doesnt give this message, it locks up my
>>| drive
>>|
>>| can someone please help debug this problem,
>>| thx, Nehal
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>  
>


