Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSGPQEw>; Tue, 16 Jul 2002 12:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSGPQEv>; Tue, 16 Jul 2002 12:04:51 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:42921 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317874AbSGPQEu>; Tue, 16 Jul 2002 12:04:50 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Jauder Ho" <jauderho@carumba.com>,
       "Joerg Schilling" <schilling@fokus.gmd.de>
Cc: <vojtech@suse.cz>, <James.Bottomley@steeleye.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: IDE/ATAPI in 2.5
Date: Tue, 16 Jul 2002 09:08:17 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECMEHHCOAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0207160719260.16633-100000@turtle.carumba.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

path_to_inst is responsible for correlating the logical device path, i.e.
/sbus@2,0/fcaw@3,0/st@0,0 -> <instance number>. That instance number is used
to preserve device ordering. The next time the OS runs devfsadm,
path_to_inst is consulted to preserve history.

This is nessecary because by default, Solaris wants to index devices based
on the index of the slot, bus, and board that the card is plugged into. If
someone were to install board 4 first and install a card on sbus 2, slot 2
and later add a card on sbus 0, slot 0 path_to_inst insures that devices
stay in order.

I have managed these boxes for years and your comment below "And
path_to_inst does not always do the RightThing(tm)" needs more
clarification, I would say that the Solaris way of building devices is solid
as a rock.

How about this for instance ... When I take my laptop to work and dock it,
eth0 becomes the nic in the docking station as apposed to the pcmcia card
that was previously configured and expected to act as eth0. While im sure
there is some way to force the alias to be what it needs to be, if device
numbering was handled by a scheme like Solaris, this wouldn't be a problem.

--Buddy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Jauder Ho
Sent: Tuesday, July 16, 2002 7:29 AM
To: Joerg Schilling
Cc: vojtech@suse.cz; James.Bottomley@steeleye.com;
linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5



And path_to_inst does not always do the RightThing(tm). [1] [2] Two
systems identically configured has the potential of having path_to_inst
look different. Especially if you have previously installed a device or
moved stuff around. And if the expectation is that a group of devices will
come up in a certain sequence (think shared tape devices for instance) and
it changes, it quickly becomes a nightmare. Not a fun proposition by any
means.

--Jauder

[1] eg http://www.myri.com/scs/documentation/mug/installation/solaris.html
[2] http://www.magma.com/support/sun.htm

On Tue, 16 Jul 2002, Joerg Schilling wrote:

> >From vojtech@ucw.cz Tue Jul 16 13:59:27 2002
>
> >> It would help, if somebody would correct the current SCSI addressng
scheme used
> >> in Linux. Linux currently uses something called BUS/channel/target/lun.
> >> This does not reflect reality.
> >>
> >> What Linux calls a SCSI bus is definitely not a SCSI bus but a SCSI HBA
card.
> >> What Linux calls a channel really is one of possibly more SCSI busses
going
> >> off one of the SCSI HBA cards. It makes sense to just count SCSI
busses.
>
> >Well, no. It doesn't. Because the numbers will change if you add a card
> >(even at runtime - hotplugging USB SCSI is something real happening
> >today. And that'd be a very bad thing.
>
> It hey change, then this is a Linux kernel problem. On Solaris they don't
> change because Solaris manages /etc/path_to_inst
>
> Jörg
>
>  EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353
Berlin
>        js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
>        schilling@fokus.gmd.de		(work) chars I am J"org Schilling
>  URL:  http://www.fokus.gmd.de/usr/schilling
ftp://ftp.fokus.gmd.de/pub/unix
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

