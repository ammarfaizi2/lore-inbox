Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTITNH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 09:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTITNH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 09:07:56 -0400
Received: from mta07ps.bigpond.com ([144.135.25.132]:18656 "EHLO
	mta07ps.bigpond.com") by vger.kernel.org with ESMTP id S261869AbTITNHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 09:07:31 -0400
Date: Sat, 20 Sep 2003 23:09:06 +1000
From: Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: [PROBLEM] 2.4.23-pre4 deadlocks while 2.4.22aa1 works fine
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <200309202309.06660.harisri@bigpond.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(Sorry about the long e-mail)

[1.] One line summary of the problem:    
2.4.23-pre4 deadlocks while 2.4.22aa1 works fine (under heavy VM load that 
is).

[2.] Full description of the problem/report:
While -aa VM kills the offending process (please refer the sample script), 
2.4.23-pre4 deadlocks and doesn't do much.

[3.] Keywords (i.e., modules, networking, kernel):
2.4.23-pre4

[4.] Kernel version (from /proc/version):
Linux version 2.4.23-pre4 (hari@desktop) (gcc version 3.2.2 20030222 (Red Hat 
Linux 3.2.2-5)) #1 Sat Sep 20 16:39:09 EST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
I ran sysrq+c+showTasks through ksymoops (I do not know, but it may have some 
clue).

ksymoops 2.4.5 on i686 2.4.23-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre4/ (default)
     -m /boot/System.map-2.4.23-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

init          S 00000001     8     1      0   861               (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<c0113038>] [<c012f9dc>] [<c0112fc0>] [<c013f497>] 
[<c0145169>]
  [<c0145602>] [<c013d619>] [<c010737f>]
keventd       S 00000000    36     2      1             3       (L-TLB)
Call Trace:    [<c0123264>] [<c0123160>] [<c0105000>] [<c01057be>] 
[<c0123160>]
ksoftirqd_CPU S C0105000     8     3      1             4     2 (L-TLB)
Call Trace:    [<c0105000>] [<c011ace6>] [<c011af8e>] [<c0105000>] 
[<c01057be>]
  [<c011af10>]
kswapd        R C109E36C    16     4      1             5     3 (L-TLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c012e8be>] 
[<c012e919>]
  [<c012ea4d>] [<c0105000>] [<c01057be>] [<c012e9b0>]
bdflush       S 00000000     0     5      1             6     4 (L-TLB)
Call Trace:    [<c01135f8>] [<c013a552>] [<c0105000>] [<c01057be>] 
[<c013a4a0>]
kupdated      S 00000000     8     6      1             7     5 (L-TLB)
Call Trace:    [<c0113038>] [<c019f21a>] [<c0112fc0>] [<c013a5e9>] 
[<c0105000>]
  [<c01057be>] [<c013a560>]
kjournald     S 00000000     0     7      1           106     6 (L-TLB)
Call Trace:    [<c01135f8>] [<c016da6e>] [<c016d940>] [<c01057be>] 
[<c016d960>]
kjournald     S 00000000   604   106      1           107     7 (L-TLB)
Call Trace:    [<c01135f8>] [<c016da6e>] [<c016d940>] [<c01057be>] 
[<c016d960>]
kjournald     S 00000000     0   107      1           108   106 (L-TLB)
Call Trace:    [<c01135f8>] [<c016da6e>] [<c016d940>] [<c01057be>] 
[<c016d960>]
kjournald     S 00000000    36   108      1           109   107 (L-TLB)
Call Trace:    [<c01135f8>] [<c016da6e>] [<c016d940>] [<c01057be>] 
[<c016d960>]
kjournald     S 00000000  1088   109      1           421   108 (L-TLB)
Call Trace:    [<c01135f8>] [<c016da6e>] [<c016d940>] [<c01057be>] 
[<c016d960>]
syslogd       R C1094CDC  1944   421      1           425   109 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c01925bb>] 
[<c012f58e>]
  [<c012f898>] [<c012741d>] [<c0160000>] [<c01274b6>] [<c0128c56>] 
[<c0124cd9>]
  [<c0124b08>] [<c0124e87>] [<c01123de>] [<c014554c>] [<c0112280>] 
[<c0107470>]
klogd         R 00000000     0   425      1           485   421 (NOTLB)
Call Trace:    [<c0115f67>] [<c0135ce3>] [<c010737f>]
xfs           R C104657C     4   485      1           491   425 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c012f58e>] 
[<c012f898>]
  [<c0130169>] [<c0124a26>] [<c0124b34>] [<c0124eb7>] [<c01123de>] 
