Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSLAOaB>; Sun, 1 Dec 2002 09:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSLAOaB>; Sun, 1 Dec 2002 09:30:01 -0500
Received: from fep05-svc.mail.telepac.pt ([194.65.5.209]:37590 "EHLO
	fep05-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id <S261836AbSLAO3u>; Sun, 1 Dec 2002 09:29:50 -0500
Date: Sun, 1 Dec 2002 14:37:13 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021201143713.GA871@hobbes.itsari.int>
References: <20021130182345.GA21410@lnuxlab.ath.cx> <20021130184317.GH28164@dualathlon.random> <20021201075921.GC2483@jerry.marcet.dyndns.org> <20021201103643.GL28164@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021201103643.GL28164@dualathlon.random>; from andrea@suse.de on Sun, Dec 01, 2002 at 10:36:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 01.12.02 10:36 Andrea Arcangeli wrote:
> On Sun, Dec 01, 2002 at 08:59:21AM +0100, Javier Marcet wrote:
>> * Andrea Arcangeli <andrea@suse.de> [021130 19:47]:
>> 
>> Hmm, the attachment...
> 
> the attachment doesn't show anything interesting. Next time you can
> press SYSRQ+T and SYSRQ+P before dumping to floppy. BTW, you had
> kmsgdump probably because it was in the jam patches, it's not in my tree
> normally.
> 

Hi,

I too experienced the lockup others described in this thread so I just 
built a kernel with kmsgdump and I got a trace for you. This is 
2.4.20-rc4 with -rc2aa1 applied plus kmsgdump. I tried with J.A. 
Magallon's 02-revert-fast-pte-2 but it still locks up (and this trace 
_does not_ include that patch) -- besides, Im not even using AGP, as all 
these tests are conducted on an old P200 test box. Its very easy to 
reproduce the lock here, I just fire up X (with gnome 1.4), open a couple 
aterms, xmms playing an audio cd and open a web brower -- at this point 
the system is still responding nicely, but as soon as I fire up xchat, it 
locks up. It still responds to pings though, but I cant ssh in. At the 
console, SysRQ-S and SysRQ-U dont seem to work, but all others do. Ah, 
yes, the CD playing never stops, too. The ksymoopsified SysRQ-T & SysRQ-P 
trace is attached, I hope it can help somehow.


	Nuno

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="messages.1.decoded"

ksymoops 2.4.7 on i586 2.4.19.  Options used
     -v /usr/local/src/linux-2.4.20/vmlinux (specified)
     -k /home/nuno/ksyms (specified)
     -l /home/nuno/modules (specified)
     -o /lib/modules/2.4.20/ (specified)
     -m /boot/System.map-2.4.20 (specified)

init          R C10E1F2C  4580     1      0   645               (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e1b1>] [<c013e562>] [<c01376e3>]
  [<c01070d3>]
