Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUBLFSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 00:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUBLFSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 00:18:25 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:21663 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S266279AbUBLFSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 00:18:14 -0500
Date: Wed, 11 Feb 2004 21:18:10 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: lock up with 2.4.23
Message-ID: <Pine.LNX.4.58.0402111939370.5221@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The machine is a dual P3 1.4GHz, with 4Gb ram and ~ 9Gb swap.  Disk is
attached via onboard SCSI.  sda is 6 ext2 partitions and 5 swap
partitions.  sdb1, sdc1, and sdd1 are combined as md0 in a raid5 and
formatted jfs.

When the machine locked up, it was not pingable.  I connected via serial
console and used sysrq to sync and remount the disks readonly.  I also got
output from sysrq+t, sysrq+p, and sysrq+m.  Output is below.

When I tried sysrq+b, the machine hung completely.  It did not boot and
was no longer responsive to sysrq requests.

After physically resetting the machine, it came up and attempted to fsck
the disks, indicating that the were not remounted readonly, even though
sysrq+u returned indicating that they had been.

The machine takes messages via a sendmail milter, passes them through
mimedefang which splits them out into their components, then scans them
with sophos.

sysrq+t shows three processes in D:  jfsCommit and two mimedefang.pl
processes.

Any ideas?


-Chris

telnet> send brk
<6>SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem showPc unRaw Sync showTasks Unmount

telnet> send brk
SysRq : Emergency Sync

telnet> send brk
SysRq : Emergency Remount R/O

telnet> send brk
SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C3FFBF28     0     1      0 25084               (NOTLB)
Call Trace:    [<c0130b01>] [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>]
  [<c0106fa3>]
keventd       S C3FEC000     0     2      1             3       (L-TLB)
Call Trace:    [<c0123ebc>] [<c01056d8>]
ksoftirqd_CPU S C3FEA000     0     3      1             4     2 (L-TLB)
Call Trace:    [<c011c1ce>] [<c01056d8>]
ksoftirqd_CPU S C3FE8000     0     4      1             5     3 (L-TLB)
Call Trace:    [<c011c1ce>] [<c01056d8>]
kswapd        S C3FD8000     0     5      1             6     4 (L-TLB)
Call Trace:    [<c013033b>] [<c01056d8>]
bdflush       R 00000286     0     6      1             7     5 (L-TLB)
Call Trace:    [<c011479e>] [<c013b297>] [<c01056d8>]
kupdated      S C3FB5F30     0     7      1             8     6 (L-TLB)
Call Trace:    [<c01730c5>] [<c0173159>] [<c0113e3a>] [<c0113d60>] [<c013b377>]
  [<c01705ff>] [<c01708b1>] [<c0172345>] [<c01723d9>] [<c0106f56>] [<c013b29c>]
  [<c01056d8>]
jfsIO         S C3FA2000     0     8      1             9     7 (L-TLB)
Call Trace:    [<c0192727>] [<c0192b48>] [<c01056d8>]
jfsCommit     D C3FA0000     0     9      1            10     8 (L-TLB)
Call Trace:    [<c0190241>] [<c0190598>] [<c01903c4>] [<c0185717>] [<c019511f>]
  [<c0194f48>] [<c019565b>] [<c0195850>] [<c01056d8>]
