Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317549AbSGOR0w>; Mon, 15 Jul 2002 13:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSGOR0v>; Mon, 15 Jul 2002 13:26:51 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:31399 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S317549AbSGOR0u>;
	Mon, 15 Jul 2002 13:26:50 -0400
Message-ID: <000b01c22c25$4fd0a0c0$0201a8c0@witek>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG 2.5.25] ide-scsi oops
Date: Mon, 15 Jul 2002 19:30:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on 2.5.25dj2 and 2.5.25dj2 w/IDE97
Configuration:
Asus a7m266 with Via IDE
hda: Seagate Barracuda
hdb: LG DVD
hdc: LG CD-RW
hdd: empty
When using 'ignore=hdb' or without any ignores while loading ide-cd ide-scsi
loads without problems. In any other configuration (without loading ide-cd,
loading with 'ignore=hdc') ide-scsi loading causes following oops:
<cut>
ksymoops 2.4.4 on i686 2.5.25. Options used

-V (default)

-k /proc/ksyms (default)

-l /proc/modules (default)

-o /lib/modules/2.5.25/ (default)

-m /boot/System.map-2.5.25-1.1 (specified)

Warning (expand_objects): object
/lib/modules/2.5.25-1.1/kernel/fs/ext2/ext2.o for module ext2 has changed
since load

Warning (expand_objects): object
/lib/modules/2.5.25-1.1/kernel/drivers/ide/ide-disk.o for module ide-disk
has changed since load

Warning (expand_objects): object
/lib/modules/2.5.25-1.1/kernel/drivers/ide/ide-mod.o for module ide-mod has
changed since load

Oops: 0002

CPU: 0

EIP: 0010:[<c018d070>] Not tainted

Using defaults from ksymoops -t elf32-i386 -a i386

EFLAGS: 00010297

eax: 46504646 ebx: d43f4084 ecx: d43f408c edx: d4561284

esi: e494660e edi: d43f4106 ebp: 0000004f esp: d44a1ed4

ds: 0018 es: 0018 ss: 0018

Stack: d43f4000 d43f40ff e087466b d43f4084 00000002 00000002 e4945000

00001920

d44a1f1c 00000000 00000000 00000000 00000000 d44a1f1c d44a1f1c

00000000

00000000 00000000 d44a1f1c d44a1f1c e49461a6 e49468a0 c01158e1

d44a0000

Call Trace: [<e087466b>] [<e49461a6>] [<e49468a0>] [<c01158e1>] [<e4945060>]

[<c010872b>]

Code: 89 58 04 89 03 89 53 04 89 1a 8b 43 28 83 c0 20 8b 50 04 89

>>EIP; c018d070 <device_register+98/11c> <=====

Trace; e087466b <[scsi_mod]scsi_register_host+1ff/310>

Trace; e49461a6 <[ide-scsi]init_idescsi_module+a/10>

Trace; e49468a0 <[ide-scsi]template+0/7f>

Trace; c01158e1 <sys_init_module+585/670>

Trace; e4945060 <[ide-scsi]idescsi_input_buffers+0/b0>

Trace; c010872b <syscall_call+7/b>

Code; c018d070 <device_register+98/11c>

00000000 <_EIP>:

Code; c018d070 <device_register+98/11c> <=====

0: 89 58 04 mov %ebx,0x4(%eax) <=====

Code; c018d073 <device_register+9b/11c>

3: 89 03 mov %eax,(%ebx)

Code; c018d075 <device_register+9d/11c>

5: 89 53 04 mov %edx,0x4(%ebx)

Code; c018d078 <device_register+a0/11c>

8: 89 1a mov %ebx,(%edx)

Code; c018d07a <device_register+a2/11c>

a: 8b 43 28 mov 0x28(%ebx),%eax

Code; c018d07d <device_register+a5/11c>

d: 83 c0 20 add $0x20,%eax

Code; c018d080 <device_register+a8/11c>

10: 8b 50 04 mov 0x4(%eax),%edx

Code; c018d083 <device_register+ab/11c>

13: 89 00 mov %eax,(%eax)



3 warnings issued. Results may not be reliable.

</cut>

Usually (but not always) about 30secs after loading ide-scsi there is a
kernel panic (sth with SCSI, I'll try to rewrite it on my second PC).

Witek Krecicki



