Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSIIOf4>; Mon, 9 Sep 2002 10:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSIIOf4>; Mon, 9 Sep 2002 10:35:56 -0400
Received: from wv-morgantown1-235.mgtnwv.adelphia.net ([24.50.80.235]:47870
	"EHLO sandm.hn.org") by vger.kernel.org with ESMTP
	id <S317278AbSIIOfy>; Mon, 9 Sep 2002 10:35:54 -0400
Subject: Re: Linux 2.4.20-pre5-ac4
From: Scott Henson <shenson2@sandm.hn.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <m3wupwhhj2.fsf@lapper.ihatent.com>
References: <200209061500.g86F08m12929@devserv.devel.redhat.com>
	<200209072328.27543.hpj@urpla.net>  <m3wupwhhj2.fsf@lapper.ihatent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 10:40:35 -0400
Message-Id: <1031582435.5349.200.camel@sandm.hn.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-08 at 07:01, Alexander Hoogerhuis wrote:
> Not sure I'm having the same, but having a DVD in my drive when I log
> in to gnome (rawhide, running 2.4.20-pre5-ac4-preempt) it locks solid,
> caps lock blinks steadily, and the disk light blinks two short bursts
> and a long break). I'll give it a spin to build without preempt later
> today to see if it persists. In addition, I got this BUG when trying
> to use cdrecord on same kernel just now:

I would just like to add a me to.  At least this happened with out fail
with 2.4.20-pre5-ac{1,2}.  I never tested 3 on this machine.  But now I
am running ac4 and it seems to be working fine, until I try to use the
cd-rw at all, then it locks the in the D state and leaving the terminal
I was running it on in the R state.  Also my cd-rw drive is locked and
will not open.  All I can find in my logs is an error message:

kernel BUG at /usr/src/linux-2.4.19/include/linux/blkdev.h:153!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0234b15>]    Not tainted
EFLAGS: 00010206
eax: 0000005a   ebx: c1852000   ecx: c0412600   edx: e7070820
esi: 00000000   edi: e7070820   ebp: e7070800   esp: e2cdbc30
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 900, stackpage=e2cdb000)
Stack: c1852000 c04127ec e7070820 e7070800 000001f4 c024a9f3 c04127ec
c1850000 
       c0234deb c0412600 e7070820 c0412600 c04127ec e7070820 e7070800
00000000 
       00000000 c0412600 c0235279 c04127ec e7070820 c04127ec c04127ec
e71cfd20 
Call Trace:    [<c024a9f3>] [<c0234deb>] [<c0235279>] [<c024a8bf>]
[<c024aa17>]
  [<c022b922>] [<c022bc1c>] [<c022c1ca>] [<c023e500>] [<c024b556>]
[<c02396df>]
  [<c023e500>] [<c023fcb1>] [<c0204154>] [<c011aadc>] [<c01353ac>]
[<c0136151>]
  [<c0171b9e>] [<c0138dea>] [<c0147756>] [<c0138f9d>] [<c01485a9>]
[<c0148862>]
  [<c01486c4>] [<c0148be4>] [<c0108487>]

Code: 0f 0b 99 00 80 59 33 c0 8b 44 24 24 c7 80 24 04 00 00 01 00 
 scsi : aborting command due to timeout : pid 17, scsi0, channel 0, id
0, lun 0 Read (10) 00 00 00 00 10 00 00 01 00 
scsi : aborting command due to timeout : pid 17, scsi0, channel 0, id 0,
lun 0 Read (10) 00 00 00 00 10 00 00 01 00 
SCSI host 0 abort (pid 17) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
hdb: DMA disabled
hdb: ATAPI reset complete

I have hdb=scsi passed to my kernel at boot.  I still have both of the
pre5-ac{1,2} kernels laying around if someone would like any work done
on them(I just didnt have anytime to be messing with them when I
originally compiled them).  Also under aci and ac2 I passed hdb=ide-scsi
but I changed that after seeing a recommendation to on the list to
hdb=scsi when I compiled and installed ac4.  

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 30)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.35-ac
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       30ns      60ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        90ns      90ns      30ns      30ns
Data Active:         90ns      90ns      90ns     330ns
Data Recovery:       30ns      90ns      30ns     270ns
Cycle Time:          30ns     180ns      20ns     600ns
Transfer Rate:   66.6MB/s  11.1MB/s  99.9MB/s   3.3MB/s

I am running a fully up-to-date Debian Sid. 

-- 
