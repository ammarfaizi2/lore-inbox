Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbVCDXwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbVCDXwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbVCDXth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:49:37 -0500
Received: from bender.bawue.de ([193.7.176.20]:39558 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263089AbVCDWc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:32:27 -0500
Date: Fri, 4 Mar 2005 23:32:22 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] libata-dev queue updated
Message-ID: <20050304223222.GA10815@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <422641AF.8070309@pobox.com> <20050303193229.GA10265@sommrey.de> <4227DF76.3030401@pobox.com> <20050304063717.GA12203@sommrey.de> <422809D6.5090909@pobox.com> <20050304174956.GA10971@sommrey.de> <4228A3D4.8050906@pobox.com> <20050304203330.GA14557@sommrey.de> <4228C87A.8080205@pobox.com> <20050304220623.GA11867@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304220623.GA11867@sommrey.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:06:23PM +0100, Joerg Sommrey wrote:
> On Fri, Mar 04, 2005 at 03:43:38PM -0500, Jeff Garzik wrote:
> > Joerg Sommrey wrote:
> > >On Fri, Mar 04, 2005 at 01:07:16PM -0500, Jeff Garzik wrote:
> > >
> > >>Joerg Sommrey wrote:
> > >>
> > >>>On Fri, Mar 04, 2005 at 02:10:14AM -0500, Jeff Garzik wrote:
> > >>>
> > >>>
> > >>>>Joerg Sommrey wrote:
> > >>>>
> > >>>>
> > >>>>>On Thu, Mar 03, 2005 at 11:09:26PM -0500, Jeff Garzik wrote:
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>>Joerg Sommrey wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>>On Wed, Mar 02, 2005 at 05:43:59PM -0500, Jeff Garzik wrote:
> > >>>>>>>
> > >>>>>>>
> > >>>>>>>
> > >>>>>>>
> > >>>>>>>>Joerg Sommrey wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>>Jeff Garzik wrote:
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>>Patch:
> > >>>>>>>>>>http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc5-bk4-libata-dev1.patch.bz2
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>Still not usable here.  The same errors as before when backing up:
> > >>>>>>>>
> > >>>>>>>>Please try 2.6.11 without any patches.
> > >>>>>>>
> > >>>>>>>Plain 2.6.11 doesn't work either.  All of 2.6.10-ac11, 2.6.11-rc5,
> > >>>>>>>2.6.11-rc5 + 2.6.11-rc5-bk4-libata-dev1.patch and 2.6.11 fail with 
> > >>>>>>>the
> > >>>>>>>same symptoms. 
> > >>>>>>>
> > >>>>>>>Reverting to stable 2.6.10-ac8 :-)
> > >>>>>>
> > >>>>>>Does reverting the attached patch in 2.6.11 (apply with patch -R) fix 
> > >>>>>>things?
> > >>>>>>
> > >>>>>
> > >>>>>
> > >>>>>Still the same with this patch reverted.
> > >>>>
> > >>>>Does reverting the attached patch in 2.6.11 fix things?  (apply with 
> > >>>>patch -R)
> > >>>>
> > >>>>This patch reverts the entire libata back to 2.6.10.
> > >>>>
> > >>>
> > >>>I'm confused.  Still the same with everything reverted.  What shall I do
> > >>>now?
> > >>
> > >>Well, first, thanks for your patience in narrowing this down.
> > >>
> > >>This means we have eliminated libata as a problem source, but we still 
> > >>have the rest of the kernel go to through :)
> > >>
> > >>Try disabling ACPI with 'acpi=off' or 'pci=biosirq' to see if that fixes 
> > >>things.
> > >>
> > >
> > >I tried both settings with plain 2.6.11. Almost the same results, in my
> > >impression apci=off causes the failure to appear even faster.
> > 
> > Just to make sure I have things right, please tell me if this is correct:
> > 
> > * 2.6.10 vanilla works
> > 
> > * 2.6.11 vanilla does not work
> > 
> > * 2.6.11 vanilla + 2.6.10 libata does not work
> >   [2.6.10 libata == reverting all libata changes]
> > 
> > Is that all correct?
> 
> Thanks for asking these precise questions.  After double-checking
> everything I found a typo in my configuration that changes things a bit.
> I repeated some tests and the correct answers are now:
> * 2.6.10 vanilla		works
> * 2.6.10-ac8			works
> * 2.6.10-ac11			does not work
> * 2.6.11 vanilla		does not work
> * 2.6.11 w/o promise.patch	does not work
> * 2.6.11 + 2.6.10 libata	works!
> 
> This looks much more consistent to me but brings the case back to
> libata.

After one more test using 2.6.11 + 2.6.10 libata I got some errors.
They are different, they end after some time and they don't lock the system:

Mar  4 23:15:00 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }Mar  4 23:15:00 bear kernel: sdb: Current: sense key: Recovered Error
Mar  4 23:15:00 bear kernel:     ASC=0x26 <<vendor>> ASCQ=0xc0
Mar  4 23:15:00 bear kernel: FMK, ILI

Got 1900 of these in 90 seconds and silence afterwards.  Maybe that
helps. I'll keep this kernel running and watch it.

-jo

-- 
-rw-r--r--  1 jo users 63 2005-03-04 23:12 /home/jo/.signature
