Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTJJPoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbTJJPoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:44:38 -0400
Received: from wiggis.ethz.ch ([129.132.86.197]:15839 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S262953AbTJJPog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:44:36 -0400
From: Thom Borton <borton@phys.ethz.ch>
To: Dave Jones <davej@redhat.com>
Subject: Re: PCMCIA CD-ROM does not work
Date: Fri, 10 Oct 2003 17:44:30 +0200
User-Agent: KMail/1.5.4
References: <200310101652.53796.borton@phys.ethz.ch> <20031010150916.GA32600@redhat.com>
In-Reply-To: <20031010150916.GA32600@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ePth/4vGHZFzwHN"
Message-Id: <200310101744.30827.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ePth/4vGHZFzwHN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Thanks a lot, I tried the parameters 
	ide1=0x386,0x180 pci=off
and it did not work. pci=off seems to have broken quite a lot (fb, 
jogdial, ...). Just leaving it away and just having ide1=0x386,0x180 
didn't help the CD-ROM drive either.

I am now compiling the 2.4.19/20/21 kernels to try to figure out, 
where it broke. I have some suspicion that it happened when ide-cs.c 
was moved to legacy from drivers/ide.

BTW, if it's legacy, what replaces it?

Thom


On Friday 10 October 2003 17:09, Dave Jones wrote:
> On Fri, Oct 10, 2003 at 04:52:50PM +0200, Thom Borton wrote:
>  > Hello everybody
>  >
>  > I have a Sony Vaio PCG-Z600NE with an external PCMCIA 4x CD-ROM
>  > drive, which used to work perfectly until around 2.4.18. With
>  > later kernels I did not succeed to get it running. I tried
>  > extensively with 2.4.22. As far as I remember, 2.4.19-21 did not
>  > work either.
>  >
>  > I have attached the syslogs for 2.4.18, 2.4.22 and 2.6.0-test7.
>  >
>  > Any idea what's wrong? Thanks for the help.
>
> I'm not sure what broke it, but if you boot with "ide1=0x386,0x180
> pci=off" it works again.  Not a perfect solution, but until someone
> does some digging to find out exactly when it broke, we're stuck.
>
> 		Dave

-- 
Thom Borton
Switzerland

--Boundary-00=_ePth/4vGHZFzwHN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslog-2.4.22-fail2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.4.22-fail2.txt"

Oct 10 17:30:43 grisu kernel: Yenta IRQ list 00b8, PCI irq9
Oct 10 17:30:43 grisu kernel: Socket status: 30000416
Oct 10 17:30:43 grisu cardmgr[378]: watching 1 socket
Oct 10 17:30:43 grisu cardmgr[379]: starting, version is 3.2.5
Oct 10 17:30:59 grisu cardmgr[379]: socket 0: Ninja ATA
Oct 10 17:30:59 grisu kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xdc000-0xdffff 0xe8000-0xfffff
Oct 10 17:30:59 grisu cardmgr[379]: executing: 'modprobe ide-cs'
Oct 10 17:31:18 grisu kernel: hdc: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
Oct 10 17:31:18 grisu kernel: hdc: IRQ probe failed (0xb4f8)
Oct 10 17:31:18 grisu kernel: hdd: IRQ probe failed (0xb4f8)
Oct 10 17:31:18 grisu kernel: hdd: IRQ probe failed (0xb4f8)
Oct 10 17:31:18 grisu kernel: hdd: no response (status = 0x0a), resetting drive
Oct 10 17:31:18 grisu kernel: hdd: IRQ probe failed (0xb4f8)
Oct 10 17:31:18 grisu kernel: hdd: no response (status = 0x0a)
Oct 10 17:31:18 grisu kernel: ide1: DISABLED, NO IRQ
Oct 10 17:31:20 grisu kernel: ide1: ports already in use, skipping probe
Oct 10 17:31:36 grisu last message repeated 8 times
Oct 10 17:31:37 grisu kernel: ide_cs: ide_register() at 0x180 & 0x386, irq 0 failed
Oct 10 17:31:38 grisu cardmgr[379]: get dev info on socket 0 failed: Resource temporarily unavailable
Oct 10 17:31:41 grisu cardmgr[379]: executing: 'modprobe -r ide-cs'

--Boundary-00=_ePth/4vGHZFzwHN--

