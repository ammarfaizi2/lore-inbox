Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263085AbTDBShs>; Wed, 2 Apr 2003 13:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263096AbTDBShs>; Wed, 2 Apr 2003 13:37:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:42392 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263085AbTDBShq>;
	Wed, 2 Apr 2003 13:37:46 -0500
Date: Wed, 2 Apr 2003 10:49:22 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nehal <nehal@canada.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount hfs on SCSI cdrom = segfault
Message-Id: <20030402104922.737d2ae9.rddunlap@osdl.org>
In-Reply-To: <3E8B28B9.5090400@canada.com>
References: <3E87477C.3050208@canada.com>
	<3E8B28B9.5090400@canada.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First post said Linux 2.4.20... that's good info.
That info has been deleted from subsequent postings.

Would it make sense for the BUG() message to include a kernel
version number???  I'm wondering since people do omit that data.

~Randy


On Wed, 02 Apr 2003 10:15:21 -0800 Nehal <nehal@canada.com> wrote:

| > i have a hybrid cd (both HFS, ISO9660) , i have two CD drives,
| > one IDE CD-Rom (actima 32x), and one SCSI CD-burner (yamaha 6416)
| > on an advansys cfg-510 ISA scsi card
| >
| > when i try to mount on IDE using hfs with:
| >
| >    mount -v -r -t hfs /dev/hdc /cdrom
| >
| > it works fine, yet when i try on scsi with:
| >
| >    mount -v -r -t hfs /dev/scd0 /cdrom
| >
| > i get a "Segmentation fault" error, no more output given,
| > it also locks the drive, and sometimes i can use the
| > 'eject' command to eject it, sometimes i cant and i gotta reboot
| >
| > note: when i try to mount the cd using regular iso9660 fs, it
| > works perfectly on both cd drives,
| > also i have tried 2 hybrid cd's, both times i have trouble mounting
| > hfs on the scsi drive only
| >
| > Nehal 
| 
| ok i updated firmware of writer from 1.0c to 1.0d with no help,
| but i found when i do 'dmesg' after mounting i get this error:
| ========
| kernel BUG at buffer.c:2518!
| invalid operand: 0000
| CPU:    0
| EIP:    0010:[<c013c329>]    Not tainted
| EFLAGS: 00013206
| eax: 000007ff   ebx: 00000b00   ecx: 00000800   edx: c11ee640
| esi: 00000b00   edi: 00000200   ebp: 00000b00   esp: c3425db4
| ds: 0018   es: 0018   ss: 0018
| Process mount (pid: 514, stackpage=c3425000)
| Stack: c6d0d760 c3425e48 c0257a59 c7f1c574 00000000 00000b00 00000200 
| 00000000
|        c0139f66 00000b00 00000000 00000200 00000000 00000001 c7568400 
| 00000000
|        c013a1e0 00000b00 00000000 00000200 00000000 c019280a 00000b00 
| 00000000
| Call Trace:    [<c0257a59>] [<c0139f66>] [<c013a1e0>] [<c019280a>] 
| [<c019188a>]
|   [<c01925ff>] [<c0285c30>] [<c013cdca>] [<c013e908>] [<c013d64b>] 
| [<c013cd3c>]
|   [<c013d9a1>] [<c014fcf3>] [<c0150020>] [<c014fe69>] [<c0150441>] 
| [<c01090ff>]
| 
| Code: 0f 0b d6 09 9a 2b 33 c0 8d 87 00 fe ff ff 3d 00 0e 00 00 76
|  
| root@Nehal:~#
| ========
| then when i try it again it doesnt give this message, it locks up my drive
| 
| can someone please help debug this problem,
| thx, Nehal
