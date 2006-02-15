Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWBOCzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWBOCzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWBOCzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:55:09 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:37544
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750985AbWBOCzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:55:08 -0500
From: Rob Landley <rob@landley.net>
To: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 21:55:03 -0500
User-Agent: KMail/1.8.3
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602141751.02153.rob@landley.net> <20060215000420.GB21088@merlin.emma.line.org>
In-Reply-To: <20060215000420.GB21088@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200602142155.03407.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 7:04 pm, Matthias Andree wrote:
> On Tue, 14 Feb 2006, Rob Landley wrote:
> > With mkisofs I can just start from the spec, reverse engineer a few
> > existing ISOs, or grab the really old code from before Joerg got ahold of
> > it (back when it was still readable).  That's no problem.  But for
> > cdrecord, I can't find documentation on what the kernel expects.
>
> That's mostly the sg <http://sg.torque.net/sg/p/sg_v3_ho.html> interface
> that matters, and of that mostly the open and SG_IO parts. cdrecord is
> severely bound to talking SCSI.

Cool.  Thanks.

> > I'm only interested in supporting ATA cd burners under a 2.6 or newer
> > kernel, using the DMA method.  (SCSI is dead, I honestly don't care.)
>
> SCSI being dead for writing is actually a pity because SCSI was all in
> all so much smoother. More devices on the same cable (which was a real
> bus), no hassles with b0rked "IDE" interfaces that only work for hard
> disks but not ATAPI devices and more. Everything SCSI has had for more
> than a decade is slowly retrofitted into ATA(PI), removed if not good
> enough (TCQ), and reinvented (NCQ) when in fact SCSI had it right for
> aeons.

My tagline, "Never bet against the cheap plastic solution", has been a saying 
of mine for many years.

That said, ATA is as much IDE as PCI is ISA.  And SATA is neither, it's 
gigabit eithernet.  (The gigabit ethernet guys had a really hard problem 
blasting high speed data over the cheap copper wire already in the walls, but 
once the MII transceiver was replaced with the PHY and they started shipping 
in volume and became cheap and reliable, it made sense to use it everywhere.  
Do you hook up peripherals with gigabit ethernet?  USB2 is based on the PHY 
chip.  Hook up hard drives with gigabit ethernet?  SATA and SAS are based on 
PHYs.  And it makes a certain amount of sense that when speeds get high 
enough clocking the hell out of a single wire is easier than keeping 80 of 
them exactly in sync.  The only reason they can keep the hundreds of pins on 
a modern CPU in sync is the signal only travels about three inches, and even 
then it's not _easy_...)

The last gasp of the SCSI bigots is Serial Attached Scsi.  It's hilarious.  
Electrically it's identical (they just gold-plate the connectors and such so 
they can charge more for it).  The giveaway is that you can plug a SATA drive 
into a SAS controller and it works on "dual standard" controller firmware.  
Which one's going to have the unit volume to be cheap and sell through its 
inventory to bring out new generations faster?  And which one is exactly the 
same technology with buckets of hype, slightly different firmware, and a huge 
markup for the people who still think that because ISA sucked, its designated 
successor PCI can't be trusted?

Buying the exact same technology for way more money, based on a two-decade old 
bias in an industry where a given generation of hardware becomes obsolete 
every 3 years.  Funny to me, anyway...

> The good thing is ATAPI via ide-cd vs. SCSI does not matter any more,
> and SCSI vs. parallel matters very little (but that's just as dead as
> SCSI for CD writing). If you don't care to enumerate devices or obtain
> b,t,l, you just take the device name, open it and do some sanity checks
> to see if you're talking to a CD-ROM.

Yup.  They specify the device node they want to talk to on the command line.  
Finding it is not my problem. :)

