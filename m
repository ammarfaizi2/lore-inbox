Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313020AbSDCC6l>; Tue, 2 Apr 2002 21:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313026AbSDCC6c>; Tue, 2 Apr 2002 21:58:32 -0500
Received: from london.rubylane.com ([208.184.113.40]:60208 "HELO
	london.rubylane.com") by vger.kernel.org with SMTP
	id <S313018AbSDCC6V>; Tue, 2 Apr 2002 21:58:21 -0500
Message-ID: <20020403025820.4561.qmail@london.rubylane.com>
From: jim@rubylane.com
Subject: Re: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 2 Apr 2002 18:58:20 -0800 (PST)
Cc: jeff@aslab.com (Jeff Nguyen), xyzzy@speakeasy.org (Trent Piepho),
        alan@lxorguk.ukuu.org.uk (Alan Cox), jim@rubylane.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <E16sayv-00033A-00@the-village.bc.nu> from "Alan Cox" at Apr 03, 2002 03:58:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, I have Maxtor 5T060H6 UDMA100 drives connected as hda and hdc,
and this command will reliably trash both hda and hdc on a Supermicro
P3TDLE mobo using the built-in IDE ports:

mount /dev/hdc4 /mnt
cd /home (/dev/hda4)
tar -cf - *|tar -C /mnt -xpf -

Within seconds of hdc's light coming on, all kinds of filesystem
errors will occur, and then BOTH drives are corrupted.  This is one of
two different Supermicro P3TDLE mobos, both purchased in Nov 2001.  I
removed the Promise controllers completely to eliminate them as a
problem, and it still happens.  It happens with regular 2.2.19 and
2.2.20 with the Andre Hedrick's patches.

This board does claim to support UDMA33 and Linux says the MB IDE
ports are in UDMA33 mode.  Works fine in just PIO mode.  Slower, but
at least it doesn't trash drives.

One reason for posting this to the list is that it cost us 34 hours of
downtime of a production site, delayed a site upgrade for 4 months,
and took me several days of testing to narrow it down to crummy
motherboards.  If there is a tweak to say "don't ever do DMA on
Supermicro boards", at least on this one, I'd recommend it.  I never
tried putting two drives on ide0; that may work or may also trash
both drives.  And it never locked up our machine, although I think
it did panic once because of all the damage to the filesystem.

I can reliably duplicate this if anyone wants me to do some testing.
I have 2 dual-CPU test machines and 12 drives, so no shortage of 
hardware to beat on.

This board says:

ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0

Jim

> 
> > devices are the problem maker on OSB4. Unless DMA is disabled, the system
> > will lock up when accessing the drive.
> > 
> > If you have UDMA33 ATAPI devices, they work great in OSB4.
> 
> Except when they don't. There are definite problems with some specific
> combinations and ones I know are not one offs because we've seen them over
> an entire render farm for example.
> 
> The current driver panics and asks people to email me if it spots the UDMA
> disk corruption about to occur pattern. I get little mail but some
> 