[<c01132a1>]
  [<c0113042>] [<c0112280>] [<c0107470>] [<c01456ca>] [<c010737f>]
login         S 00000000  2656   491      1   656     492   485 (NOTLB)
Call Trace:    [<c0120246>] [<c011969c>] [<c0136c55>] [<c010737f>]
login         S 00000000     8   492      1   750     493   491 (NOTLB)
Call Trace:    [<c0120246>] [<c011969c>] [<c0136c55>] [<c010737f>]
login         S 00000000     0   493      1   807     494   492 (NOTLB)
Call Trace:    [<c0120246>] [<c011969c>] [<c0136c55>] [<c010737f>]
gdm-binary    S 00000000     0   494      1   525     627   493 (NOTLB)
Call Trace:    [<c0113085>] [<c01add1c>] [<c01457ef>] [<c01458d8>] 
[<c0145aa5>]
  [<c010737f>]
gdm-binary    S 00000000     0   525    494   543               (NOTLB)
Call Trace:    [<c011969c>] [<c010737f>]
X             R C1105120     0   526    525           543       (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c012f58e>] 
[<c012f898>]
  [<c012df15>] [<c012efb3>] [<c0130169>] [<c0124a26>] [<c0124b34>] 
[<c0124eb7>]
  [<c01123de>] [<c014554c>] [<c0112280>] [<c0107470>]
startkde      S 00000246     4   543    525   747           526 (NOTLB)
Call Trace:    [<c011969c>] [<c010737f>]
ssh-agent     R C10667BC     0   586    543           747       (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c01925bb>] 
[<c012f58e>]
  [<c012f898>] [<c012741d>] [<c0160000>] [<c01274b6>] [<c0128c56>] 
[<c0124cd9>]
  [<c0106a47>] [<c0124e87>] [<c01123de>] [<c014554c>] [<c0112280>] 
[<c0107470>]
kdeinit       S 00000000     4   624      1   862     749   742 (NOTLB)
Call Trace:    [<c0113085>] [<c01f0eee>] [<c01add1c>] [<c0145169>] 
[<c0145602>]
  [<c010737f>]
kdeinit       S 00000000     4   627      1           630   494 (NOTLB)
Call Trace:    [<c0113085>] [<c01f0eee>] [<c01add1c>] [<c0145169>] 
[<c0145602>]
  [<c010737f>]
kdeinit       R C1008FBC     4   630      1           632   627 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c01925bb>] 
[<c012f58e>]
  [<c012f898>] [<c012741d>] [<c0160000>] [<c01274b6>] [<c0128c56>] 
[<c0124cd9>]
  [<c0124b08>] [<c0124e87>] [<c01123de>] [<c014554c>] [<c0112280>] 
[<c0107470>]
kdeinit       R C1089E3C     0   632      1           742   630 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c012f58e>] 
[<c012f898>]
  [<c012df15>] [<c012efb3>] [<c0130169>] [<c0124a26>] [<c0124b34>] 
[<c0124eb7>]
  [<c01123de>] [<c013fef5>] [<c013d59d>] [<c0112280>] [<c0107470>]
bash          S 00000246     0   656    491   946               (NOTLB)
Call Trace:    [<c011969c>] [<c010737f>]
artsd         R C10B0FB0     4   736    624           784       (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c01925bb>] 
[<c012f58e>]
  [<c012f898>] [<c01132a1>] [<c012741d>] [<c01276f6>] [<c01274b6>] 
[<c0128c56>]
  [<c0124cd9>] [<c0124690>] [<c0124b08>] [<c0124e87>] [<c01123de>] 
[<c010d1d1>]
  [<c01065b8>] [<c01066be>] [<c0112280>] [<c0107470>]
kdeinit       S 00000000     0   742      1           624   632 (NOTLB)
Call Trace:    [<c0113085>] [<c013f497>] [<c0145169>] [<c0145602>] 
[<c010737f>]
kwrapper      S 00000000   256   747    543                 586 (NOTLB)
Call Trace:    [<c0113038>] [<c0112fc0>] [<c011e740>] [<c010737f>]
kdeinit       S 00000000  2656   749      1           793   624 (NOTLB)
Call Trace:    [<c0113085>] [<c01f0eee>] [<c01add1c>] [<c0145169>] 
[<c0145602>]
  [<c010737f>]
