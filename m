Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbRGUSX0>; Sat, 21 Jul 2001 14:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267783AbRGUSXP>; Sat, 21 Jul 2001 14:23:15 -0400
Received: from uucp.gnuu.de ([151.189.0.84]:17675 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S267782AbRGUSXE>;
	Sat, 21 Jul 2001 14:23:04 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.4.6, reiserfs] kernel BUG at prints.c:332!
From: Andreas Muck <ml@chapulin.de>
Date: 21 Jul 2001 19:43:46 +0200
Message-ID: <m37kx218kt.fsf@mantuzo.chapulin.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I recently converted most of my filesystems from ext2 to reiserfs and
noticed regulary oopses (?) on recovered SCSI errors. I'm not sure if
it's really a kernel issue, or compiler related, but I thought I'd
report it anyway.

The kernel/compiler is: Linux version 2.4.6 (root@mantuzo) (gcc
version 2.95.4 20010703 (Debian prerelease)) #1 Thu Jul 12 13:32:47
CEST 2001

Here's the messages I get when a recovered SCSI error occurs on the
reiserfs:

SCSI disk error : host 0 channel 0 id 6 lun 0 return code = 8000002
Info fld=0xed07, Deferred sd08:31: sense key Recovered Error
Additional sense indicates Record not found
 I/O error: dev 08:31, sector 65680
journal-712: buffer write failed
kernel BUG at prints.c:332!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c016ddf5>]
EFLAGS: 00010282
eax: 0000001c   ebx: c02a8120   ecx: 00000001   edx: c025c5a4
esi: c1241ee8   edi: c1241ed8   ebp: 00000000   esp: c1241eac
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 6, stackpage=c1241000)
Stack: c0223eed c02241f8 0000014c c7da0c00 000018d0 00001d35 c8c488c0 c02a8520 
       c1241ed4 c1241ed8 c1240000 00000000 c0177f9c c7da0c00 c0226560 00000002 
       000008c0 000008c0 c0178468 c7da0c00 00001d35 000018d0 00000804 000008c0 
Call Trace: [<c0177f9c>] [<c0178468>] [<c017b9ce>] [<c017a67f>] [<c016bd65>] [<c0130df2>] [<c012ff1f>] 
       [<c013019b>] [<c0105424>] 

Code: 0f 0b 83 c4 0c 83 7c 24 28 00 74 0f 8b 7c 24 28 80 4f 28 01 

The processes accessing the reiserfs (or maybe only the affected file)
will hang in IO wait forever, even SysRq-sync fails on the partition.

I haven't had any more problems since converting the disk back to
ext2.

andi
