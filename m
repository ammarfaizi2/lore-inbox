Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275032AbRIYPEq>; Tue, 25 Sep 2001 11:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275027AbRIYPEe>; Tue, 25 Sep 2001 11:04:34 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:30246 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275031AbRIYPEM>; Tue, 25 Sep 2001 11:04:12 -0400
Message-ID: <3BB09D04.57C1A4B4@redhat.com>
Date: Tue, 25 Sep 2001 11:04:36 -0400
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Preliminary testing results for 2.4.10
In-Reply-To: <Pine.LNX.4.33.0109241605080.13605-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 24 Sep 2001, Bob Matthews wrote:
> >
> > machine test1:  2xPIII, 2G RAM/4G Swap.  Appears to be in a memory
> > related deadlock.  All test related processes save one are in D state.
> > Vmstat indicates no swapping activity.  Top says both processors are
> > ~95% idle.  The exception is the TTCP test, which has a very small
> > memory footprint and is running normally.
> 
> Can you check what "ctrl + ScrollLock" says?

Appended, along with System.map. Many seem to be stuck in
"__wait_on_buffer".

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C02E4C68  4316     1      0  3623       3       (NOTLB)
Call Trace: [<c011183e>] [<c0111760>] [<c01449df>] [<c0144d89>]
[<c0106f6b>] 
keventd       S 00000246  5072     2      1            11       (L-TLB)
Call Trace: [<c01994da>] [<c011f371>] [<c011f250>] [<c0105000>]
[<c0105656>] 
   [<c011f250>] 
ksoftirqd_CPU S C011768C  5952     3      0             4     1 (L-TLB)
Call Trace: [<c011768c>] [<c0117a12>] [<c0105656>] [<c0117960>] 
ksoftirqd_CPU S C011768C  5952     4      0             5     3 (L-TLB)
Call Trace: [<c011768c>] [<c0117a12>] [<c0105656>] [<c0117960>] 
kswapd        D 00000011  5344     5      0             6     4 (L-TLB)
Call Trace: [<c0134ad6>] [<c013845b>] [<c0138633>] [<c012bec5>]
[<c012c330>] 
   [<c012c37d>] [<c012c431>] [<c012c4a6>] [<c012c5e1>] [<c012c540>]
[<c0105000>] 
   [<c0105656>] [<c012c540>] 
bdflush       D 00000010  5388     6      0             7     5 (L-TLB)
Call Trace: [<c0134ad6>] [<c0134d74>] [<c01389d9>] [<c0105000>]
[<c0105656>] 
   [<c0138910>] 
kupdated      D 00000015  5064     7      0                   6 (L-TLB)
Call Trace: [<c013623c>] [<c0134ad6>] [<c0136394>] [<c0134d74>]
[<c015aed4>] 
   [<c0138a98>] [<c0105000>] [<c0105656>] [<c01389f0>] 
scsi_eh_0     S 00000000  6096    11      1            12     2 (L-TLB)
Call Trace: [<c0105cb4>] [<c0105d8f>] [<c028ea74>] [<c0106f1e>]
[<c0105656>] 
   [<c01e33f0>] 
scsi_eh_1     S 00000012  6092    12      1            13    11 (L-TLB)
Call Trace: [<c0105cb4>] [<c0105d8f>] [<c028ea74>] [<c0106f1e>]
[<c0105656>] 
   [<c01e33f0>] 
khubd         S 00000000  6248    13      1           367    12 (L-TLB)
Call Trace: [<c01089dd>] [<c011230a>] [<c02333cf>] [<c0105000>]
[<c0105656>] 
   [<c0233380>] 
dhcpcd        S F7605F54  2416   367      1           434    13 (NOTLB)
Call Trace: [<c011183e>] [<c0111760>] [<c011b132>] [<c011b2eb>]
[<c0106f6b>] 
syslogd       R F762BF54  2416   434      1           439   367 (NOTLB)
Call Trace: [<c01117d7>] [<c023bc4f>] [<c01449df>] [<c0144d89>]
[<c015908c>] 
   [<c01350c3>] [<c0106f6b>] 
klogd         R 00000000  2416   439      1           457   434 (NOTLB)
Call Trace: [<c023b9f7>] [<c0133c36>] [<c010f3fc>] [<c0106f6b>] 
portmap       S 00000015  2416   457      1           485   439 (NOTLB)
Call Trace: [<c01117d7>] [<c0144f29>] [<c0144fd6>] [<c014500e>]
[<c0145282>] 
   [<c023cf5c>] [<c0106f6b>] 
rpc.statd     S 00000246  2416   485      1           595   457 (NOTLB)
Call Trace: [<c01117d7>] [<c026fcc3>] [<c023bc4f>] [<c01449df>]
[<c0144d89>] 
   [<c0106f6b>] 
ntpd          S F7575F54     0   595      1           613   485 (NOTLB)
Call Trace: [<c012d390>] [<c01117d7>] [<c0106e33>] [<c023bc4f>]
[<c01449df>] 
   [<c0144d89>] [<c0106f6b>] 
sshd          S 00000246  2416   613      1           646   595 (NOTLB)
Call Trace: [<c01117d7>] [<c023bc4f>] [<c01449df>] [<c0144d89>]
[<c0106f6b>] 
gpm           S 00000010  5324   646      1           654   613 (NOTLB)
Call Trace: [<c011183e>] [<c0111760>] [<c023bc4f>] [<c01449df>]
[<c0144d89>] 
   [<c0106f6b>] 
login         S 00000246  2416   654      1   663     655   646 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
login         S 00000010  4500   655      1  1045     656   654 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
login         S 00000015     0   656      1  1098     657   655 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
login         S 00000012     0   657      1  1150     659   656 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
mingetty      S C1E00000     0   659      1           660   657 (NOTLB)
Call Trace: [<c01117d7>] [<c018d58a>] [<c0189687>] [<c0123282>]
[<c0133c36>] 
   [<c01232c3>] [<c0106f6b>] 
mgetty        S 00000003  2416   660      1           734   659 (L-TLB)
Call Trace: [<c01385cb>] [<c01117d7>] [<c012595e>] [<c012599a>]
[<c012d80a>] 
   [<c018dcdb>] [<c019ced9>] [<c018a0b7>] [<c012d8f5>] [<c011fe65>]
[<c012d8f5>] 
   [<c01205e0>] [<c018a72a>] [<c013485e>] [<c013374e>] [<c011597d>]
[<c01161c0>] 
   [<c0133d32>] [<c01232c3>] [<c0106f6b>] 
bash          S C018ADA6     0   663    654   761               (NOTLB)
Call Trace: [<c018ada6>] [<c0116708>] [<c0106f6b>] 
rpc.rquotad   S C0241317  2420   734      1           739   660 (NOTLB)
Call Trace: [<c0241317>] [<c01117d7>] [<c0144f29>] [<c0144fd6>]
[<c014500e>] 
   [<c0145282>] [<c0106f6b>] 
rpc.mountd    S 00000015     0   739      1           752   734 (NOTLB)
Call Trace: [<c01117d7>] [<c0144f29>] [<c0144fd6>] [<c014500e>]
[<c0145282>] 
   [<c023cf5c>] [<c0106f6b>] 
nfsd          S F7249440  4896   744      1          3623   745 (L-TLB)
Call Trace: [<c023ea6c>] [<c01117d7>] [<c01174ab>] [<c0283958>]
[<c016d8d4>] 
   [<c0105656>] [<c016d7d0>] 
nfsd          S 00000014  4876   745      1           744   746 (L-TLB)
Call Trace: [<c01117d7>] [<c016dc7f>] [<c0283958>] [<c016d8d4>]
[<c0105656>] 
   [<c016d7d0>] 
nfsd          S 00000014  4620   746      1           745   747 (L-TLB)
Call Trace: [<c01117d7>] [<c016dc7f>] [<c0283958>] [<c016d8d4>]
[<c0105656>] 
   [<c016d7d0>] 
nfsd          S 00000001  4860   747      1           746   748 (L-TLB)
Call Trace: [<c01117d7>] [<c0283da0>] [<c016dc7f>] [<c0283958>]
[<c016d8d4>] 
   [<c0105656>] [<c016d7d0>] 
nfsd          S 00000001  4924   748      1           747   749 (L-TLB)
Call Trace: [<c01117d7>] [<c0283da0>] [<c0283958>] [<c016d8d4>]
[<c0105656>] 
   [<c016d7d0>] 
nfsd          S 00000001  4864   749      1           748   750 (L-TLB)
Call Trace: [<c01117d7>] [<c0283da0>] [<c016dc7f>] [<c0283958>]
[<c016d8d4>] 
   [<c0105656>] [<c016d7d0>] 
nfsd          S 00000014  4752   750      1           749   751 (L-TLB)
Call Trace: [<c01117d7>] [<c0283da0>] [<c016dc7f>] [<c0283958>]
[<c016d8d4>] 
   [<c0105656>] [<c016d7d0>] 
nfsd          S 00000014  4696   751      1           750   752 (L-TLB)
Call Trace: [<c01117d7>] [<c016dc7f>] [<c0283958>] [<c016d8d4>]
[<c0105656>] 
   [<c016d7d0>] 
lockd         S 00000016  6124   752      1   753     751   739 (L-TLB)
Call Trace: [<c01117d7>] [<c0107019>] [<c0283958>] [<c017bbc0>]
[<c0105656>] 
   [<c017ba50>] 