keventd       R current   5980     2      1             3       (L-TLB)
ksoftirqd_CPU S C10C2000  6288     3      1             4     2 (L-TLB)
Call Trace:    [<c011718e>] [<c010588c>]
kswapd        S C10C0000  5908     4      1             5     3 (L-TLB)
Call Trace:    [<c012af99>] [<c010588c>]
bdflush       S 00000286  6560     5      1             6     4 (L-TLB)
Call Trace:    [<c0110471>] [<c0134b6a>] [<c010588c>]
kupdated      R C11FBFCC  5980     6      1             7     5 (L-TLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c0134be4>] [<c010588c>]
kreiserfsd    R C13BBFB4  6592     7      1           318     6 (L-TLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c01104da>] [<c016d59b>] [<c010588c>]
syslogd       S 7FFFFFFF  2564   318      1           328     7 (NOTLB)
Call Trace:    [<c011a184>] [<c013e1b1>] [<c013e562>] [<c01070d3>]
klogd         R C3EEA000   656   328      1           341   318 (NOTLB)
Call Trace:    [<c0112c80>] [<c014e425>] [<c0130c36>] [<c01070d3>]
crond         S C3D4FF74  4672   341      1           400   328 (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c011a334>] [<c01070d3>]
xfs           S C02F1F2C  5132   400      1           462   341 (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e1b1>] [<c013e562>] [<c01070d3>]
xinit         S 00000000     0   462      1   473     466   400 (NOTLB)
Call Trace:    [<c011616f>] [<c01070d3>]
login         S 00000000    40   466      1   846     584   462 (NOTLB)
Call Trace:    [<c011616f>] [<c01070d3>]
X             S C09F3F2C  1348   469    462           473       (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e1b1>] [<c013e562>] [<c01070d3>]
gnome-session S 7FFFFFFF     0   473    462                 469 (NOTLB)
Call Trace:    [<c011a184>] [<c013e7b9>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
gnome-smproxy S 7FFFFFFF     0   584      1           597   466 (NOTLB)
Call Trace:    [<c011a184>] [<c013e1b1>] [<c013e562>] [<c01070d3>]
sawfish       R C1DD7F2C     0   595      1           602   597 (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e1b1>] [<c013e562>] [<c01070d3>]
oafd          S 7FFFFFFF     0   597      1           595   584 (NOTLB)
Call Trace:    [<c011a184>] [<c013e7b9>] [<c013e7ee>] [<c013e9fd>] [<c0130855>]
  [<c01070d3>]
bonobo-monike S 7FFFFFFF  2656   602      1           609   595 (NOTLB)
Call Trace:    [<c011a184>] [<c013e7b9>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
bonobo-monike S 7FFFFFFF  2644   609      1           611   602 (NOTLB)
Call Trace:    [<c011a184>] [<c013e7b9>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
bonobo-monike S 7FFFFFFF     0   611      1           620   609 (NOTLB)
Call Trace:    [<c011a184>] [<c013e7b9>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
gmc           S 7FFFFFFF  2656   620      1           622   611 (NOTLB)
Call Trace:    [<c011a184>] [<c013e7b9>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
panel         R C2261F2C    32   622      1           634   620 (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
gnome-name-se S 7FFFFFFF     0   634      1           641   622 (NOTLB)
Call Trace:    [<c011a184>] [<c013e7b9>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
tasklist_appl S 7FFFFFFF     0   641      1           645   634 (NOTLB)
Call Trace:    [<c011a184>] [<c013e7b9>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
aterm         S 7FFFFFFF     0   645      1   648           641 (NOTLB)
Call Trace:    [<c011a184>] [<c013e1b1>] [<c013e562>] [<c01070d3>]
bash          S 7FFFFFFF     0   648    645   719               (NOTLB)
Call Trace:    [<c011a184>] [<c017a2b7>] [<c017a301>] [<c0176388>] [<c0130c36>]
  [<c01070d3>]
xmms          R C2EE1F2C   912   699    648   704     719       (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e7ee>] [<c013e9fd>] [<c01070d3>]
xmms          R C2E4DF2C  2644   704    699   712               (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e7ee>] [<c013e9fd>] [<c0110257>]
  [<c01070d3>]
xmms          R C2E49F2C  2644   705    704           712       (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e1b1>] [<c013e562>] [<c01070d3>]
xmms          R C2C03F74     0   712    704                 705 (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c011a334>] [<c01070d3>]
opera         S 00000000  2656   719    648   724           699 (NOTLB)
Call Trace:    [<c011616f>] [<c01070d3>]
opera         R C325DF2C     0   724    719                     (NOTLB)
Call Trace:    [<c011a1ee>] [<c011a164>] [<c013e1b1>] [<c013e562>] [<c01070d3>]
bash          S 7FFFFFFF     4   846    466   898               (NOTLB)
Call Trace:    [<c011a184>] [<c017a2b7>] [<c017a301>] [<c0176388>] [<c0130c36>]
  [<c01070d3>]
xchat         R C2DC2000     0   898    846                     (NOTLB)
Call Trace:    [<c010ed94>] [<c01102b0>] [<c0107195>]
Pid: 2, comm:              keventd
EIP: 0010:[<c0142ae3>] CPU: 0 EFLAGS: 00000206    Not tainted
EAX: c10ec45c EBX: 00000033 ECX: c11f8838 EDX: 40000000
ESI: c2fed680 EDI: c10ec400 EBP: 00000033 DS: 0018 ES: 0018
Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register line ignored
CR0: 8005003b CR2: 081c1034 CR3: 02809000 CR4: 00000010
Call Trace:    [<c0117114>] [<c011e0e9>] [<c010588c>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init

>>EIP; c10e1f2c <_end+e47cb4/13c9de8>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01376e3 <sys_stat64+6b/78>
Trace; c01070d3 <system_call+33/40>
Proc;  keventd

>>EIP; 0000000c Before first symbol   <=====
Proc;  ksoftirqd_CPU

>>EIP; c10c2000 <_end+e27d88/13c9de8>   <=====

Trace; c011718e <ksoftirqd+66/a0>
Trace; c010588c <kernel_thread+28/38>
Proc;  kswapd

>>EIP; c10c0000 <_end+e25d88/13c9de8>   <=====

Trace; c012af99 <kswapd+75/bc>
Trace; c010588c <kernel_thread+28/38>
Proc;  bdflush

>>EIP; 00000286 Before first symbol   <=====

Trace; c0110471 <interruptible_sleep_on+41/64>
Trace; c0134b6a <bdflush+a2/a4>
Trace; c010588c <kernel_thread+28/38>
Proc;  kupdated

>>EIP; c11fbfcc <_end+f61d54/13c9de8>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c0134be4 <kupdate+78/fc>
Trace; c010588c <kernel_thread+28/38>
Proc;  kreiserfsd

>>EIP; c13bbfb4 <_end+1121d3c/13c9de8>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c01104da <interruptible_sleep_on_timeout+46/6c>
Trace; c016d59b <reiserfs_journal_commit_thread+8f/c4>
Trace; c010588c <kernel_thread+28/38>
Proc;  syslogd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01070d3 <system_call+33/40>
Proc;  klogd

>>EIP; c3eea000 <END_OF_CODE+18968/????>   <=====

Trace; c0112c80 <do_syslog+d0/2d8>
Trace; c014e425 <kmsg_read+11/18>
Trace; c0130c36 <sys_read+96/f0>
Trace; c01070d3 <system_call+33/40>
Proc;  crond

>>EIP; c3d4ff74 <[vfat].data.end+23db29/36fc15>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c011a334 <sys_nanosleep+114/250>
Trace; c01070d3 <system_call+33/40>
Proc;  xfs

>>EIP; c02f1f2c <_end+57cb4/13c9de8>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01070d3 <system_call+33/40>
Proc;  xinit

>>EIP; 00000000 Before first symbol

Trace; c011616f <sys_wait4+34f/380>
Trace; c01070d3 <system_call+33/40>
Proc;  login

>>EIP; 00000000 Before first symbol

Trace; c011616f <sys_wait4+34f/380>
Trace; c01070d3 <system_call+33/40>
Proc;  X

>>EIP; c09f3f2c <_end+759cb4/13c9de8>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01070d3 <system_call+33/40>
Proc;  gnome-session

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e7b9 <do_poll+85/dc>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  gnome-smproxy

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01070d3 <system_call+33/40>
Proc;  sawfish

>>EIP; c1dd7f2c <[rtc].data.end+7727f5/1882929>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01070d3 <system_call+33/40>
Proc;  oafd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e7b9 <do_poll+85/dc>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c0130855 <filp_close+55/60>
Trace; c01070d3 <system_call+33/40>
Proc;  bonobo-monike

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e7b9 <do_poll+85/dc>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  bonobo-monike

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e7b9 <do_poll+85/dc>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  bonobo-monike

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e7b9 <do_poll+85/dc>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  gmc

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e7b9 <do_poll+85/dc>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  panel

>>EIP; c2261f2c <[rtc].data.end+bfc7f5/1882929>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  gnome-name-se

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e7b9 <do_poll+85/dc>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  tasklist_appl

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e7b9 <do_poll+85/dc>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  aterm

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01070d3 <system_call+33/40>
Proc;  bash

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c017a2b7 <read_chan+3a7/76c>
Trace; c017a301 <read_chan+3f1/76c>
Trace; c0176388 <tty_read+b4/d4>
Trace; c0130c36 <sys_read+96/f0>
Trace; c01070d3 <system_call+33/40>
Proc;  xmms

>>EIP; c2ee1f2c <[rtc].data.end+187c7f5/1882929>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c01070d3 <system_call+33/40>
Proc;  xmms

>>EIP; c2e4df2c <[rtc].data.end+17e87f5/1882929>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e7ee <do_poll+ba/dc>
Trace; c013e9fd <sys_poll+1ed/2f0>
Trace; c0110257 <do_schedule+1e7/210>
Trace; c01070d3 <system_call+33/40>
Proc;  xmms

>>EIP; c2e49f2c <[rtc].data.end+17e47f5/1882929>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01070d3 <system_call+33/40>
Proc;  xmms

>>EIP; c2c03f74 <[rtc].data.end+159e83d/1882929>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c011a334 <sys_nanosleep+114/250>
Trace; c01070d3 <system_call+33/40>
Proc;  opera

>>EIP; 00000000 Before first symbol

Trace; c011616f <sys_wait4+34f/380>
Trace; c01070d3 <system_call+33/40>
Proc;  opera

>>EIP; c325df2c <[cdrom].data.end+9f90d/b6a41>   <=====

Trace; c011a1ee <schedule_timeout+7e/a0>
Trace; c011a164 <process_timeout+0/c>
Trace; c013e1b1 <do_select+19d/1dc>
Trace; c013e562 <sys_select+34a/494>
Trace; c01070d3 <system_call+33/40>
Proc;  bash

>>EIP; 7fffffff Before first symbol   <=====

Trace; c011a184 <schedule_timeout+14/a0>
Trace; c017a2b7 <read_chan+3a7/76c>
Trace; c017a301 <read_chan+3f1/76c>
Trace; c0176388 <tty_read+b4/d4>
Trace; c0130c36 <sys_read+96/f0>
Trace; c01070d3 <system_call+33/40>
Proc;  xchat

>>EIP; c2dc2000 <[rtc].data.end+175c8c9/1882929>   <=====

Trace; c010ed94 <do_page_fault+0/52c>
Trace; c01102b0 <user_schedule+8/c>
Trace; c0107195 <reschedule+5/10>

>>EIP; c0142ae3 <try_to_sync_unused_inodes+1f/1f8>   <=====

>>EAX; c10ec45c <_end+e521e4/13c9de8>
>>ECX; c11f8838 <_end+f5e5c0/13c9de8>
>>ESI; c2fed680 <[sb].data.end+a7ffd/25a9dd>
>>EDI; c10ec400 <_end+e52188/13c9de8>

Trace; c0117114 <__run_task_queue+4c/60>
Trace; c011e0e9 <context_thread+11d/19c>
Trace; c010588c <kernel_thread+28/38>


2 warnings issued.  Results may not be reliable.

--AhhlLboLdkugWU4S--