bash          S 00000246     4   750    492   947               (NOTLB)
Call Trace:    [<c011969c>] [<c010737f>]
kdeinit       S 00000000  1088   784    624           803   736 (NOTLB)
Call Trace:    [<c0113085>] [<c01f0eee>] [<c01add1c>] [<c0145169>] 
[<c0145602>]
  [<c010737f>]
kdeinit       R C10A2750     4   793      1           802   749 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c012f58e>] 
[<c012f898>]
  [<c012df15>] [<c012efb3>] [<c0130169>] [<c0124a26>] [<c0124b34>] 
[<c0124eb7>]
  [<c01123de>] [<c013fef5>] [<c013d59d>] [<c0112280>] [<c0107470>]
kdeinit       S 00000000     0   802      1           850   793 (NOTLB)
Call Trace:    [<c0113085>] [<c01f0eee>] [<c01add1c>] [<c0145169>] 
[<c0145602>]
  [<c010737f>]
kdeinit       S 00000000     0   803    624           804   784 (NOTLB)
Call Trace:    [<c0113038>] [<c0112fc0>] [<c01add1c>] [<c0145169>] 
[<c0145602>]
  [<c010737f>]
autorun       R C1051AFC     0   804    624           851   803 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c012f58e>] 
[<c0137cad>]
  [<c012f898>] [<c0137f10>] [<c01278a2>] [<c0139eae>] [<c013a0cb>] 
[<c0137c9a>]
  [<c0160135>] [<c0110307>] [<c0136ef3>] [<c01632f5>] [<c01276f6>] 
[<c01635d0>]
  [<c0140057>] [<c014074a>] [<c0140a27>] [<c0140e30>] [<c0134ea3>] 
[<c0135263>]
  [<c010737f>]
bash          S 00000246     0   807    493  1020               (NOTLB)
Call Trace:    [<c011969c>] [<c010737f>]
kdeinit       S 00000000     0   850      1           861   802 (NOTLB)
Call Trace:    [<c0113085>] [<c017b73d>] [<c01783b3>] [<c0145169>] 
[<c0145602>]
  [<c010737f>]
pam-panel-ico R C11058DC     0   851    624   857     853   804 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c01925bb>] 
[<c012f58e>]
  [<c012f898>] [<c012741d>] [<c0160000>] [<c01274b6>] [<c0128c56>] 
[<c0124cd9>]
  [<c0124b08>] [<c0124e87>] [<c01123de>] [<c01457ef>] [<c0107470>] 
[<c0144eba>]
  [<c0145b47>] [<c0112280>] [<c0107470>]
eggcups       R C10D9E5C  5156   853    624           862   851 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c012f58e>] 
[<c012f898>]
  [<c012df15>] [<c012efb3>] [<c0130169>] [<c0124a26>] [<c0124b34>] 
[<c0124eb7>]
  [<c01123de>] [<c01457ef>] [<c0144eba>] [<c0145b47>] [<c0112280>] 
[<c0107470>]
pam_timestamp R C115025C     0   857    851                     (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c01132a1>] 
[<c012f58e>]
  [<c012f898>] [<c0130169>] [<c0124a26>] [<c0124b34>] [<c0124eb7>] 
[<c01123de>]
  [<c014554c>] [<c0112280>] [<c0107470>]
gconfd-2      R C109ABE8     0   861      1                 850 (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c012f58e>] 
[<c012f898>]
  [<c012df15>] [<c012efb3>] [<c0130169>] [<c0124a26>] [<c0124b34>] 
[<c0124eb7>]
  [<c01123de>] [<c01457ef>] [<c0107470>] [<c0144eba>] [<c0145b47>] 
[<c0112280>]
  [<c0107470>]
kdeinit       S 00000000  1632   862    624   891           853 (NOTLB)
Call Trace:    [<c0113085>] [<c017b73d>] [<c01783b3>] [<c0145169>] 
[<c0145602>]
  [<c010737f>]
bash          S 00000000    28   864    862           891       (NOTLB)
Call Trace:    [<c0113085>] [<c017b567>] [<c01123de>] [<c017b060>] 
[<c0177108>]
  [<c0135ce3>] [<c010737f>]
bash          S 00000000     0   891    862                 864 (NOTLB)
Call Trace:    [<c0113085>] [<c017b567>] [<c01123de>] [<c017b060>] 
[<c0177108>]
  [<c0135ce3>] [<c010737f>]
vmstat        R C1107488  2028   945    656           946       (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c01925bb>] 
[<c012f58e>]
  [<c012f898>] [<c01132a1>] [<c012741d>] [<c01276f6>] [<c01274b6>] 
