Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUESLjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUESLjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUESLjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:39:37 -0400
Received: from www.gibraltar.at ([212.152.170.220]:42458 "EHLO
	mail.gibraltar.at") by vger.kernel.org with ESMTP id S263664AbUESLjU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:39:20 -0400
Message-ID: <40AB4747.7020301@gibraltar.at>
Date: Wed, 19 May 2004 13:38:47 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.26
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I recently get oopses with a custom 2.4.26 kernel (freeswan patches and 
most of the "safe" netfilter POM stuff), but only on one machine and 
never on any other machine.

gibraltar-tza:~# uname -a
Linux gibraltar-tza 2.4.26-gib1 #14 Son Apr 25 22:37:07 CEST 2004 i686 
unknown
gibraltar-tza:~# lsmod
Module                  Size  Used by    Tainted: P
ipt_REDIRECT             696  10  (autoclean)
af_packet              14504   5  (autoclean)
ipv6                  174836  -1  (autoclean)
ds                      6548   1
yenta_socket           10208   1
pcmcia_core            44256   0  [ds yenta_socket]
ipt_limit                760   1  (autoclean)
ipt_LOG                 3352   3  (autoclean)
ipt_REJECT              2936  14  (autoclean)
ipt_state                312  66  (autoclean)
ipt_MASQUERADE          1208   1  (autoclean)
iptable_filter          1420   1  (autoclean)
ext3                   61088   2  (autoclean)
jbd                    41284   2  (autoclean) [ext3]
ide-floppy             12444   0  (autoclean)
ide-tape               43600   0  (autoclean)
ide-disk               14304   3  (autoclean)
md                     45728   0  (autoclean) (unused)
sundance               14112   5
mii                     2224   0  [sundance]
b44                    14316   1
speedtch                8624   0  (unused)
atm                    36792   0  [speedtch]
crc32                   2752   0  [sundance speedtch]
ppp_mppe               11736   0  (unused)
ppp_generic            21412   0  [ppp_mppe]
slhc                    4864   0  [ppp_generic]
ip_nat_ftp              2896   0  (unused)
iptable_nat            17806   2  [ipt_REDIRECT ipt_MASQUERADE ip_nat_ftp]
ip_conntrack_ftp        3856   1
ip_conntrack           22532   1  [ipt_REDIRECT ipt_state ipt_MASQUERADE 
ip_nat_ftp iptable_nat ip_conntrack_ftp]
ip_tables              12800  10  [ipt_REDIRECT ipt_limit ipt_LOG 
ipt_REJECT ipt_state ipt_MASQUERADE iptable_filter iptable_nat]
rtc                     7144   0  (autoclean)
ehci-hcd               17996   0  (autoclean) (unused)
usb-ohci               19880   0  (autoclean) (unused)
sd_mod                 10540   0  (autoclean)
usb-storage            66400   0  (autoclean)
scsi_mod               57368   2  (autoclean) [sd_mod usb-storage]
usbcore                62156   1  (autoclean) [speedtch ehci-hcd 
usb-ohci usb-storage]
reiserfs              181200   0  (autoclean) (unused)
vfat                    9964   0  (autoclean)
fat                    32216   0  (autoclean) [vfat]
ide-cd                 30624   1  (autoclean)
ide-detect               256   0  (autoclean) (unused)
ide-core              107964   4  (autoclean) [ide-floppy ide-tape 
ide-disk usb-storage ide-cd ide-detect]
cdrom                  26944   0  (autoclean) [ide-cd]

Tainting is because of the ppp_mppe module, which has a BSD license, but 
is not used in this case.

The syslog reads:


May 19 12:45:03 gibraltar-tza postfix/pickup[11608]: BD49944215: uid=0 
from=<root>
May 19 12:45:03 gibraltar-tza postfix/cleanup[22491]: BD49944215: 
message-id=<20040519104503.BD49944215@gibraltar.tza.at>
May 19 12:45:03 gibraltar-tza postfix/qmgr[17520]: BD49944215: 
from=<root@tza.at>, size=404114, nrcpt=1 (queue active)
May 19 12:45:04 gibraltar-tza postfix/cleanup[22491]: 1377E44217: 
message-id=<20040519104503.BD49944215@gibraltar.tza.at>
May 19 12:45:04 gibraltar-tza postfix/local[30706]: BD49944215: 
to=<root@tza.at>, orig_to=<root>, relay=local, delay=1, status=sent 
(forwarded as 1377E44217)
May 19 12:45:04 gibraltar-tza postfix/qmgr[17520]: 1377E44217: 
from=<root@tza.at>, size=404238, nrcpt=1 (queue active)
May 19 12:45:04 gibraltar-tza kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000003
May 19 12:45:04 gibraltar-tza kernel:  printing eip:
May 19 12:45:04 gibraltar-tza kernel: 00000003
May 19 12:45:04 gibraltar-tza kernel: *pde = 00000000
May 19 12:45:04 gibraltar-tza kernel: Oops: 0000
May 19 12:45:04 gibraltar-tza kernel: CPU:    0
May 19 12:45:04 gibraltar-tza kernel: EIP:    0010:[<00000003>] 
Tainted: P
May 19 12:45:04 gibraltar-tza kernel: EFLAGS: 00010202
May 19 12:45:04 gibraltar-tza kernel: eax: 00000001   ebx: 00000001 
ecx: 00000000   edx: 00000020
May 19 12:45:04 gibraltar-tza kernel: esi: 00000001   edi: c51ae8b8 
ebp: c51ae790   esp: c2967e78
May 19 12:45:04 gibraltar-tza kernel: ds: 0018   es: 0018   ss: 0018
May 19 12:45:04 gibraltar-tza kernel: Process smtp (pid: 18410, 
stackpage=c2967000)
May 19 12:45:04 gibraltar-tza kernel: Stack: 00000028 cb977d20 c51ae8b8 
cba4a8c0 c51ae790 c51ae790 c025e378 c51ae790
May 19 12:45:04 gibraltar-tza kernel:        cb977cf0 00000000 c51ae790 
c51ae8b8 c0261173 c51ae790 c1425750 c2967efc
May 19 12:45:04 gibraltar-tza kernel:        c51ae790 00000010 c5ad9e20 
c02703e0 c51ae790 c2967efc 00000010 c5ad9e20
May 19 12:45:04 gibraltar-tza kernel: Call Trace: 
[tcp_connect+520/608] [tcp_v4_connect+403/880] 
[inet_stream_connect+352/720] [sys_connect+86/128] [d_alloc+25/384]
May 19 12:45:04 gibraltar-tza kernel:   [sock_map_fd+244/384] 
[kmem_cache_free+19/32] [do_fcntl+208/592] [sys_socketcall+161/448] 
[sys_fcntl64+67/144] [system_call+51/64]
May 19 12:45:04 gibraltar-tza kernel:
May 19 12:45:04 gibraltar-tza kernel: Code:  Bad EIP value.
May 19 12:45:04 gibraltar-tza postfix/qmgr[17520]: warning: premature 
end-of-input on private/smtp socket while reading input attribute name
May 19 12:45:04 gibraltar-tza postfix/qmgr[17520]: warning: private/smtp 
socket: malformed response
May 19 12:45:04 gibraltar-tza postfix/qmgr[17520]: warning: transport 
smtp failure -- see a previous warning/fatal/panic logfile record for 
the problem description
May 19 12:45:04 gibraltar-tza postfix/master[11652]: warning: process 
/usr/lib/postfix/smtp pid 18410 killed by signal 11
May 19 12:45:04 gibraltar-tza postfix/master[11652]: warning: 
/usr/lib/postfix/smtp: bad command startup -- throttling
May 19 12:45:04 gibraltar-tza postfix/pickup[11608]: 8F9B944215: uid=0 
from=<root>
May 19 12:45:04 gibraltar-tza postfix/cleanup[22491]: 8F9B944215: 
message-id=<20040519104504.8F9B944215@gibraltar.tza.at>
May 19 12:45:04 gibraltar-tza postfix/qmgr[17520]: 8F9B944215: 
from=<root@tza.at>, size=604, nrcpt=1 (queue active)
May 19 12:45:04 gibraltar-tza postfix/cleanup[22491]: 9A7E244218: 
message-id=<20040519104504.8F9B944215@gibraltar.tza.at>
May 19 12:45:04 gibraltar-tza postfix/qmgr[17520]: 9A7E244218: 
from=<root@tza.at>, size=728, nrcpt=1 (queue active)
May 19 12:45:04 gibraltar-tza postfix/local[30706]: 8F9B944215: 
to=<root@tza.at>, orig_to=<root>, relay=local, delay=0, status=sent 
(forwarded as 9A7E244218)
May 19 12:45:06 gibraltar-tza p3scan[2915]: Connection from 
192.168.123.74:2223
May 19 12:45:06 gibraltar-tza p3scan[2915]: Real-server adress is 
x.x.x.x:110
May 19 12:45:06 gibraltar-tza kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000003
May 19 12:45:06 gibraltar-tza kernel:  printing eip:
May 19 12:45:06 gibraltar-tza kernel: 00000003
May 19 12:45:06 gibraltar-tza kernel: *pde = 00000000
May 19 12:45:06 gibraltar-tza kernel: Oops: 0000
May 19 12:45:06 gibraltar-tza kernel: CPU:    0
May 19 12:45:06 gibraltar-tza kernel: EIP:    0010:[<00000003>] 
Tainted: P
May 19 12:45:06 gibraltar-tza kernel: EFLAGS: 00010202
May 19 12:45:06 gibraltar-tza kernel: eax: 00000001   ebx: 00000001 
ecx: 00000000   edx: 00000020
May 19 12:45:06 gibraltar-tza kernel: esi: 00000001   edi: cb1afc68 
ebp: cb1afb40   esp: c2cfbe78
May 19 12:45:06 gibraltar-tza kernel: ds: 0018   es: 0018   ss: 0018
May 19 12:45:06 gibraltar-tza kernel: Process p3scan (pid: 2915, 
stackpage=c2cfb000)
May 19 12:45:06 gibraltar-tza kernel: Stack: 00000028 cb8dc650 cb1afc68 
cb8c4bc0 cb1afb40 cb1afb40 c025e378 cb1afb40
May 19 12:45:06 gibraltar-tza kernel:        cb8dc620 00000000 cb1afb40 
cb1afc68 c0261173 cb1afb40 c1425330 c2cfbefc
May 19 12:45:06 gibraltar-tza kernel:        cb1afb40 00000010 c6d94740 
c02703e0 cb1afb40 c2cfbefc 00000010 c6d94740
May 19 12:45:06 gibraltar-tza kernel: Call Trace: 
[tcp_connect+520/608] [tcp_v4_connect+403/880] 
[inet_stream_connect+352/720] [sys_connect+86/128] 
[jbd:journal_flushpage_Rc9a5f737+694/7440]
May 19 12:45:06 gibraltar-tza kernel:   [tcp_setsockopt+61/1440] 
[inet_setsockopt+37/48] [sys_setsockopt+67/128] [sys_setsockopt+82/128] 
[sys_socketcall+161/448] [system_call+51/64]
May 19 12:45:06 gibraltar-tza kernel:
May 19 12:45:06 gibraltar-tza kernel: Code:  Bad EIP value.
May 19 12:45:06 gibraltar-tza p3scan[11274]: Attention: child with pid 
2915 died with abnormal termsignal (11)! This is probably a bug. Please 
report to the author. numprocs is now 2
May 19 12:45:06 gibraltar-tza p3scan[6731]: Connection from 
192.168.123.74:2225
May 19 12:45:06 gibraltar-tza p3scan[6731]: Real-server adress is 
x.x.x.x:110
May 19 12:45:06 gibraltar-tza kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000003
May 19 12:45:06 gibraltar-tza kernel:  printing eip:
May 19 12:45:06 gibraltar-tza kernel: 00000003
May 19 12:45:06 gibraltar-tza kernel: *pde = 00000000
May 19 12:45:06 gibraltar-tza kernel: Oops: 0000
May 19 12:45:06 gibraltar-tza kernel: CPU:    0
May 19 12:45:06 gibraltar-tza kernel: EIP:    0010:[<00000003>] 
Tainted: P
May 19 12:45:06 gibraltar-tza kernel: EFLAGS: 00010202
May 19 12:45:06 gibraltar-tza kernel: eax: 00000001   ebx: 00000001 
ecx: 00000000   edx: 00000020
May 19 12:45:06 gibraltar-tza kernel: esi: 00000001   edi: c6cd2c78 
ebp: c6cd2b50   esp: c2cfbe78
May 19 12:45:06 gibraltar-tza kernel: ds: 0018   es: 0018   ss: 0018
May 19 12:45:06 gibraltar-tza kernel: Process p3scan (pid: 6731, 
stackpage=c2cfb000)
May 19 12:45:06 gibraltar-tza kernel: Stack: 00000028 cb8ea430 c6cd2c78 
c5ddeb00 c6cd2b50 c6cd2b50 c025e378 c6cd2b50
May 19 12:45:06 gibraltar-tza kernel:        cb8ea400 00000000 c6cd2b50 
c6cd2c78 c0261173 c6cd2b50 c14258b0 c2cfbefc
May 19 12:45:06 gibraltar-tza kernel:        c6cd2b50 00000010 c85fda90 
c02703e0 c6cd2b50 c2cfbefc 00000010 c85fda90
May 19 12:45:06 gibraltar-tza kernel: Call Trace: 
[tcp_connect+520/608] [tcp_v4_connect+403/880] 
[inet_stream_connect+352/720] [sys_connect+86/128] [tcp_setsockopt+61/1440]
May 19 12:45:06 gibraltar-tza kernel:   [inet_setsockopt+37/48] 
[sys_setsockopt+67/128] [sys_setsockopt+82/128] [sys_socketcall+161/448] 
[system_call+51/64]
May 19 12:45:06 gibraltar-tza kernel:
May 19 12:45:06 gibraltar-tza kernel: Code:  Bad EIP value.
May 19 12:45:06 gibraltar-tza p3scan[11274]: Attention: child with pid 
6731 died with abnormal termsignal (11)! This is probably a bug. Please 
report to the author. numprocs is now 2
May 19 12:45:06 gibraltar-tza p3scan[8091]: Connection from 
192.168.123.74:2229
May 19 12:45:06 gibraltar-tza p3scan[8091]: Real-server adress is 
x.x.x.x:110
May 19 12:45:06 gibraltar-tza kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000003

<snip>

So it seems to be somehow related to inet_setsockopt. Since this is a 
fiewall, I have limited debugging capabilities on the machine. If 
necessary, I might be able to get the ksymoops.

best regards,
Rene
