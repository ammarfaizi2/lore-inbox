Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbRFEETA>; Tue, 5 Jun 2001 00:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbRFEESu>; Tue, 5 Jun 2001 00:18:50 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:55048 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263205AbRFEESh> convert rfc822-to-8bit; Tue, 5 Jun 2001 00:18:37 -0400
Message-Id: <200106050410.f554AHU13454@smtp.kolej.mff.cuni.cz>
Content-Type: text/plain; charset=US-ASCII
From: Rudo Thomas <rudo@internet.sk>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kernel oops when burning CDs
Date: Tue, 5 Jun 2001 06:19:14 +0200
X-Mailer: KMail [version 1.2.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106042037.f54KbgU08004@smtp.kolej.mff.cuni.cz> <E15728I-00060D-00@the-village.bc.nu> <zobn90cv.wl@frostrubin.open.nm.fujitsu.co.jp>
In-Reply-To: <zobn90cv.wl@frostrubin.open.nm.fujitsu.co.jp>
X-I-use: SuSE Linux 7.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I get an ooops and immediate kernel panic when I break (CTRL-C)
> > > cdrecord. I can reproduce on 2.4.5-ac series, Linus' 2.4.5 is fine.
> >
> > ... Also include the hardware details. The -ac tree has a newer version of
> > the scsi generic code.
>
>   Oops occures in SG driver. This patch fixes the problem.

Indeed, the patch seems to have solved the problem. Thanks.

The hardware used was a HP 9100 through ide-scsi on a VIA MVP3 based MB. This 
is probably irrelevant, but just in case...

Rudo Thomas.

ps: Here's what I got to:

>>EIP; c01abe88 <sg_cmd_done_bh+1cc/274>   <=====
Trace; c01a3396 <scsi_old_done+56a/57c>
Trace; c01a6f28 <idescsi_end_request+1f8/240>
Trace; c01a6ff3 <idescsi_pc_intr+83/234>
Trace; c0195a17 <ide_intr+f7/14c>
Trace; c01a6f70 <idescsi_pc_intr+0/234>
Trace; c010798c <simd_math_error+54/c8>
Trace; c0107eee <do_IRQ+6e/b0>
Trace; 0c019efe Before first symbol
Code;  c01abe88 <sg_cmd_done_bh+1cc/274>
00000000 <_EIP>:
Code;  c01abe88 <sg_cmd_done_bh+1cc/274>   <=====
   0:   ff 48 10                  decl   0x10(%eax)   <=====
Code;  c01abe8b <sg_cmd_done_bh+1cf/274>
   3:   a1 ac f3 22 c0            mov    0xc022f3ac,%eax
Code;  c01abe90 <sg_cmd_done_bh+1d4/274>
   8:   80 48 18 08               orb    $0x8,0x18(%eax)
Code;  c01abe94 <sg_cmd_done_bh+1d8/274>
   c:   88 54 24 14               mov    %dl,0x14(%esp,1)
Code;  c01abe98 <sg_cmd_done_bh+1dc/274>
  10:   8b 02                     mov    (%edx),%eax
Code;  c01abe9a <sg_cmd_done_bh+1de/274>
  12:   8b 40 00                  mov    0x0(%eax),%eax
