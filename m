Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318004AbSGLUHQ>; Fri, 12 Jul 2002 16:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318005AbSGLUHO>; Fri, 12 Jul 2002 16:07:14 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55818
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318004AbSGLUGa> convert rfc822-to-8bit; Fri, 12 Jul 2002 16:06:30 -0400
Date: Fri, 12 Jul 2002 13:06:26 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207121937.g6CJb1aq018419@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.10.10207121240280.20499-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joerg

Don't take this personally but you are just a top level application.
The only reason you have such blinders on is because you always had a
bottom layer transport working around and doing its best to prevent
errors form showing up.  You are wrong and because you are not down on the
bus at the physical layer you do see the mess.

Now your silly PCATA stupid ass Tailgate Bridge that you are boasting
about does some of the worst things anyone could ever imagine.

Oh and the bad idea you call is to permit dynamic subdriver shifting.
Now that it may never be completed you have the advantage to call it a bad
idea.  I suspect you are an ASPI lover and soone SPI will die.

Next your statements about name a drive is a straw man.
More basic proof you do not look down at the hardware.

BurnProof is a result lame devices which improperly hold off the bus
because release the BUSY Bit while still performing transfers.
The very fact that a huge pile of devices went into the market place
based on SFF-8020 rev 2.5 total roasts your strawman, please try again.

Also you blanket term is incorrect to say all CDRW/ROMs fall back to ATA
transport.  You can not obtain any data other than identify and even it
as a special command which will not work on ATA devices.

There is a single command for ATAPI devices called PACKET_COMMAND.
Also all ATA devices shall issue an abort should it recieve the command.

As for ide-cd being banded, if you had ever attempted to support a direct
access cdb packet driver by not restricting cdrecord to only a SG
interface we would have solved the problem a long time ago too.

So neer neer neer and that leaves us at the same point.

So instead of whining about what is there and not from your location in
end user land, try and offer something useful like a preferred API to
allow clean packet-driver interfaces.  Doing that little would allow the
transport layer people and the transistion-api folks to user land to
greatly increase compatablity.  Then you would not need 5 interfaces for
Linux.

Have a good day.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 12 Jul 2002, Joerg Schilling wrote:

> >Alan Cox wrote:
> 
> >> Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
> >> and treat all ATAPI devices as what they really are -- SCSI over IDE.
> 
> >They aren't.
> 
> Please don't start again to tell onprooven statements....
> We had a similar discussion in January 2001 and you did not give a proove
> for this statement.
> 
> 
> >o       Not all ide cdrom devices are ATAPI capable
> 
> Name one drive made after 1993, one drive made after 1995 and one drive made 
> after 2000 to verify your statement.
> 
> >o       Many ide floppy devices can do ATAPI but get it horribly wrong
> 
> Describe the problems.
> 
> >o       ide-tape is -totally- weird and unrelated to st
> 
> Describe problems and name drives that will not work via ATAPI.
> 
> >Andre did the framework ready to move to a situation where you could open
> >either the ide-scsi or the ide-cdrom name without module reloading mess.
> >You'd need to ask our new 2.5 IDE maintainer to finish that work off.
> 
> This is a really bad idea!
> 
> The result of such bad hacks is that nobody really tests whether the new
> code works.
> 
> Let me give an example:
> 
> If you try to put ide-scsi on top of PCATA (the interface that is used
> in notebooks to connect external disks and CD-writers).
> 
> Depending on the kernel version, this either causes a system panic or
> just does not work at all. As all ATAPI CD-writers and CD-rom drives
> have a fallback to ATA commands, nobody who does not like to use a writer
> will ever notice the problem. They simply access the CD-ROM as read only
> ATA disk. If ide-cd would have been banned this bug would have been fixed years 
> ago.
> 
> >For disk it gets much easier. Linus has already said he wants a single
> >'disk' device, which once we get 32bit dev_t will be nice. With that we
> >can finally turn aacraid, megaraid and other 'fake scsi' devices back to
> >raw block devices without breaking compatibility assumptions, and get more
> >throughput.
> 
> 
> Sorry, this has nothing to do with dev_t
> 
> Jörg
> 
>  EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
>        js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
>        schilling@fokus.gmd.de		(work) chars I am J"org Schilling
>  URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

