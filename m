Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbTFRTUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbTFRTUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:20:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7098 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265501AbTFRTUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:20:30 -0400
Date: Wed, 18 Jun 2003 12:23:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 828] New: ALSA + framepointers
Message-ID: <167040000.1055964189@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=828

           Summary: ALSA + framepointers
    Kernel Version: 2.5.72
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: mbm+kernel@nerdfest.org


Hardware Environment: Dell Inspirion 2650
  intel 82801CA/CAM AC'97 audio (rev 02)
  (only supports 48khz)

Problem Description:

When the 2.5.72 is compiled without framepointers ALSA will produce the
following oops while attempting to play an mp3
----
Unable to handle kernel paging request at virtual address e285e000
 printing eip:
c030a573
*pde = 1fd98067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c030a573>]    Not tainted
EFLAGS: 00010202
EIP is at resample_expand+0x343/0x377
eax: c030a573   ebx: 00000000   ecx: 0000036b   edx: 0000ffff
esi: e285b166   edi: dfc7e110   ebp: e285dffe   esp: dd86be54
ds: 007b   es: 007b   ss: 0068
Process mpg123 (pid: 500, threadinfo=dd86a000 task=de10a680)
Stack: c03079ed dfc7e080 dfdaa660 dd86be80 00000000 dd86a000 c0458768 ffffffff
       c030a397 c030a4eb c030a573 dfc7e0f0 00000000 00000004 00000004 00000001
       ffffffff 000003ee 0000045a 00000400 dfc7e080 df4c5580 c030aa1d dfc7e080
Call Trace:
 [<c03079ed>] snd_pcm_plug_playback_channels_mask+0x72/0xd8
 [<c030a397>] resample_expand+0x167/0x377
 [<c030a4eb>] resample_expand+0x2bb/0x377
 [<c030a573>] resample_expand+0x343/0x377
 [<c030aa1d>] rate_transfer+0x59/0x5d
 [<c0307dc5>] snd_pcm_plug_write_transfer+0x95/0xf4
 [<c0303df0>] snd_pcm_oss_write2+0xae/0x118
 [<c0303f6f>] snd_pcm_oss_write1+0x115/0x1ba
 [<c0305f95>] snd_pcm_oss_write+0x43/0x5d
 [<c0305f52>] snd_pcm_oss_write+0x0/0x5d
 [<c015086c>] vfs_write+0xd0/0x135
 [<c0150976>] sys_write+0x42/0x63
 [<c01090bb>] syscall_call+0x7/0xb

Code: 8b 45 00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00
----

Oddly, the problem disappears and ALSA works fine when the kernel is compiled
with framepointers.

