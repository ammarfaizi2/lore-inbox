Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129089AbQKBSqs>; Thu, 2 Nov 2000 13:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129188AbQKBSqh>; Thu, 2 Nov 2000 13:46:37 -0500
Received: from fairway.oup.co.uk ([194.80.1.20]:33428 "EHLO fairway.oup.co.uk")
	by vger.kernel.org with ESMTP id <S129089AbQKBSq0>;
	Thu, 2 Nov 2000 13:46:26 -0500
Message-ID: <A528EB7F25A2D111838100A0C9A6E5EF068A1DCA@exc01.oup.co.uk>
From: "CRADOCK, Christopher" <cradockc@oup.co.uk>
To: "'M.H.VanLeeuwen'" <vanl@megsinet.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux-2.4.0-test10
Date: Thu, 2 Nov 2000 18:46:20 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin, my setup is a Gigabyte DX (ie BX chip set with dual Pentium III) I
have an ATI rage 128 in it with two soundblasters and a cheapo ne2k clone.

The ISAPNP doesn't auto config completely for me so all I can say is the
plug-and-pray would still cause me some grief. Basically the ne2k and the
second sound blaster have conflicting requirements, so I manually tweaked
the ISAPNP selection until it worked. It appears the sound blasters don't
work on half the combination of interrupt and IO ports that you could chose
and that the PNP listing claims are available.

I've never had a problem with or without the FB in place (except initially
when aty128fb.c was flaky) Although it runs X about ten times slower than
the XFree V4 direct driver so I don't normally touch it.

The problems with the PIIX4 simply cause my HDA disk to hang up until the
reset pokes it back into action. As the root partition is on hda1 it hangs
the machine waiting for this to happen (takes about 15 minutes).

ETH0 - thinking about it to does occasionally hang up on me but I thought
that was me fiddling with the settings too much. I'll try that again.

As for kernel debug points I can't say I do my debugging that way.

Chris.

> -----Original Message-----
> From:	M.H.VanLeeuwen [SMTP:vanl@megsinet.net]
> Sent:	Thursday, November 02, 2000 12:44 AM
> To:	CRADOCK, Christopher
> Cc:	linux-kernel@vger.kernel.org; torvalds@transmeta.com
> Subject:	Re: Linux-2.4.0-test10
> 
> "CRADOCK, Christopher" wrote:
> > 
> > I have a similar hardware list and I don't observe any of these problems
> on
> > 2.4.0-test10x. Is it possibly a hardware conflict somewhere?
> > 
> > What I do see occasionally is if X was ever heavy on the memory usage
> (say
> > I've run GIMP for a couple of hours) then the text console's font set
> gets
> > trashed until the next reboot. Console driver failing to reset
> something?
> > 
> > Chris Cradock
> > 
> 
> Hi Chris
> 
> Never had the trashed fonts before.
> 
> How about a better comparison of systems?
> All I mentioned were r128, ne2k, PIIX4 and SMP,  barely enough to claim
> similar
> hardware thus these aren't real problems cause you don't see them.
> I can send you gory details if your interested.
> 
> My reason for claiming these are problems, maybe not show stoppers, are:
> 
> This system is rock solid on 2.2.X.
> 
> problem 1, shouldn't fail on 2.4 if it works just fine on 2.2.  Probably a
> locking
> issue but I'm not sure.  Any idea where to put some BKL's to see if the
> problem
> will go away?
> 
> problem 2, happens randomly, so is it a hardware problem or a software
> issue?  being
> that the system works fine SMP and UP then my guess is a software
> interaction when
> UP-APIC is enabled, a race condition??
> 
> problem 3, new feature in 2.4, one would expect, hey, I've got this hdwr
> in my system,
> let me enable this option...  wait a minute the system doesn't boot...
> 
> problem 4, ISAPNP in the kernel is new for 2.4, i was pointing out that it
> can be
> improved to make it better able to select IRQ's that work so that the user
> can just
> upgrade to 2.4 without having to tweak the BIOS and/or the code.  I sent a
> patch to
> Linus but he rejected it, yes I realize it was a weak attempt but it fixed
> my ISAPNP
> problems, and no one has proposed a better solution.  Shouldn't the
> first release of 2.4.0 show that it's new capabilities are ready for prime
> time?
> 
> 
> Thanks,
> Martin
> 
> 
> > 1.  kernel compiled w/o FB support.  When attempting to switch
> >     back to X from VC1-6 system locks hard for SMP.  Nada thing
> >     fixes this except hard reset... no Alt-SysRq-B, nothing
> >     DRI not enabled.  Video card has r128 chipset.
> >  
> > 2.  System is a NFS root machine, after a period of heavy ntwk
> >     activity, eg. "make clean" in /usr/src/linux ETH0 no longer
> >     works or sometimes just ntwk activity during system boot is
> >     enough to cause the ETH activity to cease.
> >     The only recourse is to Alt-SysRq-B the system.
> >     NIC = NE2K ISA
> >  
> > 3. Enabling PIIX4, kernel locks hard when printing the partition
> >    tables for hdc.   hdc has no partitions.
> >    I think this problem is on Ted's problem list???
> >  
> > 4. ISAPNP assigns an invalid/unusable IRQ to NE2K NIC card.
> >    Previously reported to Linus & Ingo, they asked for an MPTABLE
> >    dump, haven't heard back since providing said data.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
