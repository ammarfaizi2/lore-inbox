Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRLQKy2>; Mon, 17 Dec 2001 05:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbRLQKyT>; Mon, 17 Dec 2001 05:54:19 -0500
Received: from www.hauptsache.net ([195.88.44.25]:60936 "EHLO
	mail.hauptsache.net") by vger.kernel.org with ESMTP
	id <S285093AbRLQKyP>; Mon, 17 Dec 2001 05:54:15 -0500
From: "Nikolas Hagelstein" <hagelstein@hauptsache.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel oops + system crash
Date: Mon, 17 Dec 2001 11:54:50 +0100
Message-ID: <NFBBLFOEOLLGIJBMCBNKGEEPCCAA.hagelstein@hauptsache.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

last night one of our servers crashed on a kernel oops
i was able to get the system up again but i am not shure
about what happend.
hopefully one of you can give me a hint. :)
i will try to give you all relevant informations :

System:
-------

Hardware:
-	Mainboard:	ASUS CUBX-E Rev.:1.01
	BIOS Revision 1007.A
-	Network:	3COM 3C905C - TX – M  - Slot: 5
-	SCSI RAID Controller: ICP Vortex GDT6518RD    - Slot: 3
	DiskArrayControllerBIOS Version:4.01a
-	VGA: 	ATI Rage 98 AGP              - Slot: AGP
-	Memory:	1 x 256 MB PC133 Semicon   - Dimm: 1
-	CPU:	Intel 800 Mhz Celeron
	Socket 370 FC-PGA
-	HDD:	2 x Seagate ST39173N - ID: 0 und 1
	parity Jumper enanbled

Software:
-	Mandrake Linux 7.2
-	Kernel 2.2.19 + Reiser FS Version 3.5.32
-	apache 1.3.14+php 4.0.4pl1
- 	mysql -3.23.31
- 	sendmail-8.11.0
-	wu-ftpd-2.6.1

Oops DATA:
---------



output of ksymoops :

Options used: -V (default)
              -o /lib/modules/2.2.19/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /boot/System.map (specified)
              -c 1 (default)

No modules in ksyms, skipping objects
Warning, no symbols in lsmod, is /proc/modules a valid lsmod file?
Dec 17 04:02:02 cameron kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 17 04:02:02 cameron kernel: current->tss.cr3 = 0df9a000, %%cr3 =
0df9a000
Dec 17 04:02:02 cameron kernel: *pde = 00000000
Dec 17 04:02:02 cameron kernel: Oops: 0002
Dec 17 04:02:02 cameron kernel: CPU:    0
Dec 17 04:02:02 cameron kernel: EIP:    0010:[prune_dcache+47/340]
Dec 17 04:02:02 cameron kernel: EFLAGS: 00010216
Dec 17 04:02:02 cameron kernel: eax: c0206504   ebx: c9eec820   ecx:
c9eec840   edx: 00000000
Dec 17 04:02:02 cameron kernel: esi: c9b6f300   edi: 00001004   ebp:
00000000   esp: ce833ddc
Dec 17 04:02:02 cameron kernel: ds: 0018   es: 0018   ss: 0018
Dec 17 04:02:02 cameron kernel: Process slocate (pid: 10555, process nr: 85,
stackpage=ce833000)
Dec 17 04:02:02 cameron kernel: Stack: c020652c 00001004 00001004 c0131807
ffffef50 00000710 00000000 c022bf28
Dec 17 04:02:02 cameron kernel:        c020652c c022bf28 00000807 000063f4
00001000 ce833e50 ce833e14 ce833e14
Dec 17 04:02:02 cameron kernel:        c013186e 00001004 00000000 c022bf28
c020652c c022bf28 00000093 ce833ed0
Dec 17 04:02:02 cameron kernel: Call Trace: [try_to_free_inodes+199/264]
[grow_inodes+30/384] [get_new_inode+185/292] [iget4+102/112] [iget+19/24]
[reiserfs_iget+29/112] [reiserfs_lookup+98/144]
Dec 17 04:02:02 cameron kernel: Code: 89 02 8b 41 e4 a8 08 74 24 24 f7 89 41
e4 a1 04 65 20 c0 89
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 89 02 8b 41 e4 a8 08 74 24 24 f7 89 41 e4 a1 04 65 20 c0 89 '
  Garbage: ' '

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	89 02
mov    %eax,(%edx) <===
Code:  00000002 Before first symbol               2:	8b 41 e4
mov    0xffffffe4(%ecx),%eax
Code:  00000005 Before first symbol               5:	a8 08
test   $0x8,%al
Code:  00000007 Before first symbol               7:	74 24
je      0000002d Before first symbol
Code:  00000009 Before first symbol               9:	24 f7
and    $0xf7,%al
Code:  0000000b Before first symbol               b:	89 41 e4
mov    %eax,0xffffffe4(%ecx)
Code:  0000000e Before first symbol               e:	a1 04 65 20 c0
mov    0xc0206504,%eax
Code:  00000013 Before first symbol              13:	89 00
mov    %eax,(%eax)

Dec 17 10:46:27 cameron kernel: 3c59x.c 18Feb01 Donald Becker and others
http://www.scyld.com/network/vortex.html

4 warnings issued.  Results may not be reliable.
--------------

it seems as if the oops was triggert bye one of the following cron jobs,
which are running at 4:02
/etc/cron.daily/tmpwatch
/etc/cron.daily/logrotate
/etc/cron.daily/makewhatis.cron
/etc/cron.daily/0anacron
/etc/cron.daily/htdig-dbgen
/etc/cron.daily/slocate.cron
but i wasnt able to discover which of them is responsible yes.


ok, hopefully this are enought informations ..if you need more please let me
know.

Kindly regards,
				Nikolas