[<c0128c56>]
  [<c0124cd9>] [<c0124690>] [<c0144c0e>] [<c0124e87>] [<c01123de>] 
[<c0144b40>]
  [<c0155b24>] [<c0144b40>] [<c01444e6>] [<c0144b40>] [<c0144cf3>] 
[<c0143c2d>]
  [<c0112280>] [<c0107470>]
tee           S C01123DE     0   946    656                 945 (NOTLB)
Call Trace:    [<c01123de>] [<c013ef07>] [<c013f003>] [<c015dc69>] 
[<c0135ce3>]
  [<c010737f>]
load_vm.py    R current      0   947    750                     (NOTLB)
Call Trace:    [<c010afd8>] [<c012e27f>] [<c012e68d>] [<c012e703>] 
[<c012f58e>]
  [<c012f898>] [<c013038c>] [<c0124bcc>] [<c0124e87>] [<c01123de>] 
[<c0126588>]
  [<c012543d>] [<c0112280>] [<c0107470>]
sleep         R C10CE388  2664  1020    807                     (NOTLB)
Call Trace:    [<c012e4f3>] [<c012e68d>] [<c012e703>] [<c01925bb>] 
[<c012f58e>]
  [<c012f898>] [<c012741d>] [<c0160000>] [<c01274b6>] [<c0128c56>] 
[<c0124cd9>]
  [<c0124b08>] [<c0124e87>] [<c01123de>] [<c0125536>] [<c0113042>] 
