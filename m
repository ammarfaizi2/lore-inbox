Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268487AbTB1XQZ>; Fri, 28 Feb 2003 18:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268493AbTB1XQZ>; Fri, 28 Feb 2003 18:16:25 -0500
Received: from daimi.au.dk ([130.225.16.1]:58536 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S268487AbTB1XQV>;
	Fri, 28 Feb 2003 18:16:21 -0500
Message-ID: <3E5FF026.F892B2F7@daimi.au.dk>
Date: Sat, 01 Mar 2003 00:26:30 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>,
       linux-kernel@vger.kernel.org,
       Herbert Rosmanith <herp@wildsau.idv.uni.linz.at>
Subject: Re: emm386 hangs when booting from linux
References: <200302280318.h1S3IoxM008387@wildsau.idv.uni.linz.at> <Pine.LNX.3.95.1030228174739.13518A-100000@chaos>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 28 Feb 2003, H.Rosmanith (Kernel Mailing List) wrote:
> 
> >
> > hello,
> >
> > for some reason, I am using the "switch to 16 bit realmode" function
> > present in the linux kernel to execute various 16bit code. One thing
> > that I am doing is to read the mbr off a harddisk to 0x7c00 and then
> > jump to there. This allows to e.g. "quickboot dos" from linux without
> > having to go through bios startup.
> >
> > I got this working with *one* exception: as soon as I load emm386
> > in config.sys, the system hangs. It doesn't hang completely, e.g.
> > the num-lock led changes light when pressing num-lock, and ctrlaltdel
> > reboots the system. When I "REM"ark the emm386.exe, then dos will
> > boot and display a "C:\>" prompt.
> 
> So you are trying a "home-brew" DOS-EMU which already exists and works
> well.

No, that was not what he wrote. Try reading it again. There is
nothing being emulated there.

> emm386.exe attempts to go to protected mode. That's how it works.

Yes.

> That's how it's able to make "high-RAM" appear in "low-RAM" windows
> for the emm386 specification. Of course it will fail when you
> are in virtual 386 mode.

First of all IIRC emm will fail before it attempts to enter
protected mode. It will use some status function to read the
current mode and if it finds the CPU in vm86 mode, emm plain
refuses to work. (Insert appropriate rant about vm86 design
here.) But in this particular case the CPU is not in vm86
mode, but rather in real mode. Loading emm should work.

> The real DOS-EMU emulates the extended/expanded
> memory specification so you don't need this in 'config.sys'. I sometimes
> boot real DOS usinf DOS-EMU and it works fine. You need to configure
> it so it will look at, say config.emu, instead of the DOS config.sys.
> That way, you can keep boot-specific configuration files.

But an emulator is not always usable as a replacement for a
real DOS. There are some things you cannot do under the
emulation.

Booting DOS from Linux is not as easy as booting Linux from
DOS. DOS relies much more on the BIOS, and the state of the
computer as it is setup by the BIOS. What needs to be right
for DOS to work is the contents of the BIOS data areas of
RAM, and the interrupt vector table, and state of some of
the hardware.

It is surprising it worked that well. You can't even boot
DOS from DOS, DOS will have changed interrupt vectors which
would cause a second DOS to fail. If Linux is booted from
LOADLIN there will already be messed enough with the
interrupt vector table, that there is no hope of returning
to real mode and have a usable BIOS. Linux will AFAIK not
touch the interrupt vector table, but you need a loader,
that operates early enough and doesn't change them either.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
