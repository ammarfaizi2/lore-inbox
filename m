Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286128AbRLJBc7>; Sun, 9 Dec 2001 20:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286131AbRLJBcu>; Sun, 9 Dec 2001 20:32:50 -0500
Received: from mail.hubwest.com ([65.164.117.120]:53517 "EHLO mail.hubwest.com")
	by vger.kernel.org with ESMTP id <S286128AbRLJBci>;
	Sun, 9 Dec 2001 20:32:38 -0500
Message-ID: <3C1410BB.6884E52F@yahoo.com>
Date: Sun, 09 Dec 2001 18:32:43 -0700
From: LBJM <LB33JM16@yahoo.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: highmem, aic7xxx, and vfat: too few segs for dma mapping
X-Priority: 1 (Highest)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not on on the kernel mailing list please CC to me

I upgrade  my computer's ram from 512MB to 2GB of ram and complied in
high mem support 4GB.
My system uses the XFS filesystem as my root filesystem. my distro is
debian sid. my system  is an athlon 700 mhz slota on an abit KA7 (KX133
based chipset) my system is all scsi. my scsi card is an adaptec 2940UW(
I also have an 2940U2W I can switch it with). I have two hard drives
both  IBM an 18 gig(DNES-318350W) and a 4 gig(DDRS-34560W). I have a zip
100 scsi and a plextor 12/10/32S.

When I upgraded to 2gigs of ram I was using 2.4.10 then used 2.4.14 and
2.4.16 each did a kernel panic. however none do it with highmem off.
just like others it only happens when copying from dev mounted as /.
however me with I have a second hard drive and a zipdrive that both have
partitions that can be mounted as vfat. the first hard drive also has a
partition that I mount as vfat. it doesn't matter where I copy to the
first hard drive the second hard or the zipdrive I still get the same
error.

I've also had the error locking at making tag count 64( somebody in the
archives said that it doing that is normal. I've had that problem for
years it doesn't hurt anything so I ignore it. so why does it do that?)

I've read through the archives somebody posted the if they change the
#define NSEG from 128 to 512 it goes away. it went away for me too when
I did that and recomplied the kernel it went away for me too.
I found this in aic7xxx_osm.h suggesting the 128 setting was only for
highmem off
/*
 * Number of SG segments we require.  So long as the S/G segments for
 * a particular transaction are allocated in a physically contiguous
 * manner and are allocated below 4GB, the number of S/G segments is
 * unrestricted.
 */
applied the debug patch with NSEG set to 128 (default) on kernel 2.4.16

here are my results:

too few segs for dma mapping. Increase AHC_NSEG
invalid operand: 0000
CPU: 0
EIP: 0010 : [<c0235db5>] not tainted
EFLAGS: 00010046
eax: ffffffff     ebx: f7bc82a0    ecx: c0344000    edx: 00000000
esi: 00001000    edi: f6ca1000    ebp: f7bc4fc0    esp: c0345f18
ds: 0018    es: 0018    ss: 0018
Process swapper (pid:0, stackpage=c0345000)
Stack: c301ac00 c0345f5c 0000000f c0345fa8 c0345fa8 f7b4a000 c0239198
c301ac00
             41bc82a0 c3010002 f7b44200 c0236349 c301ac00 c301f780
f7bd0340 04000001
            c0117eba 00000292 c010818f 0000000f c301ac00 c0345fa8
000003c0 c0378cc0
Call trace: [<c0239198>] [<c0236349>] [<c0117eba>] [<c010818f>]
[<c010830e>] [c0105390>] [<c01053b3>]

[<c0105422>] [<c0105000>] [<c0105027>]
code: 0f 0b 80 4f 07 80 8b 03 8b 53 2c 83 ca 02 89 50 14 8b 13 8b
<0> Kernel panic: Aiee, killing interrupt handler!
in interrupt handler_not syncing.

if anyone would like me to do any extra troubleshooting. I'm game just
make sure you CC me the email.
thanks
LBJM

