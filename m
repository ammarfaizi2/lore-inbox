Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVC0TyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVC0TyW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVC0TyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:54:22 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:41240 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261496AbVC0TyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:54:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=uL+UbuK0O7lpnfT9qaGbhlXrnX5ce4rI/XhHbyAttaAIpIoDfOQ8vOqVcDNwzpf5bOmRQ6cbmJr3JPnl35HzJz9J2B9S+yw61cLu1vOhux9z6cGU9SkajbAiBjZEnCoBrY67TGDFOH0zfE/UcECdvjPW/h6zJ2ds+xROv+Jt5Ic=
Message-ID: <5a4c581d05032711545d2468a2@mail.gmail.com>
Date: Sun, 27 Mar 2005 21:54:12 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.11-bk10 non-fatal oops mkdir'ing loop-mounted UDF image
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine is a K7-800 with 256MB, 2x160GB hard disks, a
 Samsung TL-552 burner running FC3 plus 2.6.11-bk10
 from kernel.org.

While trying to understand why mkisofs -dvd-video creates
 an image with a VOB file that has a different MD5 sum than
 the original (reproducible), I wanted to give it another try
 and create the image from a directory that not only had
 VIDEO_TS but also AUDIO_TS.

Unfortunately I confused the ext3 and loop gnome-terminal
 windows, and attempted mkdir on the loop-mounted image.

Results: mkdir command printed "Segmentation fault" while
 the bash shell survived. I can't now umount the loop-mounted
 file and an oops was logged. From dmesg (and note the first
 message, coming from a previous successful audio burning
 session with cdrecord <...> -eject)

[1003810.249656] scsi: unknown opcode 0x01
[1098164.712708] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume
'CDROM', timestamp 2005/03/27 17:10 (103c)
[1098895.563940] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume
'CDROM', timestamp 2005/03/27 17:10 (103c)
[1099506.099370] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume
'CDROM', timestamp 2005/03/27 18:46 (103c)
[1104119.924833] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume
'CDROM', timestamp 2005/03/27 20:03 (103c)
[1105984.457690] Unable to handle kernel paging request at virtual
address 00d600fe
[1105984.458592]  printing eip:
[1105984.458946] c02034e9
[1105984.459545] *pde = 00000000
[1105984.459911] Oops: 0000 [#1]
[1105984.460268] PREEMPT
[1105984.460597] Modules linked in: loop parport_pc parport 8139too floppy
[1105984.461257] CPU:    0
[1105984.461260] EIP:    0060:[<c02034e9>]    Not tainted VLI
[1105984.461264] EFLAGS: 00210297   (2.6.11-bk10)
[1105984.462565] EIP is at udf_get_filelongad+0x29/0x60
[1105984.463050] eax: 00d601ae   ebx: 00d600fe   ecx: c8057e18   edx: 00d601be
[1105984.463656] esi: 00d701af   edi: 00d701af   ebp: c8057d74   esp: c8057d68
[1105984.464259] ds: 007b   es: 007b   ss: 0068
[1105984.464698] Process mkdir (pid: 18065, threadinfo=c8056000 task=ccbac510)
[1105984.465132] Stack: ca766b10 c6fc8348 00d600fe c8057dac c01fb500
00000001 00000000 00000000
[1105984.466116]        00d600fe c8057e18 00000000 00000002 00000000
000000b8 c8057e10 c6fc8380
[1105984.467097]        c8057e28 c8057dd4 c01fb367 c8057e1c c8057e24
c8057e28 00000001 c8057e18
[1105984.468080] Call Trace:
[1105984.468592]  [<c010303a>] show_stack+0x7a/0x90
[1105984.469079]  [<c01031bd>] show_registers+0x14d/0x1c0
[1105984.469594]  [<c01033b4>] die+0xe4/0x170
[1105984.470044]  [<c010fea6>] do_page_fault+0x456/0x673
[1105984.470560]  [<c0102cbf>] error_code+0x2b/0x30
[1105984.471043]  [<c01fb500>] udf_current_aext+0x130/0x1d0
[1105984.471569]  [<c01fb367>] udf_next_aext+0x37/0xa0
[1105984.472067]  [<c020253a>] udf_discard_prealloc+0xaa/0x290
[1105984.472610]  [<c01f72a6>] udf_clear_inode+0x36/0x50
[1105984.473120]  [<c0169c04>] clear_inode+0xf4/0x100
[1105984.473615]  [<c016adce>] generic_forget_inode+0x11e/0x160
[1105984.474162]  [<c016ae86>] iput+0x56/0x80
[1105984.474612]  [<c01f71a4>] udf_new_inode+0x364/0x379
[1105984.475122]  [<c01fd819>] udf_mkdir+0x39/0x210
[1105984.475605]  [<c0160241>] vfs_mkdir+0x71/0xa0
[1105984.476085]  [<c01602f9>] sys_mkdir+0x89/0xd0
[1105984.476562]  [<c0102abb>] sysenter_past_esp+0x54/0x75
[1105984.477081] Code: 00 00 55 89 e5 56 89 d6 53 89 c3 83 ec 04 85 c0
0f 94 c2 85 c9 0f 94 c0 09 d0 a8 01 75 27 8b 01 85 c0 78 2e 8d 50 10
39 f2 77 27 <8b> 33 31 c0 85 f6 74 21 8b 45 08 85 c0 74 02 89 11 83 c4
04 89
[1105984.565877]


Thanks,
 
--alessandro

 "I want to know if it's you I don't trust
  'cause I damn sure don't trust myself"

    (Bruce Springsteen, "Brilliant Disguise")
