Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263403AbTC2Ljw>; Sat, 29 Mar 2003 06:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbTC2Ljw>; Sat, 29 Mar 2003 06:39:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36103
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263403AbTC2Ljv>; Sat, 29 Mar 2003 06:39:51 -0500
Date: Sat, 29 Mar 2003 03:34:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeremy Jackson <jerj@coplanar.net>
cc: Ron House <house@usq.edu.au>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hdparm and removable IDE?
In-Reply-To: <1048860279.1615.13.camel@contact.skynet.coplanar.net>
Message-ID: <Pine.LNX.4.10.10303290318330.4415-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Mar 2003, Jeremy Jackson wrote:

> > As an aside, I am puzzled by statements that Linux `doesn't support' 
> > this. As far as I can see (and I acknowledge my relative ignorance, 
> > which is why I have appealed for help here), whatever is done at boot 

Nope, there are BIOS INT19 hooks that have some voodoo.
Until the driver can open and read the BIOS on the HBA, no can do.

> > time can be done again later if conditions change, and it should be just 
> > a matter of my ascertaining exactly what must be done to achieve this. 
> > Or have I missed something very important (highly possible!)?
> 
> What can be done at boot... correct.  However, the BIOS does part of the
> BOOT init, the linux kerenel IDE driver does some more.  So changing the
> drive without rebooting through BIOS can be a problem.  The PIO modes
> are the issue here.  Perhaps a script can do hdparm -X somehow, but
> nobody is certain if it will be reliable, because who knows what the
> bios does.  With LinuxBIOS there is hope though.

LOL, LinuxBIOS can not even get POST on execute diagnostics correct.
It violently nukes the state machine requirements of a 31 seconds.
This is another war and I really do not give a damn to fight, when nobody
listens or bothers to read the freaking spec.  Anybody got a copy of the
Phoenix BIOS book to see how the old hats did it?

> IMHO the ide driver is a real mess.  statically allocated structures,
> because the kernel command line parameters have to be read early because

Sure kill all the legacy stuff and split the driver.

If you are wanking so hard on the setup, take and export all the setup to
their respective modules (ie hba's).  As for the static structs, I pushed
to have dynamic major/minor allocations but got dive bombed with a flock
of sea gulls.

> they're so wierd, no wonder the hdparm -U / -R stuff is busted.  It
> should take the PCI ID of the interface, not the io ports.  Fixing this
> is on my hit list, in about a month.

I just love how everyone thinks it is so easy, how I made such a freaking
mess of the driver.  Well you all can dork with it and I will wander off
and intergrate the chipset cores.  The only reason it is even close to
becoming clean is because the core transport layer for the state machine
was ripped appart and started from the ground up.

Hell, just ask and I will turn the whole transport into as SCSI wrapper
and we can root wad the directory.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

