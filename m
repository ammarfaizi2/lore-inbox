Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbUKTW1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUKTW1r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 17:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUKTW1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 17:27:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:1946 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261407AbUKTW1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 17:27:44 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1100937706.3497.11.camel@mhcln03>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03>
	 <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
	 <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
	 <1100921760.3561.1.camel@mhcln03>  <1100936059.5238.3.camel@gaston>
	 <1100937706.3497.11.camel@mhcln03>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 09:27:17 +1100
Message-Id: <1100989638.3796.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 09:01 +0100, Matthias Hentges wrote:
> Am Samstag, den 20.11.2004, 18:34 +1100 schrieb Benjamin Herrenschmidt:
> > On Sat, 2004-11-20 at 04:36 +0100, Matthias Hentges wrote:
> > > Am Samstag, den 20.11.2004, 02:43 +0000 schrieb Matthew Garrett:
> > > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > > 
> 
> [...]
> 
> > > Trying to resume with radeonfb or X (DRI or fglrx) causes the machine
> > > to freeze upon a resume.
> > 
> > At what point does it freeze ? Is the display back before the freeze ?
> 
> Sadly the video *never* comes back and stays dark no matter what I try:
> - boot-radeon (int10 POST call) doesn't work. Either it segfaults or 
>   it hangs the machine
> - Any combination of radeontool light on|off doesn't help (no freeze,
> sometimes it 
>   can't read the cards mem address??)
> - The int10 radeon patch for X11 doesn't help (freeze)
> - radeonfb and / or X (either patched w/ int10 or not) freeze the
> machine
> 
> I'm running out of ideas with this darn thing.
> Since the serial port doesn't come back from S3 either, even a serial
> console is of no help.
> 
> I have attached the output of lspci -vvv before and after resuming from
> S3
> The latter shows lots of "[disabled]" entries. Is that of any use?

Difficult to say at this point, the [disabled] thing are easy fixed with
a pci_enable_device(). Unfortunately, on some machines, the firmware
sort-of expects the kenrel driver to reboot the card from scratch...

Ben.