jfsSync       S C3F9E000   376    10      1            11     9 (L-TLB)
Call Trace:    [<c0195db7>] [<c01056d8>]
ahc_dv_0      S F7AD3F2C  5944    11      1            12    10 (L-TLB)
Call Trace:    [<c0105cfc>] [<c0105df2>] [<c01e7d9a>] [<c01056d8>]
ahc_dv_1      S C3FE2D0C  6052    12      1            13    11 (L-TLB)
Call Trace:    [<c0105cfc>] [<c0105df2>] [<c01e7d9a>] [<c01056d8>]
scsi_eh_0     S F7ABDFD8     0    13      1            14    12 (L-TLB)
Call Trace:    [<c0105cfc>] [<c0105df2>] [<c01dcd52>] [<c01056d8>]
scsi_eh_1     S F7AB7FD8    36    14      1            15    13 (L-TLB)
Call Trace:    [<c0105cfc>] [<c0105df2>] [<c01dcd52>] [<c01056d8>]
mdrecoveryd   S F7A0E000     0    15      1            16    14 (L-TLB)
Call Trace:    [<c02149b1>] [<c01056d8>]
raid5d        S F7A04000   132    16      1            17    15 (L-TLB)
Call Trace:    [<c02149b1>] [<c01056d8>]
raid5syncd    S F74A8000     0    17      1           216    16 (L-TLB)
Call Trace:    [<c02149b1>] [<c01056d8>]
syslogd       R 7FFFFFFF     0   216      1           220    17 (NOTLB)
Call Trace:    [<c0113dd7>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
klogd         R F6FA2000     0   220      1           225   216 (NOTLB)
Call Trace:    [<c011714f>] [<c015987a>] [<c0136b2d>] [<c0106fa3>]
inetd         S F6FB7FAC     0   225      1          1090   220 (NOTLB)
Call Trace:    [<c01060e7>] [<c0106fa3>]
sendmail      S F6EE1F28     0  1090      1          1096   225 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
sendmail      S 00000000  5512  1096      1  1098    1105  1090 (NOTLB)
Call Trace:    [<c011ac84>] [<c0106fa3>]
sendmail      S F6ED2000  4268  1098   1096                     (NOTLB)
Call Trace:    [<c010c76d>] [<c0106fa3>]
sendmail      S 00000000  1376  1105      1  1106    1111  1096 (NOTLB)
Call Trace:    [<c011ac84>] [<c0106fa3>]
sendmail      S F6EE4000  1376  1106   1105                     (NOTLB)
Call Trace:    [<c010c76d>] [<c0106fa3>]
sshd          S 7FFFFFFF     0  1111      1          1118  1105 (NOTLB)
Call Trace:    [<c0113dd7>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
ntpd          S 7FFFFFFF     0  1118      1          1125  1111 (NOTLB)
Call Trace:    [<c0113dd7>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mdadm         S F6E75F88  1376  1125      1          1129  1118 (NOTLB)
Call Trace:    [<c0149adb>] [<c0113e3a>] [<c0113d60>] [<c011f858>] [<c0106fa3>]
cron          S F6DBFF88  4576  1129      1          1203  1125 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c011f858>] [<c0106fa3>]
apache        S F59D1F28  2400  1203      1 20178    1217  1129 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
logger        S F597C000     0  1210   1203          1211       (NOTLB)
Call Trace:    [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
logger        S F59A0000     0  1211   1203         24812  1210 (NOTLB)
Call Trace:    [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
sophie        S 7FFFFFFF     0  1217      1 12588    1242  1203 (NOTLB)
Call Trace:    [<c0113dd7>] [<c021b4fe>] [<c021b63d>] [<c0265859>] [<c0216ef5>]
  [<c0113079>] [<c0112ed8>] [<c0130fd7>] [<c0130ffc>] [<c0119dab>] [<c021799b>]
  [<c0106fa3>]
mimedefang-mu S F5957F28     0  1242      1 11798    1254  1217 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S F59C3F28  1376  1254      1  1255    1271  1242 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S F594FF28     0  1255   1254 12586               (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c0146810>] [<c0146a2d>] [<c0106fa3>]
mimedefang    S F5937FAC  2404  1256   1255         31093       (NOTLB)
Call Trace:    [<c01060e7>] [<c0106fa3>]
getty         S 7FFFFFFF  2400  1271      1          1272  1254 (NOTLB)
Call Trace:    [<c0113dd7>] [<c01a23d3>] [<c019de88>] [<c0136b2d>] [<c0106fa3>]
getty         S 7FFFFFFF  5192  1272      1          1449  1271 (NOTLB)
Call Trace:    [<c0113dd7>] [<c01a23d3>] [<c019de88>] [<c0136b2d>] [<c0106fa3>]
getty         S 7FFFFFFF     0  1449      1         25081  1272 (NOTLB)
Call Trace:    [<c0113dd7>] [<c01a23d3>] [<c019de88>] [<c0136b2d>] [<c0106fa3>]
sophie        S F519FF28     0 13104   1217         32256       (NOTLB)
Call Trace:    [<c01402c7>] [<c0113e3a>] [<c0113d60>] [<c0146810>] [<c0146a2d>]
  [<c0106fa3>]
apache        S 00000001    64 24812   1203         14925  1211 (NOTLB)
Call Trace:    [<c019aa85>] [<c019abf5>] [<c0226083>] [<c0219961>] [<c02414fc>]
  [<c02415a4>] [<c0237d3f>] [<c024210f>] [<c0242dca>] [<c0238e25>] [<c0106b1e>]
  [<c0106df8>] [<c02197d6>] [<c0219961>] [<c0121626>] [<c010c385>] [<c0106fa3>]
apache        S 7FFFFFFF     0 14925   1203         31079 24812 (NOTLB)
Call Trace:    [<c0113dd7>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
apache        S 00000001    80 31079   1203          2797 14925 (NOTLB)
Call Trace:    [<c019aa85>] [<c019abf5>] [<c0226083>] [<c02414fc>] [<c02415a4>]
  [<c0237d3f>] [<c024210f>] [<c02197d6>] [<c0219961>] [<c021d92b>] [<c011bc8d>]
  [<c01089de>] [<c0121626>] [<c010c385>] [<c0106fa3>]
apache        S 00000001     0  2797   1203          2808 31079 (NOTLB)
Call Trace:    [<c019aa85>] [<c019abf5>] [<c0226083>] [<c02414fc>] [<c02415a4>]
  [<c0237d3f>] [<c024210f>] [<c0242dca>] [<c0238e25>] [<c0106b1e>] [<c0106df8>]
  [<c014b02f>] [<c0149adb>] [<c0121626>] [<c010c385>] [<c0106fa3>]
apache        S 00000001     0  2808   1203          2809  2797 (NOTLB)
Call Trace:    [<c019aa85>] [<c019abf5>] [<f8d0c83d>] [<c0226083>] [<c0230c55>]
  [<c02197bf>] [<c02197d6>] [<c02386ed>] [<c024851f>] [<c0218713>] [<c0239371>]
  [<c014b02f>] [<c0149adb>] [<c0121626>] [<c010c385>] [<c0106fa3>]
apache        S 00000001     0  2809   1203         32472  2808 (NOTLB)
Call Trace:    [<c019aa85>] [<c019abf5>] [<f8d0c83d>] [<c0226083>] [<c02197d6>]
  [<c02197bf>] [<c02197d6>] [<c02386ed>] [<c024851f>] [<c0218713>] [<c0239371>]
  [<c0219961>] [<c014b02f>] [<c0149adb>] [<c0121626>] [<c010c385>] [<c0106fa3>]
apache        S 00000001     0 32472   1203         20178  2809 (NOTLB)
Call Trace:    [<c019aa85>] [<c019abf5>] [<f8d0c83d>] [<c0226083>] [<c0230c55>]
  [<c02197bf>] [<c02197d6>] [<c02386ed>] [<c024851f>] [<c0218713>] [<c0239371>]
  [<c014b02f>] [<c0149adb>] [<c0121626>] [<c010c385>] [<c0106fa3>]
apache        S 00000001     0 20178   1203               32472 (NOTLB)
Call Trace:    [<c019aa85>] [<c019abf5>] [<f8d0c83d>] [<c0211000>] [<c011bc8d>]
  [<c02197bf>] [<c02197d6>] [<c02386ed>] [<c024851f>] [<c0218713>] [<c0239371>]
  [<c014b02f>] [<c0149adb>] [<c0121626>] [<c010c385>] [<c0106fa3>]
sophie        S DA321FAC     0 32256   1217         12585 13104 (NOTLB)
Call Trace:    [<c01060e7>] [<c0106fa3>]
hostmon-clien S D0911F88     0 25081      1         25084  1449 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c011f858>] [<c0106fa3>]
hostmon-clien S 7FFFFFFF    12 25084      1               25081 (NOTLB)
Call Trace:    [<c0113dd7>] [<c0239821>] [<c02399aa>] [<c025379a>] [<c0216ef5>]
  [<c02197d6>] [<c0219961>] [<c021d92b>] [<c021799b>] [<c0106fa3>]
mimedefang    S F5137F28    64 31093   1255          7135  1256 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C91F5F28   240  7135   1255         19912 31093 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S EC8B7F28    80 19912   1255         26093  7135 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C8F5FF28    80 26093   1255         30538 19912 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C532BF28     8 30538   1255         31800 26093 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S EA6F3F28    64 31800   1255         32053 30538 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S ECBE9F28     0 32053   1255         32392 31800 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    R F0827F28     0 32392   1255           625 32053 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S E9A2FF28     0   625   1255           666 32392 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C7A17F28    64   666   1255          1599   625 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang.pl R current     80  1050   1242          4500       (L-TLB)
Call Trace:    [<c0139157>] [<c0139487>] [<c0139d6d>] [<c0178408>] [<c0178689>]
  [<c0178408>] [<c012ae3a>] [<c012b2e6>] [<c0136c3d>] [<c0106fa3>]
mimedefang    S C9DE3F28     0  1599   1255          2117   666 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S DCAFDF28     0  2117   1255          2696  1599 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S F3B25F28   100  2696   1255          3488  2117 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S DED59F28     0  3488   1255          3889  2696 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S DFC57F28     0  3889   1255          4249  3488 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C8A2FF28    80  4249   1255          4539  3889 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang.pl D F70B5004  1376  4500   1242          4509  1050 (NOTLB)
Call Trace:    [<c0105c34>] [<c0105ddf>] [<c018915a>] [<c0187026>] [<c01864fa>]
  [<c0185d50>] [<c018fff4>] [<c014b1a3>] [<c018fb92>] [<c018fdf5>] [<c01785d4>]
  [<c0139157>] [<c0139487>] [<c0139d6d>] [<c0178408>] [<c0178689>] [<c0178408>]
  [<c012ae3a>] [<c012b2e6>] [<c0136c3d>] [<c0106fa3>]
mimedefang.pl D EB53E1A0    80  4509   1242          5165  4500 (NOTLB)
Call Trace:    [<c017892a>] [<c012f444>] [<c0140ba7>] [<c0140ba7>] [<c0141e2a>]
  [<c0141fab>] [<c0136112>] [<c013646e>] [<c0106fa3>]
mimedefang    S ED771F28    64  4539   1255          6486  4249 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang.pl S D1F84000    80  5165   1242          5166  4509 (NOTLB)
Call Trace:    [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
mimedefang.pl S C756C000    80  5166   1242          8662  5165 (NOTLB)
Call Trace:    [<c016fed0>] [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
mimedefang    S D28A1F28    12  6486   1255          6545  4539 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S D9333F28    64  6545   1255          7365  6486 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S D42F5F28    80  7365   1255          9618  6545 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang.pl S DA9E8000    32  8662   1242          8664  5166 (NOTLB)
Call Trace:    [<c016fed0>] [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
mimedefang.pl S D6F56000    80  8664   1242          9833  8662 (NOTLB)
Call Trace:    [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
mimedefang    S CFEEFF28     0  9618   1255          9756  7365 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S EC4D7F28     0  9756   1255         10217  9618 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang.pl S DD100000    68  9833   1242         10483  8664 (NOTLB)
Call Trace:    [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
mimedefang    S D94D9F28    80 10217   1255         10407  9756 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S DC953F28    80 10407   1255         11000 10217 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang.pl S C5CB4000     0 10483   1242         11798  9833 (NOTLB)
Call Trace:    [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
mimedefang    S D05B5F28   192 11000   1255         11054 10407 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C5A09F28    80 11054   1255         11203 11000 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S F4741F28   192 11203   1255         11279 11054 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S D2325F28     0 11279   1255         11369 11203 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S DE443F28     4 11369   1255         11465 11279 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S F0AD3F28    80 11465   1255         11638 11369 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S D25EDF28    16 11638   1255         11882 11465 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang.pl S CF7AC000    12 11798   1242               10483 (NOTLB)
Call Trace:    [<c016fed0>] [<c013fd9a>] [<c013fe87>] [<c0136b2d>] [<c0106fa3>]
mimedefang    S DA015F28  2408 11882   1255         11963 11638 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S CC1A7F28    80 11963   1255         12242 11882 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S D4AD9F28     0 12242   1255         12251 11963 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S EFEC9F28    80 12251   1255         12265 12242 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C7FDFF28     0 12265   1255         12342 12251 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C73BFF28     0 12342   1255         12392 12265 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    R D0BCBF28    80 12392   1255         12489 12342 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S DEE85F28    12 12489   1255         12512 12392 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S CA2A5F28    80 12512   1255         12525 12489 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S CE2A3F28    80 12525   1255         12544 12512 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S D13F9F28    36 12544   1255         12545 12525 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S E06F1F28    64 12545   1255         12549 12544 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S CB56FF28    68 12549   1255         12552 12545 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S F1F1DF28    80 12552   1255         12555 12549 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S F37BDF28     0 12555   1255         12559 12552 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S F53F3F28   176 12559   1255         12561 12555 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S CB413F28    12 12561   1255         12565 12559 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S 7FFFFFFF    12 12565   1255         12569 12561 (NOTLB)
Call Trace:    [<c0113dd7>] [<c02663c6>] [<c02665a1>] [<c0216393>] [<c021648f>]
  [<c0136b2d>] [<c0106fa3>]
mimedefang    S F0D27F28    36 12569   1255         12570 12565 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S 7FFFFFFF    80 12570   1255         12571 12569 (NOTLB)
Call Trace:    [<c0113dd7>] [<c02663c6>] [<c02665a1>] [<c0216393>] [<c021648f>]
  [<c0136b2d>] [<c0106fa3>]
mimedefang    S 7FFFFFFF    80 12571   1255         12573 12570 (NOTLB)
Call Trace:    [<c0113dd7>] [<c02663c6>] [<c02665a1>] [<c0216393>] [<c021648f>]
  [<c0136b2d>] [<c0106fa3>]
mimedefang    S F57B1F28     0 12573   1255         12576 12571 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    R DD135F28   192 12576   1255         12577 12573 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S CC3D3F28     4 12577   1255         12578 12576 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S EED11F28     0 12578   1255         12579 12577 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S DEFEDF28    80 12579   1255         12582 12578 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S C5ECDF28    32 12582   1255         12583 12579 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S D98DBF28    64 12583   1255         12584 12582 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
mimedefang    S EB323F28   208 12584   1255         12586 12583 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
sophie        R 7FFFFFFF    80 12585   1217         12588 32256 (NOTLB)
Call Trace:    [<c0113dd7>] [<c02663c6>] [<c02665a1>] [<c0216393>] [<c021648f>]
  [<c0136b2d>] [<c0106fa3>]
mimedefang    S D931FF28    48 12586   1255               12584 (NOTLB)
Call Trace:    [<c0113e3a>] [<c0113d60>] [<c014621c>] [<c01465a8>] [<c0106fa3>]
sophie        R 7FFFFFFF    80 12588   1217               12585 (NOTLB)
Call Trace:    [<c0113dd7>] [<c02663c6>] [<c02665a1>] [<c0216393>] [<c021648f>]
  [<c0136b2d>] [<c0106fa3>]

telnet> send brk
SysRq : Show Regs

Pid: 1050, comm:        mimedefang.pl
EIP: 0010:[<c011ad7d>] CPU: 0 EFLAGS: 00000286    Not tainted
EAX: d478c000 EBX: d1521400 ECX: 00000000 EDX: ffffffff
ESI: d478dc8c EDI: d478c000 EBP: d478dbb8 DS: 0018 ES: 0018
CR0: 80050033 CR2: 00000000 CR3: 00101000 CR4: 00000690
Call Trace:    [<c010759e>] [<c0113273>] [<c0112ed8>] [<c01d7899>] [<c01d7706>]
  [<c011c046>] [<c011bf13>] [<c0107094>] [<c0114444>] [<c0105bc8>] [<c0105e10>]
  [<c0188ffe>] [<c01903c4>] [<c0185eb6>] [<c018fff4>] [<c0125b72>] [<c018fb92>]
  [<c01785d4>] [<c0139157>] [<c0139487>] [<c0139d6d>] [<c0178408>] [<c0178689>]
  [<c0178408>] [<c012ae3a>] [<c012b2e6>] [<c0136c3d>] [<c0106fa3>]

telnet> send brk
SysRq : Show Memory
Mem-info:
Free pages:      115744kB (103512kB HighMem)
Zone:DMA freepages:  4116kB
Zone:Normal freepages:  8116kB
Zone:HighMem freepages:103512kB
( Active: 111342, inactive: 767950, free: 28936 )
81*4kB 18*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB = 4116kB)
1323*4kB 221*8kB 6*16kB 0*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 8116kB)
6188*4kB 9179*8kB 219*16kB 7*32kB 5*64kB 2*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB = 103512kB)
Swap cache: add 67, delete 42, find 289983/289993, race 0+0
Free swap:       9381660kB
1032192 pages of RAM
802816 pages of HIGHMEM
12830 reserved pages
820298 pages shared
25 pages swap cached
35 pages in page table cache
Buffer memory:    80004kB
Cache memory:   3173004kB
    CLEAN: 739606 buffers, 2774986 kbyte, 46 used (last=719934), 0 locked, 0 dirty
   LOCKED: 2409 buffers, 4098 kbyte, 1 used (last=1676), 0 locked, 0 dirty
    DIRTY: 504 buffers, 801 kbyte, 28 used (last=308), 0 locked, 504 dirty

telnet> send brk
SysRq : Resetting

