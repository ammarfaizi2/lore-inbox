Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263237AbTCYSVk>; Tue, 25 Mar 2003 13:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbTCYSVk>; Tue, 25 Mar 2003 13:21:40 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:42936 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S263237AbTCYSVh>;
	Tue, 25 Mar 2003 13:21:37 -0500
Date: Tue, 25 Mar 2003 19:32:45 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared IRQs
Message-ID: <20030325193245.A28599@fi.muni.cz>
References: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org> <1048124539.647.18.camel@irongate.swansea.linux.org.uk> <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org>; from wolfram@schlich.org on Thu, Mar 20, 2003 at 08:22:59AM +0100
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Schlich wrote:
: > However there is another known problem that does cause deadlocks with
: > the AMD76x, especially if the onboard IDE is used. Shove a PS/2 mouse
: > in the box, reboot and retest - if you dont already have one
: 
: ?! I'm using the onboard IDE for two CDROM drives and one smaller
: hard disk which I use rarely... and I didn't use any of these devices
: in the cases in which I had the described problems... Anyway, why should I
: connect a PS/2 mouse to the machine? Is it gonna solve all my
: problems at once? ;-)

	I had a similar problem which has been solved by plugging
in a PS/2 mouse. So far I've got about 10 reports from people where
the PS/2 mouse solved the problem. It seems it is limited only to
the revision 04 of AMD 768 southbridge, and especially the MSI K7D-Master
boards. My lspci looks like this:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04)
[...]

	It is even somewhat documented as an official AMD erratum.

	This is not a dead-lock per se - but rather a hard lock-up
of the box (the system is totally locked up, even pressing NumLock does
not light the NumLock LED on the keyboard).

	However: I also have occasional (less than 1 per week) dead-locks
on this box related probably to NFS or ext3 or NFS-lockd - the system is
OK, only all nfsd and lockd processes are stuck in the "D" state,
sometimes there is also an "exportfs -a" process in the "D" state
(my /etc/exports is generated from database, and I run exportfs
every two hours or so). And I think it is SMP-related, not necessarily
AMD-related. These deadlocks are more often in 2.4.21-pre kernels
than in vanilla 2.4.20. See my previous posts to LKML on this topic as well.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
