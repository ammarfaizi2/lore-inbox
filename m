Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSBZOps>; Tue, 26 Feb 2002 09:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSBZOph>; Tue, 26 Feb 2002 09:45:37 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:22291 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S287862AbSBZOp2>; Tue, 26 Feb 2002 09:45:28 -0500
Message-ID: <3C7B9F29.1FFD6F71@loewe-komp.de>
Date: Tue, 26 Feb 2002 15:43:53 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16-e2compr i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, davej@suse.de,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: Oopses in scheduler on Linux-2.4.17-xfs
In-Reply-To: <E16Qerz-00070o-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox schrieb:
> 
> > I recently get oopses on 2.4.14-xfs and 2.4.17-xfs.
> > box is SMP with old Pentium Pro
> > There were some changes with erratas of the Pro ans something
> > with "cacheline alignment" and a fence.
> 
> Unrelated - in fact you have bugs before and after. The fixes in question
> were two sets
> 
> 1.      In certain bizarre situations the ppro violates store ordering. It
>         needs lock based spin_unlock to avoid that. Ditto locks to ensure
>         stores don't bypass stuff on pci_map interfaces. (This btw is the
>         same errata as the FENCE stuff in libglide is all about)
> 
> 2.      Certain address ranges must never be cached on the ppro due to an
>         errata. We broke that in two ways - if there was RAM there, and
>         if we mapped a card there and set MTRR's to write combine it.
> 

Perhaps you three remember my reports about crashes in the scheduler.

After I was able to fetch an Oops on 2.4.17 (without kdb) I noticed
this:

my bt848 didn't generate any interrupts (so videotext and epg didn't work
but TV worked)

In a last temptation I checked the BIOS and switched from MPP 1.4 to 1.1
And guess what? The box is running fine again for several weeks.

The BIOS was buggy before(different MTRR on CPUs) , I upgraded "years" ago.

I can't remember when I switched this entry in the BIOS.
Possibly there is a bug in the MPP tables (setup through BIOS) when set to 1.4?

Damn, never play with your BIOS settings if the box runs fine ... especially
if you forget that fact ;-)