rpciod        S 00000014  5140   753    752                     (L-TLB)
Call Trace: [<c028087d>] [<c0105656>] [<c02806e0>] 
run           S C01898B2  2416   761    663   843               (NOTLB)
Call Trace: [<c01898b2>] [<c011183e>] [<c0111760>] [<c0133d32>]
[<c011b2eb>] 
   [<c0106f6b>] 
runtest       S 00000015  4820   770    761   816     776       (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
runtest       S 00000010  4820   776    761 23437     779   770 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
runtest       S 00000012  4820   779    761 30070     782   776 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
runtest       S 00000012  2416   782    761   824     785   779 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
runtest       S 00000014  4820   785    761 29967     832   782 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
nfstest.sh    S 00000013  2416   816    770 13707               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
fs-test-drive S 00000014  4820   824    782 25360               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
runtest       S 00000019  2416   832    761   852     843   785 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
runtest       S 00000013  4820   843    761   851           832 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
memtst        D 00000015  2416   851    843                     (NOTLB)
Call Trace: [<c0134ad6>] [<c013845b>] [<c0138633>] [<c01e950c>]
[<c012bec5>] 
   [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c012d9a5>]
[<c01219d4>] 
   [<c0121a39>] [<c011ae16>] [<c0121ffa>] [<c01089dd>] [<c0110c10>]
[<c0110daa>] 
   [<c020a7fa>] [<c01ded7b>] [<c01debb6>] [<c011ad10>] [<c010f3fc>]
[<c0110c10>] 
   [<c010705c>] 
memtst        D 00000015  4776   852    832                     (NOTLB)
Call Trace: [<c0134ad6>] [<c01e4874>] [<c013845b>] [<c01a23ca>]
[<c0138633>] 
   [<c012bec5>] [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>]
[<c012d9a5>] 
   [<c0121a3f>] [<c0121ffa>] [<c0110daa>] [<c018fb43>] [<c011794d>]
[<c011abc6>] 
   [<c011ae16>] [<c011ad10>] [<c010f3fc>] [<c0110c10>] [<c010705c>] 
bash          S 00000013     0  1045    655  1093               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
top           S F6CFDF54     0  1093   1045                     (NOTLB)
Call Trace: [<c018db54>] [<c011183e>] [<c0111760>] [<c01449df>]
[<c0144d89>] 
   [<c0133a6e>] [<c0106f6b>] 
bash          S 00000015     0  1098    656  1144               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
vmstat        S C01898B2     0  1144   1098                     (NOTLB)
Call Trace: [<c01898b2>] [<c011183e>] [<c0111760>] [<c0133d32>]
[<c011b2eb>] 
   [<c0106f6b>] 
bash          S 0000000C  4732  1150    657                     (NOTLB)
Call Trace: [<c018dad1>] [<c01898b2>] [<c018d920>] [<c011cd83>]
[<c0133d06>] 
   [<c0106f6b>] 
make          S 00000012     0 13707    816 29257               (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c0106f6b>] 
make          S 00000011     0 15674  13707 29884   29257       (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c0106f6b>] 
dt_driver.sh  S 00000011  4820 23437    776 30068               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
sync          D 00000015     0 25360    824                     (NOTLB)
Call Trace: [<c0134ad6>] [<c011772c>] [<c013845b>] [<c0138633>]
[<c012bec5>] 
   [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c0131eb0>]
[<c013202c>] 
   [<c01a1cb8>] [<c012595e>] [<c0125880>] [<c0121e96>] [<c01a23ca>]
[<c01a242f>] 
   [<c0134b84>] [<c0134c37>] [<c0134cd3>] [<c0111cf7>] [<c0134df4>]
[<c0134f00>] 
   [<c0134f87>] [<c0106f6b>] 
make          S 00000010     0 28468  15674 29267   29884       (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
make          S 00000012     0 29257  13707 29868         15674 (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c0106f6b>] 
make          S 00000011   436 29267  28468 29956               (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c0106f6b>] 
make          S 00000012     0 29868  29257 29891               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
make          S 00000011     0 29884  15674 29892         28468 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
make          S 00000010     0 29891  29868 29962               (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c0106f6b>] 
make          S 00000013     0 29892  29884 29938               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
gcc           S 00000015     0 29938  29892 29941               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
cpp0          S 00000014     0 29939  29938         29940       (NOTLB)
Call Trace: [<c01481d2>] [<c013ec5c>] [<c013ef89>] [<c0133d06>]
[<c01232c3>] 
   [<c0106f6b>] 
cc1           D 00000015     0 29940  29938         29941 29939 (NOTLB)
Call Trace: [<c0134ad6>] [<c011772c>] [<c013845b>] [<c0138633>]
[<c012bec5>] 
   [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c0121ca9>]
[<c0121e70>] 
   [<c0121fdf>] [<c01e4695>] [<c0110daa>] [<c0122949>] [<c013ee81>]
[<c010bda7>] 
   [<c0110c10>] [<c010705c>] 
as            S 00000010     0 29941  29938               29940 (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c0106f6b>] 
gcc           S 00000011     0 29956  29267 29959               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
cpp0          S 00000010     0 29957  29956         29958       (NOTLB)
Call Trace: [<c013ec5c>] [<c013ef89>] [<c0133d06>] [<c0106f6b>] 
cc1           D 00000015     0 29958  29956         29959 29957 (NOTLB)
Call Trace: [<c0124672>] [<c0134ad6>] [<c011772c>] [<c013845b>]
[<c0138633>] 
   [<c012ade9>] [<c012bec5>] [<c012c330>] [<c012c37d>] [<c012cf0f>]
[<c012d28c>] 
   [<c0121ca9>] [<c0121e70>] [<c0121fdf>] [<c01e4695>] [<c0110daa>]
[<c0122949>] 
   [<c011794d>] [<c011abc6>] [<c011ae16>] [<c010594d>] [<c010bda7>]
[<c0110c10>] 
   [<c010705c>] 
as            S 00000015     0 29959  29956               29958 (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c0106f6b>] 
gcc           S 00000010     0 29962  29891 29965               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
cpp0          S 00000015     0 29963  29962         29964       (NOTLB)
Call Trace: [<c013ec5c>] [<c013ef89>] [<c0133d06>] [<c0106f6b>] 
cc1           D 00000015     0 29964  29962         29965 29963 (NOTLB)
Call Trace: [<c0134ad6>] [<c013845b>] [<c0138633>] [<c012ade9>]
[<c012bec5>] 
   [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c012599a>]
[<c0121ca9>] 
   [<c0121e70>] [<c0121fdf>] [<c01e4695>] [<c0110daa>] [<c0122949>]
[<c011abc6>] 
   [<c011ae16>] [<c010bda7>] [<c0110c10>] [<c010705c>] 
as            S 00000013     0 29965  29962               29964 (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c0106f6b>] 
crashme_drive S E9915C04  4672 29967    785 30001               (NOTLB)
Call Trace: [<c013ec5c>] [<c013ed44>] [<c0133c36>] [<c01063a1>]
[<c0106f6b>] 
crashme       S C0116871  2416 29996  29967 30009   30001       (NOTLB)
Call Trace: [<c0116871>] [<c0116708>] [<c0106f6b>] 
crashme_drive D 00000012  2416 30001  29967 30003         29996 (NOTLB)
Call Trace: [<c0134ad6>] [<c013845b>] [<c0138633>] [<c012ade9>]
[<c012bec5>] 
   [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c0121381>]
[<c0125880>] 
   [<c0122020>] [<c012d390>] [<c0122129>] [<c0110daa>] [<c012012f>]
[<c0123564>] 
   [<c011375e>] [<c01141e2>] [<c013374e>] [<c0110c10>] [<c010705c>] 
crashme_drive D 00000010     0 30002  30001         30003       (NOTLB)
Call Trace: [<c0134ad6>] [<c013845b>] [<c0138633>] [<c012bec5>]
[<c012c330>] 
   [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c0121381>] [<c0122020>]
[<c0110daa>] 
   [<c011cd83>] [<c0110c10>] [<c010705c>] 
crashme_drive D 00000015     0 30003  30001               30002 (NOTLB)
Call Trace: [<c0134ad6>] [<c013845b>] [<c0138633>] [<c012ade9>]
[<c012bec5>] 
   [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c0121381>]
[<c0122020>] 
   [<c0110daa>] [<c011cd83>] [<c013374e>] [<c0110c10>] [<c010705c>] 
crashme       D 00000015     0 30009  29996                     (NOTLB)
Call Trace: [<c0134ad6>] [<c013845b>] [<c0138633>] [<c012ade9>]
[<c012bec5>] 
   [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c012599a>]
[<c0121ca9>] 
   [<c0121e70>] [<c0121fdf>] [<c01065ca>] [<c0106724>] [<c0110daa>]
[<c0106e33>] 
   [<c011baad>] [<c0116871>] [<c01169e2>] [<c011b132>] [<c0110c10>]
[<c010705c>] 
dt            D 00000015     0 30068  23437                     (NOTLB)
Call Trace: [<c0134ad6>] [<c013845b>] [<c0138633>] [<c012bec5>]
[<c012c330>] 
   [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c0124556>] [<c01245d9>]
[<c0125bf2>] 
   [<c018fb43>] [<c011abc6>] [<c0125880>] [<c0121e96>] [<c0121fdf>]
[<c01e4695>] 
   [<c0110daa>] [<c020a7fa>] [<c01ded7b>] [<c011abc6>] [<c011ae16>]
[<c011ad10>] 
   [<c010f3fc>] [<c0110c10>] [<c010705c>] 
P3-stress.sh  S 00000013  2416 30070    779 30075               (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
makedatafiles D C5C0DDC4     0 30075  30070                     (NOTLB)
Call Trace: [<c0134ad6>] [<c015800f>] [<c013845b>] [<c0138633>]
[<c012bec5>] 
   [<c012c330>] [<c012c37d>] [<c012cf0f>] [<c012d28c>] [<c0127446>]
[<c0133d06>] 
   [<c010f3fc>] [<c01089dd>] [<c0106f6b>] 
login         S 00000246     0  3623      1  3624           744 (NOTLB)
Call Trace: [<c0116708>] [<c0106f6b>] 
bash          S 20316672  5016  3624   3623                     (NOTLB)
Call Trace: [<c01117d7>] [<c0195389>] [<c018d58a>] [<c0189687>]
[<c011cd83>] 
   [<c0133c36>] [<c0106f6b>] 


 ---- System.map-2.4.10

00000000 A agp_frontend_cleanup
00000060 A usb_stor_exit
c0100000 A _text
c0100000 t startup_32
c01000cb t checkCPUtype
c010015f t is486
c010016e t is386
c01001cf t L6
c01001d1 t ready
c01001d2 t check_x87
c01001fa t setup_idt
c0100217 t rp_sidt
c0100224 T stack_start
c010022c t int_msg
c0100240 t ignore_int
c0100262 t idt_descr
c0100264 T idt
c010026a t gdt_descr
c010026c T gdt
c0101000 T swapper_pg_dir
c0102000 T pg0
c0103000 T pg1
c0104000 T empty_zero_page
c0105000 t rest_init
c0105000 T stext
c0105000 T _stext
c0105060 t prepare_namespace
c0105070 t init
c0105200 T disable_hlt
c0105210 T enable_hlt
c0105220 t default_idle
c0105260 t poll_idle
c0105280 T cpu_idle
c01052f0 T machine_real_restart
c01053b0 T machine_restart
c01054c0 T machine_halt
c01054d0 T machine_power_off
c01054e0 T show_regs
c01055d0 T release_segments
c0105630 T kernel_thread
c0105660 T exit_thread
c0105670 T flush_thread
c01056b0 T release_thread
c01056f0 T copy_segments
c0105760 T copy_thread
c01057f0 T dump_thread
c0105910 T __switch_to
c0105a10 T sys_fork
c0105a30 T sys_clone
c0105a60 T sys_vfork
c0105a80 T sys_execve
c0105ae0 T get_wchan
c0105b50 T __up
c0105b70 T __down
c0105c40 T __down_interruptible
c0105d30 T __down_trylock
c0105d7c T __down_failed
c0105d88 T __down_failed_interruptible
c0105d94 T __down_failed_trylock
c0105da0 T __up_wakeup
c0105dac T __write_lock_failed
c0105dcc T __read_lock_failed
c0105de0 T copy_siginfo_to_user
c0105e90 T sys_sigsuspend
c0105f40 T sys_rt_sigsuspend
c0106070 T sys_sigaction
c0106170 T sys_sigaltstack
c0106190 t restore_sigcontext
c01062d0 T sys_sigreturn
c01063d0 T sys_rt_sigreturn
c01064f0 t setup_sigcontext
c0106610 t setup_frame
c0106820 t setup_rt_frame
c0106ac0 t handle_signal
c0106bd0 T do_signal
c0106e80 T lcall7
c0106ecc T lcall27
c0106f18 T ret_from_fork
c0106f38 T system_call
c0106f70 T ret_from_sys_call
c0106f81 t restore_all
c0106f90 t signal_return
c0106fa8 t v86_signal_return
c0106fb8 t tracesys
c0106fdb t tracesys_exit
c0106fe5 t badsys
c0106ff4 T ret_from_intr
c0106ffb t ret_from_exception
c0107014 t reschedule
c0107020 T divide_error
c0107028 t error_code
c0107064 T coprocessor_error
c0107070 T simd_coprocessor_error
c010707c T device_not_available
c01070ac t device_not_available_emulate
c01070bc T debug
c01070c8 T nmi
c01070f8 T int3
c0107104 T overflow
c0107110 T bounds
c010711c T invalid_op
c0107128 T coprocessor_segment_overrun
c0107134 T double_fault
c0107140 T invalid_TSS
c010714c T segment_not_present
c0107158 T stack_segment
c0107164 T general_protection
c0107170 T alignment_check
c010717c T page_fault
c0107188 T machine_check
c0107194 T spurious_interrupt_bug
c01071a0 T show_trace
c0107240 T show_trace_task
c0107270 T show_stack
c01072f0 T show_registers
c0107430 T die
c01074a0 T do_divide_error
c0107550 T do_int3
c01075d0 T do_overflow
c0107650 T do_bounds
c01076d0 T do_invalid_op
c0107760 T do_device_not_available
c01077e0 T do_double_fault
c0107850 T do_coprocessor_segment_overrun
c01078c0 T do_invalid_TSS
c0107930 T do_segment_not_present
c01079a0 T do_stack_segment
c0107a10 T do_alignment_check
c0107aa0 T do_general_protection
c0107b20 t mem_parity_error
c0107b50 t io_check_error
c0107ba0 t unknown_nmi_error
c0107bd0 T do_nmi
c0107c50 T do_debug
c0107d10 T math_error
c0107e10 T do_coprocessor_error
c0107e30 T simd_math_error
c0107f00 T do_simd_coprocessor_error
c0107f80 T do_spurious_interrupt_bug
c0107f90 T math_state_restore
c0107fd0 T math_emulate
c0108010 T set_intr_gate
c0108040 T set_tss_desc
c0108070 T set_ldt_desc
c01080b0 T no_action
c01080c0 t enable_none
c01080d0 t startup_none
c01080e0 t disable_none
c01080f0 t ack_none
c0108110 T get_irq_list
c0108320 t show
c01084a0 T synchronize_irq
c01084f0 T __global_cli
c0108660 T __global_sti
c01086a0 T __global_save_flags
c01086f0 T __global_restore_flags
c0108740 T handle_IRQ_event
c01087d0 T disable_irq
c0108850 T enable_irq
c0108900 T do_IRQ
c01089f0 T request_irq
c0108a90 T free_irq
c0108b40 T probe_irq_on
c0108d00 T probe_irq_mask
c0108da0 T probe_irq_off
c0108e50 T setup_irq
c0108f10 t parse_hex_value
c0108fa0 t irq_affinity_read_proc
c0108fe0 t irq_affinity_write_proc
c0109060 t prof_cpu_mask_read_proc
c0109090 t prof_cpu_mask_write_proc
c01090c0 t register_irq_proc
c0109170 T init_irq_proc
c01091e0 T disable_irq_nosync
c0109230 T save_v86_state
c0109360 t mark_screen_rdonly
c0109420 T sys_vm86old
c0109540 T sys_vm86
c0109680 t do_sys_vm86
c0109780 t do_int
c01098b0 T handle_vm86_trap
c01099a0 T handle_vm86_fault
c010a140 t irq_handler
c010a1a0 t do_vm86_irq_handling
c010a450 t putreg
c010a500 t getreg
c010a560 T ptrace_disable
c010a590 T sys_ptrace
c010acb0 T syscall_trace
c010ad10 t end_8259A_irq
c010ad30 t startup_8259A_irq
c010ad40 T disable_8259A_irq
c010ad90 T enable_8259A_irq
c010ade0 T i8259A_irq_pending
c010ae20 T make_8259A_irq
c010ae60 T mask_and_ack_8259A
c010af30 t math_error_irq
c010af60 t set_bitmap
c010b000 T sys_ioperm
c010b0f0 T sys_iopl
c010b160 t read_ldt
c010b1b0 t write_ldt
c010b3f0 T sys_modify_ldt
c010b450 t do_cyrix_devid
c010b4e0 T get_cpuinfo
c010b700 T do_gettimeofday
c010b780 T do_settimeofday
c010b840 t set_rtc_mmss
c010b9d0 t timer_interrupt
c010bb10 T get_cmos_time
c010bce0 T sys_pipe
c010bd40 T sys_mmap2
c010bde0 T old_mmap
c010bf10 T old_select
c010bf90 T sys_ipc
c010c200 T sys_uname
c010c280 T sys_olduname
c010c370 T sys_pause
c010c390 T pci_alloc_consistent
c010c400 T pci_free_consistent
c010c430 T init_fpu
c010c470 T save_init_fpu
c010c4b0 T kernel_fpu_begin
c010c4f0 T restore_fpu
c010c510 T get_fpu_cwd
c010c530 T get_fpu_swd
c010c550 T get_fpu_twd
c010c570 T get_fpu_mxcsr
c010c590 T set_fpu_cwd
c010c5c0 T set_fpu_swd
c010c5f0 T set_fpu_twd
c010c650 T set_fpu_mxcsr
c010c680 T save_i387
c010c8c0 T restore_i387
c010ca70 T get_fpregs
c010cbe0 T set_fpregs
c010cd00 T get_fpxregs
c010cd40 T set_fpxregs
c010cd80 T dump_fpu
c010ce20 T dump_extended_fpu
c010ce70 t intel_machine_check
c010cff0 t pentium_machine_check
c010d040 t winchip_machine_check
c010d060 t unexpected_machine_check
c010d080 T do_machine_check
c010d0a0 T pcibios_update_resource
c010d140 T pcibios_align_resource
c010d170 T pcibios_enable_resources
c010d250 T pcibios_set_master
c010d2d0 T pci_mmap_page_range
c010d330 t pci_conf1_read
c010d400 t pci_conf1_write
c010d4c0 t pci_conf1_read_config_byte
c010d510 t pci_conf1_read_config_word
c010d560 t pci_conf1_read_config_dword
c010d5a0 t pci_conf1_write_config_byte
c010d5e0 t pci_conf1_write_config_word
c010d620 t pci_conf1_write_config_dword
c010d660 t pci_conf2_read
c010d760 t pci_conf2_write
c010d850 t pci_conf2_read_config_byte
c010d8a0 t pci_conf2_read_config_word
c010d8f0 t pci_conf2_read_config_dword
c010d940 t pci_conf2_write_config_byte
c010d980 t pci_conf2_write_config_word
c010d9c0 t pci_conf2_write_config_dword
c010da00 t bios32_service
c010da80 t pci_bios_read
c010db60 t pci_bios_write
c010dc30 t pci_bios_read_config_byte
c010dc80 t pci_bios_read_config_word
c010dcd0 t pci_bios_read_config_dword
c010dd10 t pci_bios_write_config_byte
c010dd50 t pci_bios_write_config_word
c010dd90 t pci_bios_write_config_dword
c010ddd0 T pcibios_set_irq_routing
c010de20 T pcibios_assign_all_busses
c010de30 T pcibios_enable_device
c010de50 t eisa_set_level_irq
c010de80 t read_config_nybble
c010ded0 t write_config_nybble
c010df40 t pirq_ali_get
c010df60 t pirq_ali_set
c010dfa0 t pirq_piix_get
c010dfd0 t pirq_piix_set
c010dff0 t pirq_via_get
c010e000 t pirq_via_set
c010e020 t pirq_opti_get
c010e040 t pirq_opti_set
c010e070 t pirq_cyrix_get
c010e090 t pirq_cyrix_set
c010e0b0 t pirq_sis_get
c010e160 t pirq_sis_set
c010e1f0 t pirq_vlsi_get
c010e230 t pirq_vlsi_set
c010e270 t pirq_serverworks_get
c010e290 t pirq_serverworks_set
c010e2b0 t pirq_amd756_get
c010e300 t pirq_amd756_set
c010e350 t pirq_bios_set
c010e380 t pirq_get_info
c010e3f0 t pcibios_test_irq_handler
c010e400 t pcibios_lookup_irq
c010e6a0 T pcibios_penalize_isa_irq
c010e6b0 T pcibios_enable_irq
c010e740 T send_IPI_self
c010e770 T smp_invalidate_interrupt
c010e800 t flush_tlb_others
c010e910 T flush_tlb_current_task
c010e950 T flush_tlb_mm
c010e9d0 T flush_tlb_page
c010ea50 t flush_tlb_all_ipi
c010eaa0 T flush_tlb_all
c010eb00 T smp_send_reschedule
c010eb40 T smp_call_function
c010ec40 t stop_this_cpu
c010ec80 T smp_send_stop
c010ecb0 T smp_reschedule_interrupt
c010ecc0 T smp_call_function_interrupt
c010ed10 t div64
c010eda0 t smp_tune_scheduling
c010ee60 T get_maxlvt
c010ee80 t clear_local_APIC
c010ef20 T disconnect_bsp_APIC
c010ef40 T disable_local_APIC
c010ef60 t apic_pm_suspend
c010f010 t apic_pm_resume
c010f0e0 t apic_pm_callback
c010f110 T apic_pm_register
c010f180 T apic_pm_unregister
c010f1c0 T __setup_APIC_LVTT
c010f1f0 T setup_APIC_timer
c010f2e0 T setup_profiling_timer
c010f310 T smp_apic_timer_interrupt
c010f420 T smp_spurious_interrupt
c010f450 T smp_error_interrupt
c010f490 T smp_local_timer_interrupt
c010f560 t disable_apic_nmi_watchdog
c010f590 t nmi_pm_callback
c010f5b0 t nmi_pm_init
c010f5d0 t setup_k7_watchdog
c010f660 t setup_p6_watchdog
c010f6f0 T setup_apic_nmi_watchdog
c010f730 T touch_nmi_watchdog
c010f760 T nmi_watchdog_tick
c010f840 t add_pin_to_irq
c010f8c0 t __mask_IO_APIC_irq
c010f940 t __unmask_IO_APIC_irq
c010f9b0 t __mask_and_edge_IO_APIC_irq
c010fa30 t __unmask_and_level_IO_APIC_irq
c010fab0 t mask_IO_APIC_irq
c010fae0 t unmask_IO_APIC_irq
c010fb10 T clear_IO_APIC_pin
c010fb80 t clear_IO_APIC
c010fbe0 T IO_APIC_get_PCI_irq_vector
c010fd60 t pin_2_irq
c010fe30 t print_APIC_bitfield
c010feb0 T print_local_APIC
c0110100 T print_all_local_APICs
c0110120 T print_PIC
c01101e0 T disable_IO_APIC
c01101f0 t disable_edge_ioapic_irq
c0110200 t startup_edge_ioapic_irq
c0110250 t ack_edge_ioapic_irq
c0110280 t end_edge_ioapic_irq
c0110290 t startup_level_ioapic_irq
c01102a0 t end_level_ioapic_irq
c0110370 t mask_and_ack_level_ioapic_irq
c0110380 t set_ioapic_affinity
c0110420 t enable_lapic_irq
c0110430 t disable_lapic_irq
c0110440 t ack_lapic_irq
c0110450 t end_lapic_irq
c0110460 t enable_NMI_through_LVT0
c0110480 t setup_nmi
c01104b0 T do_check_pgt_cache
c01106c0 T show_mem
c0110800 T __set_fixmap
c0110910 t do_test_wp_bit
c0110920 T free_initmem
c01109b0 T si_meminfo
c01109f0 T __verify_write
c0110b80 T bust_spinlocks
c0110be0 T do_BUG
c0110c10 T do_page_fault
c0111170 t remap_area_pages
c01113c0 T __ioremap
c01114a0 T iounmap
c01114d0 T search_exception_table
c0111530 T scheduling_functions_start_here
c0111540 t reschedule_idle
c0111760 t process_timeout
c01117c0 T schedule_timeout
c0111860 T schedule_tail
c01118f0 T schedule
c0111f30 T __wake_up
c0111ff0 T __wake_up_sync
c0112110 T complete
c01121f0 T wait_for_completion
c01122c0 T interruptible_sleep_on
c0112340 T interruptible_sleep_on_timeout
c01123d0 T sleep_on
c0112450 T sleep_on_timeout
c01124e0 T scheduling_functions_end_here
c01124f0 T sys_nice
c0112570 t setscheduler
c01127a0 T sys_sched_setscheduler
c01127b0 T sys_sched_setparam
c01127d0 T sys_sched_getscheduler
c0112840 T sys_sched_getparam
c0112910 T sys_sched_yield
c0112980 T sys_sched_get_priority_max
c01129b0 T sys_sched_get_priority_min
c01129e0 T sys_sched_rr_get_interval
c0112ae0 t show_task
c0112c50 T render_sigset_t
c0112ce0 T show_state
c0112d50 T reparent_to_init
c0112ef0 T daemonize
c0112f50 T wake_up_process
c0112fb0 T get_dma_list
c0113000 T request_dma
c0113040 T free_dma
c0113080 T add_wait_queue
c01130b0 T add_wait_queue_exclusive
c01130e0 T remove_wait_queue
c0113120 t get_pid
c0113270 t mm_init
c01133b0 T mm_alloc
c01133f0 T mmput
c0113470 T mm_release
c01134a0 t copy_mm
c0113790 T copy_fs_struct
c01138a0 t count_open_files
c01138d0 t copy_files
c0113b90 T do_fork
c0114290 T __mmdrop
c0114300 t default_handler
c0114370 t lookup_exec_domain
c01143e0 T register_exec_domain
c0114450 T unregister_exec_domain
c01144c0 T __set_personality
c01145a0 T get_exec_domain_list
c0114610 T sys_personality
c0114650 T panic
c0114760 T do_syslog
c0114b40 T sys_syslog
c0114ba0 t __call_console_drivers
c0114c00 t _call_console_drivers
c0114c70 t call_console_drivers
c0114d70 t emit_log_char
c0114de0 T printk
c0114f20 T acquire_console_sem
c0114f70 T release_console_sem
c0115010 T console_conditional_schedule
c0115040 T console_print
c0115060 T register_console
c01151f0 T unregister_console
c0115270 T tty_write_message
c01152b0 T inter_module_register
c01153d0 T inter_module_unregister
c0115490 T inter_module_get
c0115510 T inter_module_get_request
c0115530 T inter_module_put
c01155c0 T sys_create_module
c01155d0 T sys_init_module
c01155e0 T sys_delete_module
c01155f0 T sys_query_module
c0115610 T sys_get_kernel_syms
c0115620 T try_inc_mod_count
c0115630 t release_task
c0115810 T session_of_pgrp
c0115890 t will_become_orphaned_pgrp
c0115920 T is_orphaned_pgrp
c0115930 T put_files_struct
c0115a00 T exit_files
c0115a40 T put_fs_struct
c0115ae0 T exit_fs
c0115ba0 T start_lazy_tlb
c0115be0 T end_lazy_tlb
c0115d20 T exit_mm
c0115da0 t exit_notify
c01160a0 T do_exit
c0116300 T complete_and_exit
c0116320 T sys_exit
c0116340 T sys_wait4
c0116740 T sys_waitpid
c0116760 t tvtojiffies
c01167a0 t jiffiestotv
c01167d0 T do_getitimer
c0116880 T sys_getitimer
c01168f0 T it_real_fn
c0116940 T do_setitimer
c0116a30 T sys_setitimer
c0116b10 T sys_sysinfo
c0116c40 t do_normal_gettime
c0116c60 T get_fast_time
c0116c70 T sys_time
c0116cc0 T sys_stime
c0116d60 T sys_gettimeofday
c0116e00 T do_sys_settimeofday
c0116eb0 T sys_settimeofday
c0116fb0 T do_adjtimex
c0117380 T sys_adjtimex
c0117430 T do_softirq
c0117510 T raise_softirq
c0117560 T open_softirq
c0117580 T __tasklet_schedule
c01175d0 T __tasklet_hi_schedule
c0117620 t tasklet_action
c01176c0 t tasklet_hi_action
c0117760 T tasklet_init
c0117790 T tasklet_kill
c0117820 t bh_action
c01178a0 T init_bh
c01178c0 T remove_bh
c01178f0 T __run_task_queue
c0117960 t ksoftirqd
c0117a70 T cpu_raise_softirq
c0117ac0 t do_resource_list
c0117b40 T get_resource_list
c0117ba0 t __request_resource
c0117c00 t __release_resource
c0117c50 T request_resource
c0117c90 T release_resource
c0117cc0 T check_resource
c0117d30 t find_resource
c0117df0 T allocate_resource
c0117e70 T __request_region
c0117f10 T __check_region
c0117f50 T __release_region
c0117fd0 T do_sysctl
c0118070 T sys_sysctl
c0118140 t test_perm
c0118190 t parse_table
c0118270 T do_sysctl_strategy
c01183b0 T register_sysctl_table
c0118430 T unregister_sysctl_table
c0118470 t register_proc_table
c0118570 t unregister_proc_table
c01185f0 t do_rw_proc
c0118670 t proc_readsys
c0118690 t proc_writesys
c01186b0 t proc_sys_permission
c01186d0 T proc_dostring
c0118830 t proc_doutsstring
c01188c0 t do_proc_dointvec
c0118c00 T proc_dointvec
c0118c30 T proc_dointvec_bset
c0118ca0 T proc_dointvec_minmax
c0118fc0 t do_proc_doulongvec_minmax
c0119310 T proc_doulongvec_minmax
c0119340 T proc_doulongvec_ms_jiffies_minmax
c0119370 T proc_dointvec_jiffies
c01193a0 T sysctl_string
c01194d0 T sysctl_intvec
c0119570 T sysctl_jiffies
c0119660 T sys_acct
c0119670 T sys_capget
c01197d0 t cap_set_pg
c0119840 t cap_set_all
c01198c0 T sys_capset
c0119bf0 T ptrace_attach
c0119e30 T ptrace_detach
c0119f50 t access_one_page
c011a270 t access_mm
c011a2f0 T access_process_vm
c011a380 T ptrace_readdata
c011a430 T ptrace_writedata
c011a4f0 T init_timervecs
c011a580 T add_timer
c011a660 T mod_timer
c011a750 T del_timer
c011a7a0 T sync_timers
c011a7b0 T del_timer_sync
c011a850 T tqueue_bh
c011a870 T immediate_bh
c011a890 t second_overflow
c011aaf0 t update_wall_time_one_tick
c011abb0 t update_wall_time
c011ac00 T update_one_process
c011acf0 T update_process_times
c011ad90 t count_active_tasks
c011ade0 T timer_bh
c011b0a0 T do_timer
c011b100 T sys_alarm
c011b150 T sys_getpid
c011b160 T sys_getppid
c011b190 T sys_getuid
c011b1a0 T sys_geteuid
c011b1b0 T sys_getgid
c011b1c0 T sys_getegid
c011b1d0 T sys_nanosleep
c011b360 T free_uid
c011b3b0 T alloc_uid
c011b4a0 t next_signal
c011b4e0 t flush_sigqueue
c011b530 T flush_signals
c011b550 T exit_sighand
c011b5b0 T flush_signal_handlers
c011b600 T block_all_signals
c011b650 T unblock_all_signals
c011b6b0 t collect_signal
c011b790 T dequeue_signal
c011b840 t rm_from_queue
c011b8b0 t rm_sig_from_queue
c011b8c0 T bad_signal
c011b960 t signal_type
c011b9b0 t ignored_signal
c011b9f0 t handle_stop_signal
c011ba80 t send_signal
c011bb80 t deliver_signal
c011bc10 T send_sig_info
c011bcb0 T force_sig_info
c011bd60 T kill_pg_info
c011bde0 T kill_sl_info
c011be60 t kill_something_info
c011bf80 T send_sig
c011bfa0 T force_sig
c011bfc0 T kill_pg
c011bff0 T kill_sl
c011c020 T kill_proc
c011c090 t wake_up_parent
c011c0d0 T do_notify_parent
c011c180 T notify_parent
c011c1b0 T sys_rt_sigprocmask
c011c3a0 T do_sigpending
c011c430 T sys_rt_sigpending
c011c440 T sys_rt_sigtimedwait
c011c760 T sys_kill
c011c7c0 T sys_rt_sigqueueinfo
c011c8b0 T do_sigaction
c011c9e0 T do_sigaltstack
c011cb40 T sys_sigpending
c011cb50 T sys_sigprocmask
c011ccf0 T sys_rt_sigaction
c011cde0 T sys_sgetmask
c011cdf0 T sys_ssetmask
c011ce50 T sys_signal
c011ce90 T kill_proc_info
c011cef0 T notifier_chain_register
c011cf50 T notifier_chain_unregister
c011cfb0 T notifier_call_chain
c011d000 T register_reboot_notifier
c011d020 T unregister_reboot_notifier
c011d040 T sys_ni_syscall
c011d050 t proc_sel
c011d0f0 T sys_setpriority
c011d200 T sys_getpriority
c011d280 T sys_reboot
c011d500 t deferred_cad
c011d520 T ctrl_alt_del
c011d550 T sys_setregid
c011d630 T sys_setgid
c011d6e0 t set_user
c011d740 T sys_setreuid
c011d900 T sys_setuid
c011da60 T sys_setresuid
c011dc40 T sys_getresuid
c011dcd0 T sys_setresgid
c011ddd0 T sys_getresgid
c011de60 T sys_setfsuid
c011df20 T sys_setfsgid
c011df90 T sys_times
c011dfe0 T sys_setpgid
c011e0f0 T sys_getpgid
c011e160 T sys_getpgrp
c011e170 T sys_getsid
c011e1e0 T sys_setsid
c011e260 T sys_getgroups
c011e2c0 T sys_setgroups
c011e340 t supplemental_group_member
c011e380 T in_group_p
c011e3b0 T in_egroup_p
c011e3e0 T sys_newuname
c011e460 T sys_sethostname
c011e4f0 T sys_gethostname
c011e560 T sys_setdomainname
c011e5f0 T sys_getrlimit
c011e650 T sys_old_getrlimit
c011e6e0 T sys_setrlimit
c011e7d0 T getrusage
c011eab0 T sys_getrusage
c011eae0 T sys_umask
c011eb00 T sys_prctl
c011ebe0 T exec_usermodehelper
c011efe0 t ____call_usermodehelper
c011f030 t __call_usermodehelper
c011f060 T call_usermodehelper
c011f150 T dev_probe_lock
c011f170 T dev_probe_unlock
c011f190 t need_keventd
c011f1b0 T current_is_keventd
c011f1e0 T schedule_task
c011f250 t context_thread
c011f450 T flush_scheduled_tasks
c011f4f0 T start_context_thread
c011f510 T sys_chown16
c011f540 T sys_lchown16
c011f570 T sys_fchown16
c011f5a0 T sys_setregid16
c011f5d0 T sys_setgid16
c011f5e0 T sys_setreuid16
c011f610 T sys_setuid16
c011f620 T sys_setresuid16
c011f670 T sys_getresuid16
c011f760 T sys_setresgid16
c011f7b0 T sys_getresgid16
c011f8a0 T sys_setfsuid16
c011f8b0 T sys_setfsgid16
c011f8c0 T sys_getgroups16
c011f940 T sys_setgroups16
c011f9f0 T sys_getuid16
c011fa20 T sys_geteuid16
c011fa50 T sys_getgid16
c011fa80 T sys_getegid16
c011fab0 T pm_register
c011fb30 T pm_unregister
c011fb90 t __pm_unregister
c011fbd0 T pm_unregister_all
c011fc30 T pm_send
c011fce0 t pm_undo_all
c011fd20 T pm_send_all
c011fdc0 T pm_find
c011fe00 T __free_pte
c011fe70 T check_pgt_cache
c011fe90 T clear_page_tables
c011ffd0 T copy_page_range
c0120250 T zap_page_range
c0120620 t follow_page
c01206e0 T map_user_kiobuf
c01209b0 T mark_dirty_kiobuf
c0120a20 T unmap_kiobuf
c0120ac0 T lock_kiovec
c0120c20 T unlock_kiovec
c0120cf0 T zeromap_page_range
c0120f40 T remap_page_range
c0121190 t do_wp_page
c0121770 t vmtruncate_list
c01217d0 T vmtruncate
c0121980 T swapin_readahead
c01219e0 t do_swap_page
c0121c60 t do_anonymous_page
c0121e40 t do_no_page
c0121f50 T handle_mm_fault
c0122060 T __pmd_alloc
c01220b0 T pte_alloc
c01221e0 T make_pages_present
c0122250 T vm_enough_memory
c01222c0 T lock_vma_mappings
c01222f0 T unlock_vma_mappings
c0122320 T sys_brk
c0122410 t find_vma_prepare
c0122480 t __vma_link
c0122540 t vma_merge
c0122650 T do_mmap_pgoff
c0122b40 T get_unmapped_area
c0122c60 T find_vma
c0122cc0 T find_vma_prev
c0122d80 T find_extend_vma
c0122e40 t unmap_fixup
c0122fa0 t free_pgtables
c0123030 T do_munmap
c0123290 T sys_munmap
c01232e0 T do_brk
c0123520 T build_mmap_rb
c0123580 T exit_mmap
c01236b0 T __insert_vm_struct
c0123720 T insert_vm_struct
c01237c0 t add_page_to_hash_queue
c0123800 T __remove_inode_page
c0123860 T remove_inode_page
c01238a0 T __set_page_dirty
c0123900 T invalidate_inode_pages
c01239c0 t truncate_complete_page
c0123a10 t truncate_list_pages
c0123c90 T truncate_inode_pages
c0123d10 t invalidate_list_pages2
c0123ee0 T invalidate_inode_pages2
c0123f30 t writeout_one_page
c0123f80 T waitfor_one_page
c0123fd0 t do_buffer_fdatasync
c01240a0 T generic_buffer_fdatasync
c0124150 T filemap_fdatasync
c0124260 T filemap_fdatawait
c01242f0 T add_to_page_cache_locked
c0124380 T add_to_page_cache
c0124430 t add_to_page_cache_unique
c01244e0 t page_cache_read
c01245b0 t read_cluster_nonblocking
c01245f0 T ___wait_on_page
c0124680 t __lock_page
c0124720 T lock_page
c0124750 T __find_get_page
c01247a0 T __find_lock_page
c0124860 t generic_file_readahead
c01249e0 T mark_page_accessed
c0124a20 T do_generic_file_read
c0124f70 t generic_file_direct_IO
c0125180 T file_read_actor
c0125280 T generic_file_read
c0125430 t file_send_actor
c0125550 T sys_sendfile
c0125750 t nopage_sequential_readahead
c0125880 T filemap_nopage
c0125dd0 T filemap_sync
c01260a0 T generic_file_mmap
c0126120 t msync_interval
c01261c0 T sys_msync
c01262d0 t madvise_fixup_start
c01263b0 t madvise_fixup_end
c0126490 t madvise_fixup_middle
c0126610 t madvise_behavior
c01266b0 t madvise_willneed
c0126830 t madvise_dontneed
c0126860 t madvise_vma
c01268c0 T sys_madvise
c01269c0 t mincore_page
c0126a50 t mincore_vma
c0126b80 T sys_mincore
c0126ca0 T read_cache_page
c0126e60 T grab_cache_page
c0126f00 T generic_file_write
c0127760 T remove_suid
c01277c0 t change_protection
c01279a0 t mprotect_fixup
c0127e10 T sys_mprotect
c0128040 t mlock_fixup
c0128370 t do_mlock
c0128450 T sys_mlock
c0128500 T sys_munlock
c0128570 t do_mlockall
c0128610 T sys_mlockall
c01286a0 T sys_munlockall
c01286f0 t move_one_page
c0128870 t move_page_tables
c0128910 T do_mremap
c0128f60 T sys_mremap
c0128fd0 T vmfree_area_pages
c01291f0 T get_vm_area
c01292e0 T vfree
c0129380 T __vmalloc
c01295e0 T vread
c0129690 T vmalloc_area_pages
c0129880 t kmem_cache_estimate
c0129920 t kmem_slab_destroy
c01299f0 T kmem_cache_create
c0129d90 t smp_call_function_all_cpus
c0129dd0 t do_ccupdate_local
c0129e10 t drain_cpu_caches
c0129ec0 t __kmem_cache_shrink
c0129f50 T kmem_cache_shrink
c0129fa0 T kmem_cache_destroy
c012a0d0 t kmem_cache_grow
c012a330 T kmem_cache_alloc_batch
c012a400 t free_block
c012a500 T kmem_cache_alloc
c012a640 T kmalloc
c012a7d0 T kmem_cache_free
c012a850 T kfree
c012a8e0 T kmem_find_general_cachep
c012a920 t kmem_tune_cpucache
c012aa80 t enable_cpucache
c012aae0 t enable_all_cpucaches
c012ab30 T kmem_cache_reap
c012ae60 t proc_getdata
c012b080 T slabinfo_read_proc
c012b0d0 T slabinfo_write_proc
c012b230 T deactivate_page_nolock
c012b340 T deactivate_page
c012b360 T activate_page_nolock
c012b470 T activate_page
c012b490 T lru_cache_add
c012b550 T __lru_cache_del
c012b6d0 T lru_cache_del
c012b710 t swap_out
c012bcf0 t shrink_cache
c012c140 t refill_inactive
c012c2e0 t shrink_caches
c012c360 T try_to_free_pages
c012c3b0 t check_classzone_need_balance
c012c3e0 t kswapd_balance_pgdat
c012c480 t kswapd_balance
c012c4c0 t kswapd_can_sleep_pgdat
c012c500 t kswapd_can_sleep
c012c540 T kswapd
c012c600 t rw_swap_page_base
c012c790 T rw_swap_page
c012c840 T rw_swap_page_nolock
c012c930 t __free_pages_ok
c012cc00 t rmqueue
c012ce80 T _alloc_pages
c012cea0 t balance_classzone
c012d140 T __alloc_pages
c012d380 T __get_free_pages
c012d3a0 T get_zeroed_page
c012d3d0 T __free_pages
c012d400 T free_pages
c012d430 T nr_free_pages
c012d470 T nr_free_buffer_pages
c012d4c0 T nr_free_highpages
c012d4f0 T show_free_areas_core
c012d5f0 T show_free_areas
c012d600 t swap_writepage
c012d6d0 T show_swap_cache_info
c012d700 T add_to_swap_cache
c012d760 T __delete_from_swap_cache
c012d7b0 T delete_from_swap_cache
c012d820 T free_page_and_swap_cache
c012d900 T lookup_swap_cache
c012d950 T read_swap_cache_async
c012da70 T get_swap_page
c012dcc0 T swap_free
c012ddf0 t unuse_vma
c012e030 t unuse_process
c012e080 t find_next_to_unuse
c012e0c0 t try_to_unuse
c012e3f0 T sys_swapoff
c012e6f0 T get_swaparea_info
c012e930 T is_swap_partition
c012e970 T sys_swapon
c012f110 T si_swapinfo
c012f1e0 T swap_duplicate
c012f2b0 T swap_count
c012f340 T get_swaphandle_info
c012f450 T valid_swaphandles
c012f4f0 T alloc_pages_node
c012f510 t int_sqrt
c012f550 t badness
c012f610 t select_bad_process
c012f670 T oom_kill_task
c012f6c0 T oom_kill
c012f740 t shmem_recalc_inode
c012f7a0 t shmem_swp_entry
c012f820 t shmem_free_swp
c012f870 t shmem_truncate_part
c012f8b0 t shmem_truncate
c012fa10 t shmem_delete_inode
c012fa90 t shmem_writepage
c012fc20 t shmem_getpage_locked
c012fff0 t shmem_getpage
c01300f0 T shmem_nopage
c0130370 T shmem_lock
c0130490 t shmem_mmap
c01304e0 T shmem_get_inode
c0130660 t shmem_set_size
c01306b0 t shmem_file_write
c0130a90 t do_shmem_file_read
c0130bb0 t shmem_file_read
c0130c30 t shmem_statfs
c0130c90 t shmem_lookup
c0130cb0 t shmem_mknod
c0130d20 t shmem_mkdir
c0130d50 t shmem_create
c0130d70 t shmem_link
c0130de0 t shmem_empty
c0130e50 t shmem_unlink
c0130e90 t shmem_rmdir
c0130ed0 t shmem_rename
c0130f30 t shmem_symlink
c01310f0 t shmem_readlink
c01311d0 t shmem_follow_link
c01312a0 t shmem_parse_options
c0131470 t shmem_remount_fs
c01314d0 T shmem_sync_file
c01314e0 t shmem_read_super
c01315f0 t shmem_clear_swp
c0131640 t shmem_unuse_inode
c0131770 T shmem_unuse
c01317c0 T shmem_file_setup
c01318f0 T shmem_zero_setup
c0131940 t flush_all_zero_pkmaps
c01319d0 T kmap_high
c0131b50 T kunmap_high
c0131bf0 t bounce_end_io_write
c0131cb0 t bounce_end_io_read
c0131ea0 T alloc_bounce_page
c0131f50 T alloc_bounce_bh
c0132000 T create_bounce
c01321e0 T vfs_statfs
c0132270 T sys_statfs
c0132300 T sys_fstatfs
c0132390 T do_truncate
c01323f0 T sys_truncate
c0132570 T sys_ftruncate
c0132690 T sys_truncate64
c0132810 T sys_ftruncate64
c0132920 T sys_utime
c01329e0 T sys_utimes
c0132ae0 T sys_access
c0132c00 T sys_chdir
c0132d20 T sys_fchdir
c0132e20 T sys_chroot
c0132f60 T sys_fchmod
c0132ff0 T sys_chmod
c0133090 t chown_common
c0133180 T sys_chown
c01331d0 T sys_lchown
c0133220 T sys_fchown
c0133260 T filp_open
c01332c0 T dentry_open
c0133450 T get_unused_fd
c01335b0 T sys_open
c0133690 T sys_creat
c01336b0 T filp_close
c0133760 T sys_close
c01337d0 T sys_vhangup
c0133820 T generic_file_open
c0133860 T generic_read_dir
c0133870 T generic_file_llseek
c0133920 T no_llseek
c0133930 T default_llseek
c01339b0 T sys_lseek
c0133a80 T sys_llseek
c0133ba0 T sys_read
c0133c70 T sys_write
c0133d40 t do_readv_writev
c0133fa0 T sys_readv
c0134000 T sys_writev
c0134060 T sys_pread
c0134150 T sys_pwrite
c0134240 T get_device_list
c01342c0 t get_chrfops
c0134320 T register_chrdev
c0134410 T unregister_chrdev
c01344a0 T chrdev_open
c0134530 T kdevname
c0134560 T cdevname
c01345a0 t sock_no_open
c01345b0 T init_special_inode
c0134660 T get_empty_filp
c01347a0 T init_private_file
c0134810 T fput
c0134910 T fget
c0134950 T put_filp
c01349b0 T file_move
c0134a00 T fs_may_remount_ro
c0134a60 T __wait_on_buffer
c0134b00 T end_buffer_io_sync
c0134b60 t write_locked_buffers
c0134b90 t write_some_buffers
c0134cb0 t write_unlocked_buffers
c0134d00 t wait_for_buffers
c0134da0 t wait_for_locked_buffers
c0134de0 T sync_buffers
c0134e20 T fsync_super
c0134ed0 T fsync_no_super
c0134ef0 T fsync_dev
c0134f70 T sync_dev
c0134f80 T sys_sync
c0134f90 T file_fsync
c0135040 T sys_fsync
c01350d0 T sys_fdatasync
c0135160 t __insert_into_lru_list
c01351c0 t __remove_from_lru_list
c0135230 t __remove_from_free_list
c0135290 t __remove_from_queues
c01352c0 t __insert_into_queues
c0135340 t put_last_free
c01353c0 T get_hash_table
c0135470 T buffer_insert_inode_queue
c01354d0 T buffer_insert_inode_data_queue
c0135530 t __remove_inode_queue
c0135560 T inode_has_buffers
c01355a0 T __invalidate_buffers
c0135850 T set_blocksize
c0135aa0 t free_more_memory
c0135ac0 T init_buffer
c0135ae0 t end_buffer_io_async
c0135c10 T fsync_inode_buffers
c0135d90 T fsync_inode_data_buffers
c0135f10 T osync_inode_buffers
c0135fa0 T osync_inode_data_buffers
c0136030 T invalidate_inode_buffers
c01360c0 T getblk
c0136230 t balance_dirty_state
c0136280 T balance_dirty
c01362d0 T __mark_buffer_dirty
c0136300 T mark_buffer_dirty
c0136340 t __refile_buffer
c01363a0 T refile_buffer
c01363c0 T __brelse
c01363e0 T __bforget
c0136490 T bread
c0136500 t get_unused_buffer_head
c01365b0 T set_bh_page
c0136600 t create_buffers
c0136750 t unmap_buffer
c0136800 T discard_bh_page
c01368a0 T create_empty_buffers
c0136910 t unmap_underlying_metadata
c0136970 t __block_write_full_page
c0136b30 t __block_prepare_write
c0136de0 t __block_commit_write
c0136ec0 T block_read_full_page
c01371a0 T cont_prepare_write
c0137510 T block_prepare_write
c0137590 T generic_commit_write
c0137630 T block_truncate_page
c01378a0 T block_write_full_page
c0137a20 T generic_block_bmap
c0137a60 T generic_direct_IO
c0137bb0 t end_buffer_io_kiobuf
c0137c10 t wait_kio
c0137c80 T brw_kiovec
c0138080 T brw_page
c0138140 T block_symlink
c0138250 t grow_buffers
c01383e0 t sync_page_buffers
c0138480 T try_to_free_buffers
c0138660 T show_buffers
c0138780 T wakeup_bdflush
c01387a0 t sync_old_buffers
c0138830 T block_sync_page
c0138850 T sys_bdflush
c0138910 T bdflush
c01389f0 T kupdate
c0138b40 T set_buffer_async_io
c0138b60 T __mark_dirty
c0138b80 T unlock_buffer
c0138bc0 t get_filesystem
c0138be0 t put_filesystem
c0138c00 t find_filesystem
c0138c40 T register_filesystem
c0138cb0 T unregister_filesystem
c0138d20 t fs_index
c0138dc0 t fs_name
c0138e50 t fs_maxindex
c0138e80 T sys_sysfs
c0138ed0 T get_filesystem_list
c0138f50 T get_fs_type
c0138f90 T alloc_vfsmnt
c0138ff0 T lookup_mnt
c0139050 t detach_mnt
c01390a0 t attach_mnt
c0139140 t add_vfsmnt
c0139210 t clone_mnt
c01392b0 t graft_tree
c01393b0 T __mntput
c01393f0 t mangle
c0139490 T get_filesystem_info
c0139910 T drop_super
c0139960 t put_super
c01399b0 T sync_supers
c0139ab0 T get_super
c0139b40 T sys_ustat
c0139c50 t alloc_super
c0139db0 t read_super
c0139f00 T get_unnamed_dev
c0139f30 T put_unnamed_dev
c0139f70 t grab_super
c0139fe0 t get_sb_bdev
c013a2c0 t get_sb_nodev
c013a320 t get_sb_single
c013a4d0 t kill_super
c013a690 t do_remount_sb
c013a750 T may_umount
c013a770 t do_umount
c013a8f0 T sys_umount
c013aa50 T sys_oldumount
c013aa60 t mount_is_safe
c013aa90 t do_loopback
c013ab60 t do_remount
c013ac10 T do_kern_mount
c013add0 T kern_mount
c013adf0 t do_add_mount
c013aeb0 t copy_mount_options
c013af50 T do_mount
c013b0b0 T sys_mount
c013b1c0 t chroot_fs_refs
c013b390 T sys_pivot_root
c013b740 t blkdev_direct_IO
c013b840 t blkdev_writepage
c013ba20 t blkdev_readpage
c013bd10 t __blkdev_prepare_write
c013bf10 t blkdev_prepare_write
c013bf90 t __blkdev_commit_write
c013c030 t blkdev_commit_write
c013c0a0 t block_llseek
c013c140 t __block_fsync
c013c180 t block_fsync
c013c190 t bd_read_super
c013c230 t init_once
c013c280 t bdfind
c013c2b0 T bdget
c013c3f0 T bdput
c013c4a0 T bd_acquire
c013c560 T bd_forget
c013c5c0 T get_blkdev_list
c013c620 T get_blkfops
c013c640 T register_blkdev
c013c6d0 T unregister_blkdev
c013c730 T check_disk_change
c013c7b0 T ioctl_by_bdev
c013c800 T blkdev_get
c013c930 T blkdev_open
c013ca10 T blkdev_put
c013cba0 T blkdev_close
c013cbc0 t blkdev_ioctl
c013cc00 T bdevname
c013cc40 t init_once
c013cc80 t cdfind
c013ccb0 T cdget
c013cd90 T cdput
c013cde0 t cp_old_stat
c013cf00 t cp_new_stat
c013d060 T sys_stat
c013d0d0 T sys_newstat
c013d140 T sys_lstat
c013d1b0 T sys_newlstat
c013d220 T sys_fstat
c013d280 T sys_newfstat
c013d2e0 T sys_readlink
c013d370 t cp_new_stat64
c013d490 T sys_stat64
c013d500 T sys_lstat64
c013d570 T sys_fstat64
c013d5d0 T register_binfmt
c013d640 T unregister_binfmt
c013d6a0 T sys_uselib
c013d7c0 t count
c013d810 T copy_strings
c013da60 T copy_strings_kernel
c013da90 T put_dirty_page
c013db80 T setup_arg_pages
c013dcb0 T open_exec
c013dd70 T kernel_read
c013ddd0 t exec_mmap
c013dfc0 T flush_old_exec
c013e2b0 T prepare_binprm
c013e3d0 T compute_creds
c013e590 T remove_arg_zero
c013e6c0 T search_binary_handler
c013e810 T do_execve
c013e9f0 T set_binfmt
c013ea40 T do_coredump
c013ebe0 T pipe_wait
c013ec90 t pipe_read
c013eeb0 t pipe_write
c013f120 t pipe_lseek
c013f130 t bad_pipe_r
c013f140 t bad_pipe_w
c013f150 t pipe_ioctl
c013f1a0 t pipe_poll
c013f210 t pipe_release
c013f2a0 t pipe_read_release
c013f2c0 t pipe_write_release
c013f2e0 t pipe_rdwr_release
c013f310 t pipe_read_open
c013f340 t pipe_write_open
c013f370 t pipe_rdwr_open
c013f3c0 T pipe_new
c013f470 t pipefs_delete_dentry
c013f480 t get_pipe_inode
c013f520 T do_pipe
c013f7f0 t pipefs_statfs
c013f810 t pipefs_read_super
c013f8b0 T getname
c013f950 T vfs_permission
c013fa70 T permission
c013fb00 T get_write_access
c013fb40 T deny_write_access
c013fb90 T path_release
c013fbc0 t cached_lookup
c013fc10 t real_lookup
c013fd20 T follow_up
c013fdc0 T follow_down
c013fe60 T path_walk
c0140760 t __emul_lookup_dentry
c0140870 T set_fs_altroot
c01408f0 T path_init
c0140a90 T lookup_hash
c0140b70 T lookup_one_len
c0140be0 T __user_walk
c0140c40 T vfs_create
c0140d40 T open_namei
c0141290 t lookup_create
c0141300 T vfs_mknod
c0141440 T sys_mknod
c01415c0 T vfs_mkdir
c01416c0 T sys_mkdir
c0141790 t d_unhash
c0141800 T vfs_rmdir
c0141a00 T sys_rmdir
c0141af0 T vfs_unlink
c0141c80 T sys_unlink
c0141d90 T vfs_symlink
c0141e80 T sys_symlink
c0141f60 T vfs_link
c0142080 T sys_link
c01421a0 T vfs_rename_dir
c0142640 T vfs_rename_other
c01428f0 T vfs_rename
c0142980 T sys_rename
c0142bf0 T vfs_readlink
c0142c40 T vfs_follow_link
c0142de0 t page_getlink
c0142e90 T page_readlink
c0142f20 T page_follow_link
c0143130 t expand_files
c0143180 t locate_fd
c0143280 t dupfd
c0143320 T sys_dup2
c0143400 T sys_dup
c0143430 t setfl
c01434f0 t do_fcntl
c01437c0 T sys_fcntl
c0143800 T sys_fcntl64
c01438a0 t send_sigio_to_task
c0143980 T send_sigio
c0143a30 T fasync_helper
c0143b20 T __kill_fasync
c0143b90 T kill_fasync
c0143bd0 t file_ioctl
c0143d40 T sys_ioctl
c0143f50 T vfs_readdir
c0144020 T dcache_readdir
c0144170 t fillonedir
c0144240 T old_readdir
c01442a0 t filldir
c0144380 T sys_getdents
c0144420 t filldir64
c0144560 T sys_getdents64
c0144620 T poll_freewait
c0144670 T __pollwait
c0144700 t max_select_fd
c01447e0 T do_select
c0144a20 t select_bits_alloc
c0144a40 t select_bits_free
c0144a50 T sys_select
c0144ed0 t do_pollfd
c0144f50 t do_poll
c0145030 T sys_poll
c01453b0 t wait_for_partner
c01453e0 t wake_up_partner
c0145400 t fifo_open
c01456d0 t locks_alloc_lock
c0145720 T locks_init_lock
c01457b0 t init_once
c01457d0 T locks_copy_lock
c0145840 t flock_make_lock
c01458b0 t assign_type
c01458e0 t flock_to_posix_lock
c01459d0 t flock64_to_posix_lock
c0145b20 t lease_alloc
c0145c10 t locks_delete_block
c0145c60 t locks_insert_block
c0145ce0 t locks_wake_up_blocks
c0145d70 t locks_insert_lock
c0145db0 t locks_delete_lock
c0145e80 t locks_conflict
c0145ec0 t posix_locks_conflict
c0145f50 t flock_locks_conflict
c0145f90 t interruptible_sleep_on_locked
c0146040 t locks_block_on
c0146070 t locks_block_on_timeout
c01460a0 T posix_test_lock
c0146130 t posix_locks_deadlock
c0146190 T locks_mandatory_locked
c0146220 T locks_mandatory_area
c01463d0 t flock_lock_file
c0146530 T posix_lock_file
c0146ae0 T __get_lease
c0146d40 T lease_get_mtime
c0146d70 T fcntl_getlease
c0146da0 t lease_modify
c0146e20 T fcntl_setlease
c01470c0 T sys_flock
c01471b0 T fcntl_getlk
c01473c0 T fcntl_setlk
c0147590 T fcntl_getlk64
c0147770 T fcntl_setlk64
c0147940 T locks_remove_posix
c0147ae0 T locks_remove_flock
c0147b90 T posix_block_lock
c0147ba0 T posix_unblock_lock
c0147bc0 t lock_get_status
c0147db0 t move_lock_status
c0147e30 T get_locks_status
c0147fb0 T lock_may_read
c01480a0 T lock_may_write
c0148180 T dput
c01482f0 T d_invalidate
c0148380 T dget_locked
c01483b0 T d_find_alias
c0148420 T d_prune_aliases
c01484d0 T prune_dcache
c0148650 T shrink_dcache_sb
c01487f0 T have_submounts
c0148870 t select_parent
c0148920 T shrink_dcache_parent
c0148950 T shrink_dcache_memory
c0148980 T d_alloc
c0148b00 T d_instantiate
c0148b60 T d_alloc_root
c0148ba0 T d_lookup
c0148cc0 T d_validate
c0148da0 T d_delete
c0148e50 T d_rehash
c0148ec0 T d_move
c0149040 T __d_path
c0149140 T sys_getcwd
c0149300 T is_subdir
c0149330 T d_genocide
c01493b0 T find_inode_number
c0149450 t init_buffer_head
c0149490 t destroy_inode
c01494d0 t init_once
c01495d0 T __mark_inode_dirty
c0149680 t __wait_on_inode
c0149720 T sync_inodes_sb
c0149960 T sync_unlocked_inodes
c0149b40 t get_super_to_sync
c0149bd0 T sync_inodes
c0149c20 t try_to_sync_unused_inodes
c0149e20 T write_inode_now
c014a070 T generic_osync_inode
c014a110 T clear_inode
c014a1f0 t dispose_list
c014a250 t invalidate_list
c014a310 T invalidate_inodes
c014a390 T invalidate_device
c014a3e0 T prune_icache
c014a500 T shrink_icache_memory
c014a540 t find_inode
c014a590 t clean_inode
c014a640 T get_empty_inode
c014a6d0 t get_new_inode
c014a860 T iunique
c014a8e0 T igrab
c014a990 T iget4
c014aa90 T insert_inode_hash
c014aaf0 T remove_inode_hash
c014ab20 T iput
c014ace0 T force_delete
c014ad00 T bmap
c014ad30 T update_atime
c014ad80 T inode_change_ok
c014af00 T inode_setattr
c014afe0 t setattr_mask
c014b050 T notify_change
c014b160 t bad_follow_link
c014b1a0 t return_EIO
c014b1b0 T make_bad_inode
c014b1e0 T is_bad_inode
c014b200 T alloc_fd_array
c014b240 T free_fd_array
c014b280 T expand_fd_array
c014b3e0 T alloc_fdset
c014b420 T free_fdset
c014b480 T expand_fdset
c014b6d0 T end_kio_request
c014b730 t kiobuf_init
c014b780 T alloc_kiobuf_bhs
c014b800 T free_kiobuf_bhs
c014b850 T alloc_kiovec
c014b8e0 T free_kiovec
c014b950 T expand_kiobuf
c014b9d0 T kiobuf_wait_for_io
c014ba70 t redo_inode_mask
c014bab0 T fcntl_dirnotify
c014bc30 T __inode_dir_notify
c014bce0 T sys_quotactl
c014bcf0 t set_brk
c014bd30 t dump_write
c014bd60 t aout_core_dump
c014bf80 t create_aout_tables
c014c100 t load_aout_binary
c014c720 t load_aout_library
c014c9c0 t clear_entry
c014ca30 t clear_entries
c014ca90 t get_entry
c014cad0 t check_file
c014cba0 t load_misc_binary
c014cd00 t copyarg
c014ce80 t proc_write_register
c014d110 t proc_read_status
c014d2b0 t proc_write_status
c014d350 t entry_proc_cleanup
c014d370 t entry_proc_setup
c014d3d0 t load_script
c014d580 t set_brk
c014d5c0 t padzero
c014d5e0 t create_elf_tables
c014d8c0 t load_elf_interp
c014db80 t load_aout_interp
c014dcb0 t load_elf_binary
c014e6c0 t load_elf_library
c014e8e0 t dump_write
c014e910 t dump_seek
c014e960 t notesize
c014e990 t writenote
c014ea40 t elf_core_dump
c014f380 T de_get
c014f390 T de_put



-- 
Bob Matthews
Red Hat, Inc.
