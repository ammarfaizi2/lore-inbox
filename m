Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWA0Qhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWA0Qhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWA0Qhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:37:51 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:17942 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751516AbWA0Qhu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:37:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MG0WbZl+MHMqL+/8Tm3fnuf3EkZxF+wyKGAFBTthZoV0z+zLOMJKCRfj160l1RwVu9EMF/ZY0G5XZjZHDEX396NkY9c8BMC2V7ynfY93V7NityJFUsoz7OdmXJpKMmjfy8LJtPL0XweOmy5McRcysse4G+wC+A5WSV5rANMupF4=
Message-ID: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
Date: Fri, 27 Jan 2006 17:37:48 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm stealing thread in hope of stopping flamewar
and finally having some useful discussion.

I address this to everybody not only to Joerg:

[*] As this is my thread now discussing SG_IO on /dev/hd* vs /dev/sg*
is BANNED.  Please continue discussing this in the old thread. :-)

I'm sure thare are other important things that we can agree on.

If it doesn't work it will be my first and the last mail in this thread...

On 1/27/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> > > The only integrative (and this useful for libscg) interface on Linux is /dev/sg*
> > >
> > > /dev/hd* may look nice if you only look skin-deep
> > >
> > > How do you e.g. like send SCSI commands to ATAPI tape drives on Linux?
> >
> > I see you asking this again and again, and you seem to want to hear this
> > answer: "You don't." I haven't checked the code, but I guess the SG_IO
> > interface isn't available there. And I don't think this is a problem,
> > because a) if it was needed, it can be added trivially with minimum
> > added code, b) ATAPI tapes are dead, much the way ATAPI floppies are.
>
> Nice to see that agree that sending SCSI via /dev/hd* is a hack with limited
> benefit.
>
> Maybe (now that we did agree about the way to go) it makes sense to start
> discussing which bugs in Linux need to be fixed in order to close e.g.
> the Bugs in the Debian bug tracking system for cdrtools that are related to the
> Linux kernel.

Yes, lets talk about other problems, do you have pointers bugs handy?
I'm not very familiar with Debian bug tracking system and I see there
more than 3 bugs for cdrtools.

> This are the three most important Linux kernel bugs:
>
> -       ide-scsi does not do DMA if the DMAsize is not a multiple of 512
>         A person who knows internal Linux structures shoule be able
>         to fix this (and allow any multiple of 4) in less than one hour.

I'll take a look, it should be quite easy
and I don't see a reason for this restriction.

>         If we sum up the time spend on this discussoion, I really cannot
>         understand why this has not been fixed earlier.

Because nobody cared and flamewaring is easy in contrast
to doing some real work.

> -       /dev/hd* artificially prevents the ioctls SCSI_IOCTL_GET_IDLUN
>         SCSI_IOCTL_GET_BUS_NUMBER from returning useful values.
>         As long as this bug is present, there is no way to see SG_IO
>         via /dev/hd* as integral part of the Linux SCSI transport concept.

What are the return values of SCSI_IOCTL_GET_IDLUN
and SCSI_IOCTL_GET_BUS_NUMBER needed for?

Please elaborate as:

* SG_IO ioctl doesn't require lun and bus number for arguments
* sg_io_hdr_t also doesn't contain/require these fields

so I simply cannot see why they are needed by kernel.

If lun and bus number are needed by cdrecord please explain why
(if only for enumerating devices sorry but see [*]).

> -       If sending SCSI sia ATAPI, Linux under certain unknown conditions
>         bastardizes the content of SCSI commands. A possible reason may be

Sorry but I can't do much about it without knowing more details.

Please provide some way to reproduce the problem
("certain unknown conditions" is not very useful).

>         that it sends random data in the remainder between the actual
>         SCSI cdb size and the ATAPI SCSI cdb size.

It should send 0-s but I'll recheck this.

>         ATAPI drives that verify SCSI cdb's for correctness fail in this
>         case.

Thanks,
Bartlomiej