[<c0112fc0>]
  [<c011e740>] [<c0112280>] [<c0107470>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init

>>EIP; 00000001 Before first symbol   <=====

Trace; c0113038 <schedule_timeout+58/b0>
Trace; c012f9dc <__get_free_pages+3c/40>
Trace; c0112fc0 <process_timeout+0/20>
Trace; c013f497 <pipe_poll+37/80>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c013d619 <sys_fstat64+49/80>
Trace; c010737f <system_call+33/38>
Proc;  keventd

>>EIP; 00000000 Before first symbol

Trace; c0123264 <context_thread+104/1b0>
Trace; c0123160 <context_thread+0/1b0>
Trace; c0105000 <_stext+0/0>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c0123160 <context_thread+0/1b0>
Proc;  ksoftirqd_CPU

>>EIP; c0105000 <_stext+0/0>   <=====

Trace; c0105000 <_stext+0/0>
Trace; c011ace6 <tasklet_action+46/70>
Trace; c011af8e <ksoftirqd+7e/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c011af10 <ksoftirqd+0/c0>
Proc;  kswapd

>>EIP; c109e36c <_end+e05094/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012e8be <kswapd_balance_pgdat+5e/a0>
Trace; c012e919 <kswapd_balance+19/30>
Trace; c012ea4d <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c012e9b0 <kswapd+0/c0>
Proc;  bdflush

>>EIP; 00000000 Before first symbol

Trace; c01135f8 <interruptible_sleep_on+38/60>
Trace; c013a552 <bdflush+b2/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c013a4a0 <bdflush+0/c0>
Proc;  kupdated

>>EIP; 00000000 Before first symbol

Trace; c0113038 <schedule_timeout+58/b0>
Trace; c019f21a <do_ide_request+1a/20>
Trace; c0112fc0 <process_timeout+0/20>
Trace; c013a5e9 <kupdate+89/100>
Trace; c0105000 <_stext+0/0>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c013a560 <kupdate+0/100>
Proc;  kjournald

>>EIP; 00000000 Before first symbol

Trace; c01135f8 <interruptible_sleep_on+38/60>
Trace; c016da6e <kjournald+10e/1d0>
Trace; c016d940 <commit_timeout+0/10>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c016d960 <kjournald+0/1d0>
Proc;  kjournald

>>EIP; 00000000 Before first symbol

Trace; c01135f8 <interruptible_sleep_on+38/60>
Trace; c016da6e <kjournald+10e/1d0>
Trace; c016d940 <commit_timeout+0/10>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c016d960 <kjournald+0/1d0>
Proc;  kjournald

>>EIP; 00000000 Before first symbol

Trace; c01135f8 <interruptible_sleep_on+38/60>
Trace; c016da6e <kjournald+10e/1d0>
Trace; c016d940 <commit_timeout+0/10>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c016d960 <kjournald+0/1d0>
Proc;  kjournald

>>EIP; 00000000 Before first symbol

Trace; c01135f8 <interruptible_sleep_on+38/60>
Trace; c016da6e <kjournald+10e/1d0>
Trace; c016d940 <commit_timeout+0/10>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c016d960 <kjournald+0/1d0>
Proc;  kjournald

>>EIP; 00000000 Before first symbol

Trace; c01135f8 <interruptible_sleep_on+38/60>
Trace; c016da6e <kjournald+10e/1d0>
Trace; c016d940 <commit_timeout+0/10>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c016d960 <kjournald+0/1d0>
Proc;  syslogd

>>EIP; c1094cdc <_end+dfba04/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c01925bb <submit_bh+5b/90>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012741d <page_cache_read+6d/d0>
Trace; c0160000 <ext3_get_block+0/90>
Trace; c01274b6 <read_cluster_nonblocking+36/50>
Trace; c0128c56 <filemap_nopage+106/210>
Trace; c0124cd9 <do_no_page+79/1b0>
Trace; c0124b08 <do_swap_page+b8/110>
Trace; c0124e87 <handle_mm_fault+77/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c014554c <sys_select+29c/4f0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  klogd

>>EIP; 00000000 Before first symbol

Trace; c0115f67 <do_syslog+127/2d0>
Trace; c0135ce3 <sys_read+a3/130>
Trace; c010737f <system_call+33/38>
Proc;  xfs

>>EIP; c104657c <_end+dad2a4/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c0130169 <read_swap_cache_async+a9/c0>
Trace; c0124a26 <swapin_readahead+36/60>
Trace; c0124b34 <do_swap_page+e4/110>
Trace; c0124eb7 <handle_mm_fault+a7/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c01132a1 <schedule+201/340>
Trace; c0113042 <schedule_timeout+62/b0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Trace; c01456ca <sys_select+41a/4f0>
Trace; c010737f <system_call+33/38>
Proc;  login

>>EIP; 00000000 Before first symbol

Trace; c0120246 <do_sigaction+e6/120>
Trace; c011969c <sys_wait4+10c/3c0>
Trace; c0136c55 <fput+d5/130>
Trace; c010737f <system_call+33/38>
Proc;  login

>>EIP; 00000000 Before first symbol

Trace; c0120246 <do_sigaction+e6/120>
Trace; c011969c <sys_wait4+10c/3c0>
Trace; c0136c55 <fput+d5/130>
Trace; c010737f <system_call+33/38>
Proc;  login

>>EIP; 00000000 Before first symbol

Trace; c0120246 <do_sigaction+e6/120>
Trace; c011969c <sys_wait4+10c/3c0>
Trace; c0136c55 <fput+d5/130>
Trace; c010737f <system_call+33/38>
Proc;  gdm-binary

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c01add1c <sock_poll+2c/40>
Trace; c01457ef <do_pollfd+4f/90>
Trace; c01458d8 <do_poll+a8/100>
Trace; c0145aa5 <sys_poll+175/2f0>
Trace; c010737f <system_call+33/38>
Proc;  gdm-binary

>>EIP; 00000000 Before first symbol

Trace; c011969c <sys_wait4+10c/3c0>
Trace; c010737f <system_call+33/38>
Proc;  X

>>EIP; c1105120 <_end+e6be48/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012df15 <lru_cache_add+65/70>
Trace; c012efb3 <rw_swap_page+43/60>
Trace; c0130169 <read_swap_cache_async+a9/c0>
Trace; c0124a26 <swapin_readahead+36/60>
Trace; c0124b34 <do_swap_page+e4/110>
Trace; c0124eb7 <handle_mm_fault+a7/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c014554c <sys_select+29c/4f0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  startkde

>>EIP; 00000246 Before first symbol   <=====

Trace; c011969c <sys_wait4+10c/3c0>
Trace; c010737f <system_call+33/38>
Proc;  ssh-agent

>>EIP; c10667bc <_end+dcd4e4/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c01925bb <submit_bh+5b/90>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012741d <page_cache_read+6d/d0>
Trace; c0160000 <ext3_get_block+0/90>
Trace; c01274b6 <read_cluster_nonblocking+36/50>
Trace; c0128c56 <filemap_nopage+106/210>
Trace; c0124cd9 <do_no_page+79/1b0>
Trace; c0106a47 <setup_frame+117/200>
Trace; c0124e87 <handle_mm_fault+77/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c014554c <sys_select+29c/4f0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c01f0eee <unix_poll+2e/a0>
Trace; c01add1c <sock_poll+2c/40>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c01f0eee <unix_poll+2e/a0>
Trace; c01add1c <sock_poll+2c/40>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  kdeinit

>>EIP; c1008fbc <_end+d6fce4/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c01925bb <submit_bh+5b/90>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012741d <page_cache_read+6d/d0>
Trace; c0160000 <ext3_get_block+0/90>
Trace; c01274b6 <read_cluster_nonblocking+36/50>
Trace; c0128c56 <filemap_nopage+106/210>
Trace; c0124cd9 <do_no_page+79/1b0>
Trace; c0124b08 <do_swap_page+b8/110>
Trace; c0124e87 <handle_mm_fault+77/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c014554c <sys_select+29c/4f0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  kdeinit

>>EIP; c1089e3c <_end+df0b64/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012df15 <lru_cache_add+65/70>
Trace; c012efb3 <rw_swap_page+43/60>
Trace; c0130169 <read_swap_cache_async+a9/c0>
Trace; c0124a26 <swapin_readahead+36/60>
Trace; c0124b34 <do_swap_page+e4/110>
Trace; c0124eb7 <handle_mm_fault+a7/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c013fef5 <path_release+15/40>
Trace; c013d59d <sys_lstat64+4d/80>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  bash

>>EIP; 00000246 Before first symbol   <=====

Trace; c011969c <sys_wait4+10c/3c0>
Trace; c010737f <system_call+33/38>
Proc;  artsd

>>EIP; c10b0fb0 <_end+e17cd8/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c01925bb <submit_bh+5b/90>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c01132a1 <schedule+201/340>
Trace; c012741d <page_cache_read+6d/d0>
Trace; c01276f6 <__lock_page+a6/c0>
Trace; c01274b6 <read_cluster_nonblocking+36/50>
Trace; c0128c56 <filemap_nopage+106/210>
Trace; c0124cd9 <do_no_page+79/1b0>
Trace; c0124690 <do_wp_page+50/200>
Trace; c0124b08 <do_swap_page+b8/110>
Trace; c0124e87 <handle_mm_fault+77/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c010d1d1 <restore_i387+91/d0>
Trace; c01065b8 <restore_sigcontext+128/140>
Trace; c01066be <sys_sigreturn+ee/100>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c013f497 <pipe_poll+37/80>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  kwrapper

>>EIP; 00000000 Before first symbol

Trace; c0113038 <schedule_timeout+58/b0>
Trace; c0112fc0 <process_timeout+0/20>
Trace; c011e740 <sys_nanosleep+d0/160>
Trace; c010737f <system_call+33/38>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c01f0eee <unix_poll+2e/a0>
Trace; c01add1c <sock_poll+2c/40>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  bash

>>EIP; 00000246 Before first symbol   <=====

Trace; c011969c <sys_wait4+10c/3c0>
Trace; c010737f <system_call+33/38>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c01f0eee <unix_poll+2e/a0>
Trace; c01add1c <sock_poll+2c/40>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  kdeinit

>>EIP; c10a2750 <_end+e09478/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012df15 <lru_cache_add+65/70>
Trace; c012efb3 <rw_swap_page+43/60>
Trace; c0130169 <read_swap_cache_async+a9/c0>
Trace; c0124a26 <swapin_readahead+36/60>
Trace; c0124b34 <do_swap_page+e4/110>
Trace; c0124eb7 <handle_mm_fault+a7/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c013fef5 <path_release+15/40>
Trace; c013d59d <sys_lstat64+4d/80>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c01f0eee <unix_poll+2e/a0>
Trace; c01add1c <sock_poll+2c/40>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113038 <schedule_timeout+58/b0>
Trace; c0112fc0 <process_timeout+0/20>
Trace; c01add1c <sock_poll+2c/40>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  autorun

>>EIP; c1051afc <_end+db8824/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c0137cad <getblk+4d/60>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c0137f10 <bread+20/90>
Trace; c01278a2 <find_or_create_page+72/f0>
Trace; c0139eae <grow_dev_page+2e/c0>
Trace; c013a0cb <grow_buffers+9b/110>
Trace; c0137c9a <getblk+3a/60>
Trace; c0160135 <ext3_getblk+a5/2d0>
Trace; c0110307 <amd_set_mtrr_up+97/c0>
Trace; c0136ef3 <__wait_on_buffer+73/90>
Trace; c01632f5 <ext3_find_entry+f5/390>
Trace; c01276f6 <__lock_page+a6/c0>
Trace; c01635d0 <ext3_lookup+40/b0>
Trace; c0140057 <real_lookup+c7/f0>
Trace; c014074a <link_path_walk+59a/6c0>
Trace; c0140a27 <path_lookup+37/40>
Trace; c0140e30 <open_namei+70/540>
Trace; c0134ea3 <filp_open+43/70>
Trace; c0135263 <sys_open+53/a0>
Trace; c010737f <system_call+33/38>
Proc;  bash

>>EIP; 00000246 Before first symbol   <=====

Trace; c011969c <sys_wait4+10c/3c0>
Trace; c010737f <system_call+33/38>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c017b73d <normal_poll+11d/170>
Trace; c01783b3 <tty_poll+83/b0>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  pam-panel-ico

>>EIP; c11058dc <_end+e6c604/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c01925bb <submit_bh+5b/90>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012741d <page_cache_read+6d/d0>
Trace; c0160000 <ext3_get_block+0/90>
Trace; c01274b6 <read_cluster_nonblocking+36/50>
Trace; c0128c56 <filemap_nopage+106/210>
Trace; c0124cd9 <do_no_page+79/1b0>
Trace; c0124b08 <do_swap_page+b8/110>
Trace; c0124e87 <handle_mm_fault+77/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c01457ef <do_pollfd+4f/90>
Trace; c0107470 <error_code+34/3c>
Trace; c0144eba <poll_freewait+3a/50>
Trace; c0145b47 <sys_poll+217/2f0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  eggcups

>>EIP; c10d9e5c <_end+e40b84/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012df15 <lru_cache_add+65/70>
Trace; c012efb3 <rw_swap_page+43/60>
Trace; c0130169 <read_swap_cache_async+a9/c0>
Trace; c0124a26 <swapin_readahead+36/60>
Trace; c0124b34 <do_swap_page+e4/110>
Trace; c0124eb7 <handle_mm_fault+a7/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c01457ef <do_pollfd+4f/90>
Trace; c0144eba <poll_freewait+3a/50>
Trace; c0145b47 <sys_poll+217/2f0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  pam_timestamp

>>EIP; c115025c <_end+eb6f84/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c01132a1 <schedule+201/340>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c0130169 <read_swap_cache_async+a9/c0>
Trace; c0124a26 <swapin_readahead+36/60>
Trace; c0124b34 <do_swap_page+e4/110>
Trace; c0124eb7 <handle_mm_fault+a7/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c014554c <sys_select+29c/4f0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  gconfd-2

>>EIP; c109abe8 <_end+e01910/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012df15 <lru_cache_add+65/70>
Trace; c012efb3 <rw_swap_page+43/60>
Trace; c0130169 <read_swap_cache_async+a9/c0>
Trace; c0124a26 <swapin_readahead+36/60>
Trace; c0124b34 <do_swap_page+e4/110>
Trace; c0124eb7 <handle_mm_fault+a7/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c01457ef <do_pollfd+4f/90>
Trace; c0107470 <error_code+34/3c>
Trace; c0144eba <poll_freewait+3a/50>
Trace; c0145b47 <sys_poll+217/2f0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  kdeinit

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c017b73d <normal_poll+11d/170>
Trace; c01783b3 <tty_poll+83/b0>
Trace; c0145169 <do_select+f9/210>
Trace; c0145602 <sys_select+352/4f0>
Trace; c010737f <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c017b567 <write_chan+157/210>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c017b060 <read_chan+260/610>
Trace; c0177108 <tty_read+d8/110>
Trace; c0135ce3 <sys_read+a3/130>
Trace; c010737f <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c0113085 <schedule_timeout+a5/b0>
Trace; c017b567 <write_chan+157/210>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c017b060 <read_chan+260/610>
Trace; c0177108 <tty_read+d8/110>
Trace; c0135ce3 <sys_read+a3/130>
Trace; c010737f <system_call+33/38>
Proc;  vmstat

>>EIP; c1107488 <_end+e6e1b0/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c01925bb <submit_bh+5b/90>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c01132a1 <schedule+201/340>
Trace; c012741d <page_cache_read+6d/d0>
Trace; c01276f6 <__lock_page+a6/c0>
Trace; c01274b6 <read_cluster_nonblocking+36/50>
Trace; c0128c56 <filemap_nopage+106/210>
Trace; c0124cd9 <do_no_page+79/1b0>
Trace; c0124690 <do_wp_page+50/200>
Trace; c0144c0e <filldir64+ce/110>
Trace; c0124e87 <handle_mm_fault+77/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c0144b40 <filldir64+0/110>
Trace; c0155b24 <proc_root_readdir+34/90>
Trace; c0144b40 <filldir64+0/110>
Trace; c01444e6 <vfs_readdir+a6/b0>
Trace; c0144b40 <filldir64+0/110>
Trace; c0144cf3 <sys_getdents64+a3/c0>
Trace; c0143c2d <sys_fcntl64+5d/c0>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  tee

>>EIP; c01123de <do_page_fault+15e/4df>   <=====

Trace; c01123de <do_page_fault+15e/4df>
Trace; c013ef07 <pipe_wait+87/c0>
Trace; c013f003 <pipe_read+c3/200>
Trace; c015dc69 <ext3_file_write+39/d0>
Trace; c0135ce3 <sys_read+a3/130>
Trace; c010737f <system_call+33/38>
Proc;  load_vm.py

>>EIP; 0000000c Before first symbol   <=====

Trace; c010afd8 <call_do_IRQ+5/d>
Trace; c012e27f <shrink_cache+ef/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c013038c <swap_free+2c/50>
Trace; c0124bcc <do_anonymous_page+6c/100>
Trace; c0124e87 <handle_mm_fault+77/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c0126588 <do_brk+118/210>
Trace; c012543d <sys_brk+fd/130>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Proc;  sleep

>>EIP; c10ce388 <_end+e350b0/8587da8>   <=====

Trace; c012e4f3 <shrink_cache+363/370>
Trace; c012e68d <shrink_caches+3d/60>
Trace; c012e703 <try_to_free_pages_zone+53/e0>
Trace; c01925bb <submit_bh+5b/90>
Trace; c012f58e <balance_classzone+4e/1f0>
Trace; c012f898 <__alloc_pages+168/270>
Trace; c012741d <page_cache_read+6d/d0>
Trace; c0160000 <ext3_get_block+0/90>
Trace; c01274b6 <read_cluster_nonblocking+36/50>
Trace; c0128c56 <filemap_nopage+106/210>
Trace; c0124cd9 <do_no_page+79/1b0>
Trace; c0124b08 <do_swap_page+b8/110>
Trace; c0124e87 <handle_mm_fault+77/110>
Trace; c01123de <do_page_fault+15e/4df>
Trace; c0125536 <__vma_link+56/d0>
Trace; c0113042 <schedule_timeout+62/b0>
Trace; c0112fc0 <process_timeout+0/20>
Trace; c011e740 <sys_nanosleep+d0/160>
Trace; c0112280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>


2 warnings issued.  Results may not be reliable.


[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux desktop 2.4.23-pre4 #1 Sat Sep 20 16:39:09 EST 2003 i686 athlon i386 
GNU/Linux

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         radeon agpgart tulip crc32 ext2

[7.2.] Processor information (from /proc/cpuinfo):
I've confirmed the same behaviour on both Athlon XP1800+ desktop model and 
Athlon 1800+ Mobile laptop model.
(Desktop is an ALi chipset, whereas Laptop is an ATI IGP+ALi combo)

[7.3.] Module information (from /proc/modules):
radeon                113924   1
agpgart                19472   3
tulip                  44032   2
crc32                   3680   0 [tulip]
ext2                   38336   1 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
N/A

[7.5.] PCI information ('lspci -vvv' as root)
N/A

[7.6.] SCSI information (from /proc/scsi/scsi)
N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
Please use 128 MB Ram with 256 MB swap to reproduce the issue really quick. 
Execute this utility (It tries to build a massive dictionary (hash table) in 
python):
### Starts here ###
#!/usr/bin/python

import sys
from string import *

d = {}
i = 0
for l1 in letters:
    for l2 in letters:
        for l3 in letters:
            for l4 in letters:
                d[i] = l1+l2+l3+l4
                i += 1

print "Number of items in d: %s" % len(d)
while True:
    try:
        a = int(raw_input("Provide the input: "))
        print d[a]
    except KeyError:
        print "%s not in d" % a
    except KeyboardInterrupt:
        print "Good Bye"
        sys.exit()
### Ends here ###

Workaround: Use 2.4.22aa1 instead :-).

In the case of 2.4.22aa1 the VM kills the offending process (after killing few 
innocent ones along the way :-), and then everything is fine. But in 
2.4.23-pre4 everything stops working (for eg, the vmstat session doesn't 
progress etc..).

Please feel free to ask for more information.

Thanks
-- 
Hari
harisri@bigpond.com

