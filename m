Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313264AbSDJQBf>; Wed, 10 Apr 2002 12:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313268AbSDJQBe>; Wed, 10 Apr 2002 12:01:34 -0400
Received: from [195.157.147.30] ([195.157.147.30]:49425 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S313264AbSDJQBd>; Wed, 10 Apr 2002 12:01:33 -0400
Date: Wed, 10 Apr 2002 17:03:41 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Update - Ramdisks and tmpfs problems
Message-ID: <20020410170341.L4493@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Geoffrey Gallaway <geoffeg@sin.sloth.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409144639.A14678@sin.sloth.org> <20020410102343.A31552@sin.sloth.org> <20020410155242.H4493@dev.sportingbet.com> <20020410110107.A2299@sin.sloth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 11:01:07AM -0400, Geoffrey Gallaway wrote:
> What kernel version are you using on those smp+multi tmpfs boxes? 

As of this morning, 2.5.7.  Before that 2.4.{17,18,19-pre*ac*} for some months.


> What
> hardware?

Dual pentium III (Katmai) 

sean@henry:~$ lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02)
00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 04)
00:09.1 Input device controller: Creative Labs SB Live! (rev 01)
00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)
00:0c.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100] (rev 06)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)

All scsi disks.  IDE cd-writer.  More-or-less redhat 7.x distro with most of
the interesting daemons replaced, and some legacy cruft still intact.

I don't use ACPI or devfs or framebuffer console, not that any of those should
affect this.

Sean

> 
> Geoffeg
> 
> This one time, at band camp, Sean Hunter wrote:
> > Just a data point:  I have been using multiple tmpfs bind mounts for some time
> > on smp without this problem.
> > 
> > none on /dev/shm type tmpfs (rw,nosuid,nodev,mode=1777,size=256M)
> > /dev/shm on /tmp type none (rw,bind)
> > /dev/shm on /usr/tmp type none (rw,bind)
> > 
> > Never had a reboot fail for this reason.
> > 
> > Sean
> > 
> > 
> > On Wed, Apr 10, 2002 at 10:23:43AM -0400, Geoffrey Gallaway wrote:
> > > I finally found the problem, which appears to be a combination of things:
> > > 
> > > Multiple tmpfs mounts and SMP.
> > > 
> > > I am using a Dual Intel PIII 1Ghz box. When I use a SMP kernel AND do
> > > multiple tmpfs mounts (mount --bind /dev/shm/etc /etc; mount --bind
> > > /dev/shm/var /var) the machine goes into a reset loop. HOWEVER, when I use a
> > > non-SMP kernel and still do multiple tmpfs mounts OR when I use a SMP kernel
> > > and do only one tmpfs mount, the machine boots fine. Every once in a while
> > > (1 out of 20 times?) the machine would boot fine with a SMP kernel and
> > > multiple tmpfs mounts. Is this a timing issue?
> > > 
> > > If I can help to nail down this (apparent) bug more, please let me know.
> > > 
> > > Thanks,
> > > Geoffeg
> > > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
