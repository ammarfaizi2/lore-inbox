Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVCaJHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVCaJHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCaJHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:07:19 -0500
Received: from 62-15-228-226.inversas.jazztel.es ([62.15.228.226]:9904 "EHLO
	servint.tedial.com") by vger.kernel.org with ESMTP id S261206AbVCaJGz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:06:55 -0500
From: Antonio Larrosa =?iso-8859-1?q?Jim=E9nez?= <antlarr@tedial.com>
Organization: Tedial
To: linux-kernel@vger.kernel.org
Subject: SCSI I/O error generating a kernel (parport? reiserfs?) bug (2.4.21-99)
Date: Thu, 31 Mar 2005 11:06:52 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503311106.52574.antlarr@tedial.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Last night I saw an I/O error in a RAID device on a SuSE 9.0 system (with the 
stock 2.4.21-99 kernel, not tainted). I don't know if it's useful for anyone 
given that the kernel has changed much since then, but I report it just in 
case the problem is still in there.

I find strange that the backtrace (below) talks about parport being a SCSI I/O 
error, so maybe it's not related to the SCSI problem, but since at the end it 
mentions reiserfs, it makes me wonder.

Btw, the RAID is on a cciss controller.

Greetings,

These are the contents of the syslog:

Mar 31 04:33:51 baja1 kernel: sym0:1:0: HOST RESET operation started.
Mar 31 04:33:51 baja1 kernel: sym0:1:0: HOST RESET operation failed.
Mar 31 04:34:01 baja1 kernel: scsi: device set offline - command error recover 
failed: host 0 channel 0 id 1 lun 0
Mar 31 04:34:01 baja1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0 
return code = 6050000
Mar 31 04:34:01 baja1 kernel:  I/O error: dev 08:01, sector 419350704
(some more like these)
Mar 31 04:34:01 baja1 kernel:  I/O error: dev 08:01, sector 419354320
Mar 31 04:34:01 baja1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0 
return code = 6050000
Mar 31 04:34:01 baja1 kernel:  I/O error: dev 08:01, sector 419350592
Mar 31 04:34:01 baja1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0 
return code = 6050000
Mar 31 04:34:01 baja1 kernel:  I/O error: dev 08:01, sector 419348920
Mar 31 04:34:01 baja1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0 
return code = 6050000
Mar 31 04:34:01 baja1 kernel:  I/O error: dev 08:01, sector 419348904
Mar 31 04:34:01 baja1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0 
return code = 6050000
Mar 31 04:34:01 baja1 kernel:  I/O error: dev 08:01, sector 419348880
Mar 31 04:34:01 baja1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0 
return code = 6050000
Mar 31 04:34:01 baja1 kernel:  I/O error: dev 08:01, sector 419350544
Mar 31 04:34:01 baja1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0 
return code = 6030000
Mar 31 04:34:01 baja1 kernel:  I/O error: dev 08:01, sector 419350672
Mar 31 04:34:01 baja1 kernel: journal-601, buffer write failed
Mar 31 04:34:01 baja1 kernel: kernel BUG at prints.c:334!
Mar 31 04:34:01 baja1 kernel: invalid operand: 0000 2.4.21-99-default #1 Wed 
Sep 24 13:30:51 UTC 2003
Mar 31 04:34:01 baja1 kernel: CPU:    0
Mar 31 04:34:01 baja1 kernel: EIP:    0010:
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224300968/96]   
Not tainted
Mar 31 04:34:01 baja1 kernel: EIP:    0010:[<ce4937a8>]    Not tainted
Mar 31 04:34:01 baja1 kernel: EFLAGS: 00010282
Mar 31 04:34:01 baja1 kernel: eax: 00000024  ebx: c1d04800  ecx: c1619e90 edx: 
ce4ae97a
Mar 31 04:34:01 baja1 kernel: esi: d0235840  edi: 00000012  ebp: c1d04800 esp: 
c1619e8c
Mar 31 04:34:01 baja1 kernel: ds: 0018  es: 0018  ss: 0018
Mar 31 04:34:01 baja1 kernel: Process kupdated (pid: 6, stackpage=c1619000)
Mar 31 04:34:01 baja1 kernel: Stack: ce4ae97a ce4af3c0 ce4ac5c0 c1619eac 
00000000 ce49e759 c1d04800 ce4ac5c0
Mar 31 04:34:01 baja1 kernel:        00000002 e08d1000 00000005 d0235858 
00000003 00000000 cc109ea0 0ba7d59f
Mar 31 04:34:01 baja1 kernel:        c1d04800 0ba7d59f 00000004 ce4a3458 
c1d04800 d0235840 00000001 e08d9104
Mar 31 04:34:01 baja1 kernel: Call Trace:    
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224412026/96]
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224414656/96] 
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224402880/96] 
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224345945/96] 
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224402880/96]
Mar 31 04:34:01 baja1 kernel: Call Trace:    [<ce4ae97a>] [<ce4af3c0>] 
[<ce4ac5c0>] [<ce49e759>] [<ce4ac5c0>]
Mar 31 04:34:01 baja1 kernel:  
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224365656/96] 
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224360643/96] 
[parport:__insmod_parport_O/lib/modules/2.4.21-99-default/kernel/dri+4224288605/96] 
[sync_supers+407/464] [sync_old_buffers+14/64] [kupdate+294/384]
Mar 31 04:34:01 baja1 kernel:  [<ce4a3458>] [<ce4a20c3>] [<ce49075d>] 
[<c014a077>] [<c0148eee>] [<c01491d6>]
Mar 31 04:34:01 baja1 kernel:  [rest_init+0/32] [rest_init+0/32] 
[arch_kernel_thread+35/48] [kupdate+0/384]
Mar 31 04:34:01 baja1 kernel:  [<c0105000>] [<c0105000>] [<c0107333>] 
[<c01490b0>]
Mar 31 04:34:01 baja1 kernel: Modules: [(reiserfs:<ce480060>:<ce4b0d94>)]
Mar 31 04:34:01 baja1 kernel: Code: 0f 0b 4e 01 80 e9 4a ce b8 89 e9 4a ce 68 
c0 f3 4a ce 85 db

--
Antonio Larrosa
antlarr@tedial.com
TEDIAL - Tecnologías Digitales Audiovisuales, S.L.
Parque Tecnológico de Andalucía
