Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277973AbRJOCHt>; Sun, 14 Oct 2001 22:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277975AbRJOCHi>; Sun, 14 Oct 2001 22:07:38 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:36794 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S277973AbRJOCHU>; Sun, 14 Oct 2001 22:07:20 -0400
Date: Mon, 15 Oct 2001 04:10:56 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.12-ac1: BUG in sched.c:712
Message-ID: <Pine.LNX.4.33.0110150401390.911-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just wanted to go to bed and left an ISO image download running in the
background... well, the blinking leds on the keyboard indicating a kernel
panic just don't want to let me sleep (yeah, I know 2.4.12-ac1 is
supposed to be rather experimental).

No syslog record, so I had to copy the panic output by hand, so now my
hand hurts AND the info may be inaccurate. ;)

isdn_ppp_push_higher: master->ppp_slot 1
isdn_ppp_xmit: ip->ppp_slot -1
Scheduling in interrupt
Kernel BUG at sched.c:712!
Invalid operand: 0000
CPU:    0
EIP:    0010:[<c0111edf>]    Not tainted
EFLAGS: 00010082
eax: 0000001b   ebx: cd8f2000   ecx: c032fd20   edx: 00002f69
esi: 08060026   edi: cd8f2000   ebp: cd8f3fbc   esp: cd8f3f70
ds: 0018   es: 0018  ss: 0018
Process ipppd (pid:677, stackpage=cd8f3000)
Stack: c02b81d6 000002c8 cd8f2000 08060026 080b5f20 cda9a8c0 c013dba5 cd8f2000
       08060026 080b5f20 080b4f20 ce0e94a0 ce3cfda0 cff2cc60 cd8f2000 cd8f5040
       00000000 cd8f2000 00000000 080b4f20 c0106e75 00000006 0000890b bffff5a0
Call Trace: [<c013dba5>] [<c010be75>]

Code: 0f 0b 8d b5 bc 5b 5e 5f 89 ec 5d e3 90 55 89 e5 83 ec 0c 57
 <0>Kernel panic: Aiee, killing interrupt handler!
in interrupt handler - not syncing



My guess is that my ISP has dropped at least one of the two ISDN channels
in use at the moment the panic happened. I never had a panic when that
happened with previous kernels.

Output from above given to ksymoops produces:

ksymoops 2.4.3 on i586 2.4.12-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-ac1/ (default)
     -M (specified)

Kernel BUG at sched.c:712!
Invalid operand: 0000
CPU:    0
EIP:    0010:[<c0111edf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001b   ebx: cd8f2000   ecx: c032fd20   edx: 00002f69
esi: 08060026   edi: cd8f2000   ebp: cd8f3fbc   esp: cd8f3f70
ds: 0018   es: 0018  ss: 0018
Process ipppd (pid:677, stackpage=cd8f3000)
Stack: c02b81d6 000002c8 cd8f2000 08060026 080b5f20 cda9a8c0 c013dba5 cd8f2000
       08060026 080b5f20 080b4f20 ce0e94a0 ce3cfda0 cff2cc60 cd8f2000 cd8f5040
       00000000 cd8f2000 00000000 080b4f20 c0106e75 00000006 0000890b bffff5a0
Call Trace: [<c013dba5>] [<c010be75>]
Code: 0f 0b 8d b5 bc 5b 5e 5f 89 ec 5d e3 90 55 89 e5 83 ec 0c 57

>>EIP; c0111ede <schedule+40e/41c>   <=====
Trace; c013dba4 <dcache_readdir+470/5ac>
Trace; c010be74 <pci_free_consistent+7f4/9e8>
Code;  c0111ede <schedule+40e/41c>
00000000 <_EIP>:
Code;  c0111ede <schedule+40e/41c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0111ee0 <schedule+410/41c>
   2:   8d b5 bc 5b 5e 5f         lea    0x5f5e5bbc(%ebp),%esi
Code;  c0111ee6 <schedule+416/41c>
   8:   89 ec                     mov    %ebp,%esp
Code;  c0111ee8 <schedule+418/41c>
   a:   5d                        pop    %ebp
Code;  c0111ee8 <schedule+418/41c>
   b:   e3 90                     jecxz  ffffff9d <_EIP+0xffffff9d> c0111e7a <schedule+3aa/41c>
Code;  c0111eea <schedule+41a/41c>
   d:   55                        push   %ebp
Code;  c0111eec <__wake_up+0/90>
   e:   89 e5                     mov    %esp,%ebp
Code;  c0111eee <__wake_up+2/90>
  10:   83 ec 0c                  sub    $0xc,%esp
Code;  c0111ef0 <__wake_up+4/90>
  13:   57                        push   %edi

 <0>Kernel panic: Aiee, killing interrupt handler!


I guess I can't reproduce the panic if the ISP dropping the line was
involved. If any other information from my system is needed, I'll be happy
to provide it.

Filesystems were not synced, of course, but they are all either ext3 or
reiserfs, so no big delay on bootup. But since reiserfs does not do data
journalling and the ISO download was going to a reiserfs partition, I
guess I'll better kill the last few megabytes of the ISO image. Hmmm, how
much should I drop? 5 minutes worth of download, perhaps?

Oh, and BTW, is it intended that only Caps Lock and Scroll Lock blink on a
panic?

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

