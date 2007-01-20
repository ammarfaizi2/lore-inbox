Return-Path: <linux-kernel-owner+w=401wt.eu-S932872AbXATMXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbXATMXn (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 07:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbXATMXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 07:23:43 -0500
Received: from lucidpixels.com ([66.45.37.187]:43353 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbXATMXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 07:23:41 -0500
Date: Sat, 20 Jan 2007 07:23:39 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org, xfs@oss.sgi.com, Neil Brown <neilb@suse.de>
Subject: Kernel 2.6.19.2 New RAID 5 Bug (oops when writing Samba -> RAID5)
Message-ID: <Pine.LNX.4.64.0701200718290.29223@p34.internal.lan>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-1358739522-1169295819=:29223"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1358739522-1169295819=:29223
Content-Type: TEXT/PLAIN; charset=US-ASCII

My .config is attached, please let me know if any other information is 
needed and please CC (lkml) as I am not on the list, thanks!

Running Kernel 2.6.19.2 on a MD RAID5 volume.  Copying files over Samba to 
the RAID5 running XFS.

Any idea what happened here?

[473795.214705] BUG: unable to handle kernel paging request at virtual 
address fffb92b0
[473795.214715]  printing eip:
[473795.214718] c0358b14
[473795.214721] *pde = 00003067
[473795.214723] *pte = 00000000
[473795.214726] Oops: 0000 [#1]
[473795.214729] PREEMPT SMP 
[473795.214736] CPU:    0
[473795.214737] EIP:    0060:[<c0358b14>]    Not tainted VLI
[473795.214738] EFLAGS: 00010286   (2.6.19.2 #1)
[473795.214746] EIP is at copy_data+0x6c/0x179
[473795.214750] eax: 00000000   ebx: 00001000   ecx: 00000354   edx: fffb9000
[473795.214754] esi: fffb92b0   edi: da86c2b0   ebp: 00001000   esp: f7927dc4
[473795.214757] ds: 007b   es: 007b   ss: 0068
[473795.214761] Process md4_raid5 (pid: 1305, ti=f7926000 task=f7ea9030 task.ti=f7926000)
[473795.214765] Stack: c1ba7c40 00000003 f5538c80 00000001 da86c000 00000009 00000000 0000006c 
[473795.214790]        00001000 da8536a8 aa6fee90 f5538c80 00000190 c0358d00 aa6fee88 0000ffff 
[473795.214863]        d7c5794c 00000001 da853488 f6fbec70 f6fbebc0 00000001 00000005 00000001 
[473795.214876] Call Trace:
[473795.214880]  [<c0358d00>] compute_parity5+0xdf/0x497
[473795.214887]  [<c035b0dd>] handle_stripe+0x930/0x2986
[473795.214892]  [<c01146b9>] find_busiest_group+0x124/0x4fd
[473795.214898]  [<c03580e0>] release_stripe+0x21/0x2e
[473795.214902]  [<c035d233>] raid5d+0x100/0x161
[473795.214907]  [<c036b03c>] md_thread+0x40/0x103
[473795.214912]  [<c012dbbe>] autoremove_wake_function+0x0/0x4b
[473795.214917]  [<c036affc>] md_thread+0x0/0x103
[473795.214922]  [<c012da1a>] kthread+0xfc/0x100
[473795.214926]  [<c012d91e>] kthread+0x0/0x100
[473795.214930]  [<c0103b4b>] kernel_thread_helper+0x7/0x1c
[473795.214935]  =======================
[473795.214938] Code: 14 39 d1 0f 8d 10 01 00 00 89 c8 01 c0 01 c8 01 c0 
01 c0 89 44 24 1c eb 51 89 d9 c1 e9 02 8b 7c 24 10 01 f7 8b 44 24 18 8d 34 
02 <f3> a5 89 d9 83 e1 03 74 02 f3 a4 c7 44 24 04 03 00 00 00 89 14 
[473795.215017] EIP: [<c0358b14>] copy_data+0x6c/0x179 SS:ESP 
0068:f7927dc4
[473795.215024]  <6>note: md4_raid5[1305] exited with preempt_count 2

# mdadm -D /dev/md4
/dev/md4:
        Version : 01.00.03
  Creation Time : Wed Jan 10 15:58:52 2007
     Raid Level : raid5
     Array Size : 1562834432 (1490.44 GiB 1600.34 GB)
    Device Size : 781417216 (372.61 GiB 400.09 GB)
   Raid Devices : 5
  Total Devices : 5
Preferred Minor : 4
    Persistence : Superblock is persistent

    Update Time : Sat Jan 20 07:15:01 2007
          State : active
 Active Devices : 5
Working Devices : 5
 Failed Devices : 0
  Spare Devices : 0

         Layout : left-symmetric
     Chunk Size : 128K

           Name : 4
           UUID : 7f453e18:893e4dd9:6e810372:4c724f49
         Events : 33

    Number   Major   Minor   RaidDevice State
       0       8       33        0      active sync   /dev/sdc1
       1       8       81        1      active sync   /dev/sdf1
       2       8      113        2      active sync   /dev/sdh1
       3       8       65        3      active sync   /dev/sde1
       5       8       49        4      active sync   /dev/sdd1

---1463747160-1358739522-1169295819=:29223
Content-Type: APPLICATION/octet-stream; name=config.bz2
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0701200723390.29223@p34.internal.lan>
Content-Description: 
Content-Disposition: attachment; filename=config.bz2

QlpoOTFBWSZTWQ8rjMoACWRfgGgQXOf//z////C////gYCH8dAAG+bHoBIfX
yB2z65Ruqvrdd7zAADm9ZT3MU9b7eq90zzsHXzyt92oeQG867pQ65B2293Jd
sBd614Xd13u9avW3uYfd76y+7m2vaZ3nb6wNTCCZNBoEyCaTEwhMAFDaJ4Ka
PSD1BpoRoEyTQ1GgknqaGmmgAAAAAAMQQQDSAlTxPUJ5QAGgAYgaAAEmkoJo
jTSp7TSm1HiNRoNAAAaBoDRoAikJMmiYKZ5EnppMhoAZGmjTQ0AaAASIggAI
gIUaj1PUPRHqAAAAAGnh+ZP9B/5I8UnNxWVizytgaOmUrUJUYgJjZFFBZjFh
H6KwevdDVDtrql+j5sNHRpFR+7h8+nzuppdLsuGkP8WVm1pKAZKjEXBAJe7i
WYv9xMaL/NMplpcQGP1fVM6Rfr+JDHtYvkyYmILKrJRIpWQr6HGZjRyqCJWK
LUqCrbaWoqsqKBUFPVmZKlaKMiNQlS62sVMo0oKRVFBRFRKW0tXLK40TW0Ii
oCmFoVka2oxBRURQURKy2WpC2igsIKExhcpAG2VK1lRtKlanva41BEPNISuW
yVBEKMm2UAcsigChWAqqChW0aVK1g2yopVtIVILbSKFtK0VlYsixsAlZCGjJ
CmFpSW1a1pa/WSxUFTFt4zDJB9aVQcEq0ou+GYW2URWKI20KhSpYqVUClsG2
JV4uCrjSoVErVLZdmkTGopS1QKhRi21GVZattqLKkAKZMr0919GWtHnfTBf0
95ablL0yl5e6OA7C/ALmWRYEP5LvvAAhI8+IyfcRyv6TxpQ9N4S/ibZOOUfF
P9tFg9KbYwHT/u4j+9mzF7x9c/mqWbqxsnT5mWrduIZd12+H5NJw8kH6uZJ9
rezpzvRFRk6JwmqfuTh8kfl5j57art0VzKAcQiWOlSBgtIPwN5myF8JTjUVn
QgwL7bZX4byLjYp6ddo/ibhPIsY5jQWZFx9ctovzPzFXI9Xz+vdPs4fUtOD9
f35OqJuv2nV7FQpRk7yfXxV/MpwsLyq6MX/R7rA6x9HBlmqzEfZxbaXd3jas
q81ecR/IcZ7Vrt0wFOen24Vzo5NQRtKAQeivSb5uAe7CSWG9c8U/anyhCpz8
7J6Idrf2zc3hQowzuxpaKsAVtwjUozki/ek1vgNzak1J1cLNfi65yiIqzcm/
e1iHyErTfuKbqOg1cr1hKs63rwcEfVjxPMKXxuhXngNxbLdslMGzPlZdcJe/
I+DInSWMG5DE6dGPC/G2lTOEhcTHt58ujjOjq2lItNt+vA9TRGrxg6n93k5D
c5TNzTgnHfndql9F38V1G1BXVVa3jebMyhKHGs1DSgjZ8U51clVtxDROEcHq
MONelmtb7VoKVmDDbvbpQmudC8zqN/M5bZiVzRtOSZQhY+rhNtKGpcUejOVn
G96bYojzeK1x5TZvdr+OM8wtV7jRpGvbaD7z5pjXlG3pvOBLeXlY6W/t69ev
FFj0L59W5gwwrq5bfk2q/e3oOIWa4Y0xmU1d0a1T1vsnrrl04xt6bLK2413B
vG6WGEqsAsj2rtKsw7XHdmtt8xc6y5onPdMwZ5QWrPS3xXjhXCWWGIrxeuFG
7cNY0lhEobzWyxOf29nf3bu3zJ7omnoPzhjGAMYPbV7fP3vd40UaRnfEfSEQ
xjAGMEOVnwKZWZnfMH7ZnLG5qhaKityR/wQrK+a3Pkuw9HLHAfMDpBAQPltf
C/nkiTL3gl0T7ZzR2t1yyrTxbzqYY3pYPiLvteP5T86cPVDz7q7/LeNNMPSS
eOfL8beB+NBIfOsdOrOIEJ/mmR86Td3DTPv/bagUL21DQarJNDBmak5OYF1+
pDCAtIZD6Zr4QoqUKOrbLVWgv6lo61xVfC6UPKOp1zjx/j8YXp+C7ubiEp9H
yG79bLUnv+VY/cmdYn+/z/W29jA18is5zW9dNqgf3t6iFa114Dj65VWS0uU+
jmlfSZ/OIR030fSm/GBR4k23ihNrtsjgjXzM/DWKVF4iMXBDaCJ6xirFBqOt
jh8rMZWQ48m3ZTE37Y8NteinbzvgYysZE9tSLIEi30qcAAXTkI3zER2PcEGF
cczZi5Fquy3NkT9MXnwn9ZU6nZX5kDtnYMLzaTmCBBlIXVum3X9cDNaTcex9
J2mg2+DvlBEPNCESuBxhuJJ9Q+frtXhfOM9171lrVhytJbnj4a8vNMm3cfLS
JW6ZDqzEk+iIKFC35HCZi0rooUWkNTNruws1Ub0k83Zg3X8naNKOI5xTF/cf
SFhhF4ChjIaZXNAFtFBAMAvWNU+lnwHMFh7W/x5+noaxJzzu8ODI6vFhyEMx
YiH6/FJne2txwgUQGezpqL0a0/Twd4bdSdaDp2MebqPHmZQOpGQ3yPZ3HYwy
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
IT3KXTlx1Hcpr3oSI/4u5IpwoSAeVxmU

---1463747160-1358739522-1169295819=:29223--
