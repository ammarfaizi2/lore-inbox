Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTDVRjk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTDVRjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:39:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5255 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263305AbTDVRjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:39:37 -0400
Date: Tue, 22 Apr 2003 13:54:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Julien Oster <frodoid@frodoid.org>
cc: Michael Buesch <fsdeveloper@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
In-Reply-To: <20030422165434.GA363@ggom.de>
Message-ID: <Pine.LNX.4.53.0304221341150.14432@chaos>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
 <200304221844.05754.fsdeveloper@yahoo.de> <20030422165434.GA363@ggom.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Julien Oster wrote:

> On Tue, Apr 22, 2003 at 06:44:05PM +0200, Michael Buesch wrote:
>
> Hello Michael,
>
> > > it's been quite a while that I noticed that any ordinary user, not
> > > just root, can type "dmesg" to see the kernel ring buffer.
>
> > just make
> > $ chmod 700 /bin/dmesg
>
> Thanks for the answer, but that doesn't help that much, since any user
> could copy dmesg from his system or simply code a dmesg replacement
> within a few minutes.
>
> Regards,
> Julien
> -

dmesg gets it's data from syslog(0x03, char *buf, size_t buf_len)
where 0x03 says 'read' up to 4k.

The kernel interface is documented to return -EPERM if the effective
user isn't root. I have just tried `dmesg` from several machines
with various versions of Linux and they all allow a user to read.

The usual "tie-breaker" I use for configuration problems is
my Sun. It runs SunOs 5.5.1 and it allows an ordinary user
to execute `dmesg` and read kernel messages.


Script started on Tue Apr 22 13:49:44 2003
$ rlogin -l johnson hal
Password:
Last login: Wed Nov  6 09:29:53 from chaos
hal:/export/home/johnson[1] who am i
johnson    pts/0        Apr 22 13:42	(chaos)
hal:/export/home/johnson[2] dmesg

Apr 22 13:42
SunOS Release 5.5.1 Version Generic [UNIX(R) System V Release 4.0]
Copyright (c) 1983-1996, Sun Microsystems, Inc.
vac: enabled in writeback mode
cpu0: FMI,MB86907 (mid 0 impl 0x0 ver 0x5 clock 170 MHz)
mem = 32768K (0x2000000)
avail mem = 28446720
Ethernet address = 8:0:20:8e:b:0
root nexus = SUNW,SPARCstation-5
iommu0 at root: obio 0x10000000
sbus0 at iommu0: obio 0x10001000
espdma0 at sbus0: SBus slot 5 0x8400000
esp0 at espdma0: SBus slot 5 0x8800000 sparc ipl 4
sd0 at esp0: target 0 lun 0
sd0 is /iommu@0,10000000/sbus@0,10001000/espdma@5,8400000/esp@5,8800000/sd@0,0
	<SEAGATE-ST32155N-0532 cyl 4162 alt 2 hd 8 sec 126>
sd2 at esp0: target 2 lun 0
sd2 is /iommu@0,10000000/sbus@0,10001000/espdma@5,8400000/esp@5,8800000/sd@2,0
	Vendor 'PIONEER', product 'DE-C7001', (unknown capacity)
sd3 at esp0: target 3 lun 0
sd3 is /iommu@0,10000000/sbus@0,10001000/espdma@5,8400000/esp@5,8800000/sd@3,0
	<SUN2.1G cyl 2733 alt 2 hd 19 sec 80>
root on /iommu@0,10000000/sbus@0,10001000/espdma@5,8400000/esp@5,8800000/sd@3,0:a fstype ufs
obio0 at root
zs0 at obio0: obio 0x100000 sparc ipl 12
zs0 is /obio/zs@0,100000
zs1 at obio0: obio 0x0 sparc ipl 12
zs1 is /obio/zs@0,0
cgsix0 at sbus0: SBus slot 3 0x0 SBus level 5 sparc ipl 9
cgsix0 is /iommu@0,10000000/sbus@0,10001000/cgsix@3,0
cgsix0: screen 1152x900, single buffered, 1M mappable, rev 11
cpu 0 initialization complete - online
ledma0 at sbus0: SBus slot 5 0x8400010
le0 at ledma0: SBus slot 5 0x8c00000 sparc ipl 6
le0 is /iommu@0,10000000/sbus@0,10001000/ledma@5,8400010/le@5,8c00000
dump on /dev/dsk/c0t3d0s1 size 66108K
pcmcia: no PCMCIA adapters found
hal:/export/home/johnson[3] exit
logout
rlogin: connection closed.
# exit
exit
Script done on Tue Apr 22 13:50:18 2003


It doesn't look like there's anything that an ordinary user
shouldn't see. If somebody has written code that sends
proprietary information out this "hole", that code should
be fixed, not this.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

