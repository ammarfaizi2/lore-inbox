Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWAaOPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWAaOPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 09:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWAaOPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 09:15:47 -0500
Received: from spirit.analogic.com ([204.178.40.4]:24329 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750885AbWAaOPq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 09:15:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060130.174705.15703464.davem@davemloft.net>
X-OriginalArrivalTime: 31 Jan 2006 14:15:44.0380 (UTC) FILETIME=[D2F063C0:01C62670]
Content-class: urn:content-classes:message
Subject: Re: CD writing in future Linux try #2
Date: Tue, 31 Jan 2006 09:15:38 -0500
Message-ID: <Pine.LNX.4.61.0601310914550.7787@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CD writing in future Linux try #2
Thread-Index: AcYmcNL52I+Ws/eiRRSXe8c7PLf4wQ==
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com><43DCA097.nailGPD11GI11@burner><200601302043.56615.diablod3@gmail.com> <20060130.174705.15703464.davem@davemloft.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <diablod3@gmail.com>, <schilling@fokus.fraunhofer.de>,
       <bzolnier@gmail.com>, <mrmacman_g4@mac.com>, <matthias.andree@gmx.de>,
       <linux-kernel@vger.kernel.org>, <acahalan@gmail.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2006, David S. Miller wrote:

> From: Patrick McFarland <diablod3@gmail.com>
> Date: Mon, 30 Jan 2006 20:43:55 -0500
>
>> I believe LKML is for serious discussion of Linux kernel development
>> only, and for this to optimally continue, we need to purge the list
>> of trolls like him.
>
> I'd rather natural forces work to show him what an anti-social person
> he is.  We don't need to ban him from the lists, as that is an act
> which is about as low as he is, and we don't need to stoop like that.
> -



For those who have just tuned in, I will present a
bit if history.

CD Writing using amateur operating systems like Windows
is really quite simple for the user. Using 3rd party
software, one can even access a CD/ROM as though it
was a "slow" disk. CD/ROM writing is built into a lot
of imaging software such as used for Kodak digital
cameras. The interface to Win/2000 and higher is
really quite straight-forward which may be why CD
writing has found its way into a lot of such applications.

Linux is a Unix variant. I/O to devices have historically
been performed using open, close, read, write, and ioctl.
These generic functions should remain for access to
CD/ROM devices as well. If you have a CD/ROM as a SCSI
device, ATA device, Firewire device, USB device, or
a fiber-channel device it should be accessed just like
any other block device and its name should be in /dev
so one can create a sym-link, possibly /dev/cdrom or
/dev/fast-CD, /dev/slow-CD, - anything the user wants.

There is nothing special about a CD/ROM except that
once written, you need a hacksaw to erase is. In fact,
you can write the output of `tar` directly to a CD/ROM
without any intervening file-system. This saves a lot
of time and space when performing backups. Of course
the driver requires some synchronization and, in fact,
some "experimentation" to determine the power-level for
a particular speed. However, those are just the details
necessary to start the write process.

Linux has a CD/ROM driver. It, for the most part, works
okay. It was written by a person who seems to have an
attitude problem. This is okay. Many smart people have
such problems. One of the things this problem creates
is the apparent refusal to understand by several persons,
including the designer, that there are many ways to
interface to a device, none better or worse than than
any other. In many cases it's all about convention.

The selection of the interface standard was created when
Multics was stripped down and Unix ported to a PDP-7
in the seventies by Dennis Ritchie. From that time on,
Unix and its variants always performed I/O using special
device files for access. There isn't even anything
special about these, either. It's just a method used
to associate a major/minor number combination with
a file-descriptor.

Linux started using devices with names like fd0, fd1, etc.,
for floppies; hda, hdb, etc., for generic hard disks; sda,
sdb, etc., for SCSI devices; scd0, scd1, etc., for
SCSI CD/ROM devices ... the list goes on.

When the current CD/ROM writer software was written, the
writer decided to reject the historical aspects of Linux
and create a device access and numbering scheme that
is alien to many Unix/Linux users. It goes like this:

scsibus0:
 	0,0,0	  0) 'SEAGATE ' 'ST32171W        ' '0484' Disk
 	0,1,0	  1) 'SEAGATE ' 'ST318233LWV     ' '0002' Disk
 	0,2,0	  2) 'SEAGATE ' 'ST39102LW       ' '0005' Disk
 	0,3,0	  3) *
 	0,4,0	  4) 'YAMAHA  ' 'CRW6416S        ' '1.0b' Removable CD-ROM
 	0,5,0	  5) *
 	0,6,0	  6) *
 	0,7,0	  7) *

Many Linux users have complained about this for several years.
The complaints have fallen upon deaf ears, which has become
irksome to many. The facts are that any/all naming and numbering
schemes are purely arbitrary. Internally, the kernel doesn't
give a rat's ass what it was called. It's just a file-descriptor
(an integer), that is associated with the device and the process
using that device.

It would be real nice if the designer of the software would
change his interface specification so it corresponds to what
the user's have become accustomed to, when dealing with Unix
and its variants, or to add an additional startup interface
that corresponds to the Unix/Linux convention. However,
as the writer of that software, he doesn't have to change
anything to placate the users. He could have designed the
software so the interface uses BSD sockets if he wanted to.
He just wanted to do his softare his way, and you can't
blame him for that.

If you want another interface, I suggest that those with
such powerful opinions that they expend a lot of effort
trying to put the guy down, just use a portion of that
effort to write a new driver. Maybe that will free up
enough time to fix some bugs.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_
To unsubscribe


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
