Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVBPTQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVBPTQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVBPTQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:16:26 -0500
Received: from dsl-crow-209-5-162-130-cgy.nucleus.com ([209.5.162.130]:62574
	"EHLO ray.lehtiniemi.com") by vger.kernel.org with ESMTP
	id S261647AbVBPTQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:16:22 -0500
Date: Wed, 16 Feb 2005 12:16:19 -0700
From: Ray Lehtiniemi <rayl@mail.com>
To: linux-kernel@vger.kernel.org
Subject: oops report: bk-head, reiser, sklin98
Message-ID: <20050216191619.GB24244@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all

i found an oops on my screen this morning.  in all likelihood, it's
just a delayed crash due to some network experimentation i was doing
yesterday, but it seemed severe enough to post to the list, just in
case it's real.


   kernel BUG at fs/buffer.c:2890!
   invalid operand: 0000 [#1]
   SMP
   Modules linked in: pktgen
   CPU:    0
   EIP:    0060:[<c015a54c>]    Not tainted VLI
   EFLAGS: 00010246   (2.6.11-rc3-rayl-smp)
   EIP is at try_to_free_buffers+0x8c/0xb0
   eax: 20000000   ebx: c12719a0   ecx: ddf7a768   edx: 00000001
   esi: 00000001   edi: 00000001   ebp: dea2fefc   esp: dea2fe2c
   ds: 007b   es: 007b   ss: 0068
   Process ntpd (pid: 1939, threadinfo=dea2e000 task=ddf46a60)
   Stack: f0000000 c12719a0 00000001 00000001 c019aa9c 00000060 00000001 fffffffb
          ddf7a6bc c019c1d1 000029e6 00000000 00000001 00000060 dea2fefc fffffffb
          00000000 ded941b4 00000000 01d94180 00000086 fffffffb 00000000 b7e3e000
   Call Trace:
    [<c019aa9c>] reiserfs_unprepare_pages+0x3c/0x70
    [<c019c1d1>] reiserfs_file_write+0x621/0x630
    [<c016d00c>] d_alloc+0x12c/0x180
    [<c01f8d1a>] _atomic_dec_and_lock+0x2a/0x60
    [<c016c67a>] dput+0x18a/0x1c0
    [<c01629fa>] path_release+0xa/0x30
    [<c0164549>] open_namei+0xc9/0x600
    [<c0154d17>] filp_open+0x27/0x50
    [<c0155d13>] vfs_write+0xa3/0x120
    [<c0155e41>] sys_write+0x41/0x70
    [<c01024ad>] sysenter_past_esp+0x52/0x75
   Code: 58 04 e8 38 02 00 00 3b 1c 24 89 d8 75 f1 89 f2 8b 5c 24 04 89 d0 8b 74 24 08 8b 7c 24 0c 83 c4 10 c3 89 d8 e8 a6 3a fe ff eb bb <0f> 0b 4a 0b 56 40 37 c0 eb 84 89 e2 89 d8 e8 c1 fe ff ff 89 c6
   

upon typing 'reboot', i was rewarded with a stream of:

  linux:~ # reboot

  ide: failed opcode was: unknown
  hda: drive not ready for command
  ide0: reset: success
  hda: status error: status=0x10 { SeekComplete }

  ide: failed opcode was: unknown
  end_request: I/O error, dev hda, sector 3076147
  hda: drive not ready for command
  hda: status error: status=0x10 { SeekComplete }


the box is currently having problems rebooting....  i'm just looking
into whether the drive got corrupted, or whether this new chassis has
stability issues, since i've only had it running for a week or so.



this is on a nexcom nsa1086 chassis with a single P4 hyperthreaded
processor.  i'm running bk-head from yesterday, together with an
updated sklin98 patch which i received from my vendor, nexcom.com.
it is version 8.12 beta 01, dated dec 08, 2004.  the install.sh
script produced a patch which seemed to apply cleanly to bk-head.

it seems very likely this oops is caused by this driver... yesterday,
i noticed that four of the gig ethernet ports managed by this driver
were producing an infinite stream of interrupts (several hundred
thousand per second, according to /proc/interrupts...).  also, the
pktgen.ko module produced some BUG()-type warnings on several occasions,
which unfortunately i didn't record.




please cc me if it warrants a reply.


thanks

-- 
----------------------------------------------------------------------
     Ray L   <rayl@mail.com>
