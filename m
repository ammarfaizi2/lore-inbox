Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSFUXJe>; Fri, 21 Jun 2002 19:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSFUXJd>; Fri, 21 Jun 2002 19:09:33 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:17734 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S315946AbSFUXJc>;
	Fri, 21 Jun 2002 19:09:32 -0400
Date: Sat, 22 Jun 2002 01:09:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tillman@viewcast.com (Scott Tillman),
       dalecki@evision-ventures.com (Martin Dalecki),
       B.Zolnierkiewicz@elka.pw.edu.pl (Bartlomiej Zolnierkiewicz),
       arcolin@arcoide.com (Garet Cammer), linux-kernel@vger.kernel.org
Subject: Re: Need IDE Taskfile Access
Message-ID: <20020621230929.GA18045@win.tue.nl>
References: <CBELJEJGBEIGHCIMEDHNCEPBCIAA.tillman@viewcast.com> <E17LX56-0001nL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17LX56-0001nL-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 11:40:40PM +0100, Alan Cox wrote:

> > I'm working with a group of people in an effort to get Linux running on the
> > XBox.  The XBox uses a set of security PIO commands to restrict access to
> > the IDE drive, requiring a 32 byte password to be delivered before sector
> > access is allowed.  As far as I can tell from my investigations and from
> > earlier discussions with Andre there is currently no way to issue this
> > command.  If I'm wrong in my estimation just let me know how, otherwise I
> > simply wish add my voice to the (albeit small) outcry for supporting the
> > entire ATA spec.
> 
> That would I suspect be something for the kerneli patch.

No. Don't be misled by the "password". Translated into driver language
the question just is: I have a vendor-unique command that must transport
data to the disk. How? And if it doesnt work today the possibility must
be added.

(Long ago I had various small programs that did vendor-unique things
to ata floppies, zip drives, large ide drives and the like.
Commands for doorlocking, for switching between removable disk / big floppy
mode, for reading and setting the native max address, etc.
Unfortunately some random patch that accompanied one of these programs
got into the official tree, so that we now have the HDIO_DRIVE_CMD ioctl.
It does do_cmd_ioctl(). But that was special purpose for setmax,
not general purpose, and it does not transport data to the disk.
We need a slightly more general interface. Maybe we do have it already,
I have not watched this closely.)

Andries