(And the enumerating the cd burner built into my laptop ain't brain surgery.)

> The downside is, and here an abstraction layer has a point, just this
> simple won't be portable. SG_IO is Linux-specific.

I'm entirely ok with that. :)

> Jörg's complaints about ide-cd being different, layer violations and
> else are entirely artificially constructed complaints, at least he
> hasn't been able to document real bugs in ide-cd in the course of this
> thread, but holding on to ide-scsi which is known to have severe bugs.
> He was under some miscomprehension of the Linux internals and split
> ATA: and SCSI namespaces and added some more artificial complaints about
> non-existent problems.

Back around 2000 I noticed that the README for cdrecord contained prominent 
warnings about bugs the Linux kernel had fixed literally years earlier, and 
tried to play them up as fundamental design flaws.  But a few paragraphs 
later it treated workarounds for then-current Solaris bugs as a trivial 
matter of course, an inline "do this next" in the step by step instructions.

Easy to spot the bias.  Everybody's got something.  (My bias is towards cheap 
plastic solutions.  I'm the kind of guy who would turn a linksys router into 
a heart monitor.  I probably wouldn't _deploy_ it, but when somebody uses a 
$100,000 piece of computing equipement to do _anything_ I wince and wonder 
how to make a 3 year old laptop accomplish the same thing...)

Time will take care of Solaris.  Currently it seems to be making all its money 
due to the fact that government contracts can only charge 10% over the cost 
of their components, so big government contractors use the most expensive 
stuff they can find (and never re-use anything) to make that 10% as big as 
humanly possible.  Use Linux in an aircraft carrier and you get a 10% markup 
on $100.  Use Solaris in the same aircraft carrier and you get a 10% markup 
on whatever insanely inflated figure Sun cares to charge...

The law of unintended consequences is alive and well...

> > I was hoping I could just open the /dev/cdrom and call the appropriate
> > ioctls on it, but reading the cdrecord source proved enough of an
> > exercise in masochism that I always give up after the first hour and
> > put it back on the todo list.
>
> Perhaps reading a late MMC draft from t10.org is more useful as a
> starting point, if you want the real thing, you'll have to get an
> official standard. And perhaps retrofitting CD support into growisofs
> (from the dvd+rw-tools) might be another idea.

Could be...

> > I suppose I should say "screw the source code" and just run the cdrecord
> > binary under strace to see what it's doing,
>
> You'd have to enable strace to actually unravel SG_IO contents, else
> you're only getting a useless pointer - unless you trust cdrecord -V.

*shrug*  Or stick printfs in the source code.  Coasters are cheap and cd 
rewriteables last a while if you don't scratch them up...

> > * How bad?  Random example of ignoring how the rest of the world works is
> > that it runs autoconf from within make, meaning there's no obvious way to
> > specify "./configure --prefix=/mypath", so the last time I played with it
> > (which was a while ago), I wound up doing this:
>
> To be fair, installation into specific paths is documented in 2.01 and
> newer alphas. Quoting INSTALL, section "Using a different installation
> directory[...]":
>
>   "If your make program supports to propagate make macros to sub make
>   programs which is the case for recent smake releases as well as for a
>   recent gnumake:
>
>         smake INS_BASE=/usr/local install
>   or
>         gmake INS_BASE=/usr/local install"

I was doing this several years ago.  I upgraded my build _to_ 2.00.3 from some 
a 1.?? version. A quick glance at the INSTALL file from the 2.00.3 tarball I 
have in my backup pile brings up this entirely typical segment:

        You **need** either my "smake" program, the SunPRO make
        from /usr/bin/make (SunOS 4.x) or /usr/ccs/bin/make (SunOS 5.x)
        or GNU make to compile this program. Read README.gmake for
        more information on gmake and a list of the most annoying bugs in
        gmake.

        All other make programs are either not smart enough or have bugs.

        My "smake" source is at:

        ftp://ftp.berlios.de/pub/smake/alpha/

        It is easy to compile and doesn't need a working make program
        on your machine. If you don't have a working "make" program on the
        machine where you like to compile "smake" read the file "BOOTSTRAP".

        If you have the choice between all three make programs, the
        preference would be

                1)      smake           (preferred)
                2)      SunPRO make
                3)      GNU make        (this is the last resort)

        Important notice: "smake" that comes with SGI/IRIX will not work!!!
        This is not the Schily "smake" but a dumb make program from SGI.

        ***** If you are on a platform that is not yet known by the      *****
        ***** Schily makefilesystem you cannot use GNU make.             *****
        ***** In this case, the automake features of smake are required. *****

And yes, that _is_ entirely typical...

Rob
-- 
Never bet against the cheap plastic solution.
