Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319206AbSH2Nxr>; Thu, 29 Aug 2002 09:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319209AbSH2Nxr>; Thu, 29 Aug 2002 09:53:47 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:25863 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S319206AbSH2Nxq>; Thu, 29 Aug 2002 09:53:46 -0400
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
In-Reply-To: <20020805155658.GE27306@kroah.com>
To: Greg KH <greg@kroah.com>
Date: Thu, 29 Aug 2002 15:57:37 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, marcelo@conectiva.com.br,
       mdharm-usb@one-eyed-alien.net, mwilck@freenet.de,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17kPnl-0003aD-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Envelope-to: marekm@amelek.gda.pl
Date: Mon, 5 Aug 2002 08:56:58 -0700
From: Greg KH <greg@kroah.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
cc: marcelo@conectiva.com.br, mdharm-usb@one-eyed-alien.net, 
	 mwilck@freenet.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
Message-ID: <20020805155658.GE27306@kroah.com>
References: <20020626145741.GD4611@kroah.com> <E17bLKe-0001p2-00@alf.amelek.gda.pl>
Content-Disposition: inline
In-Reply-To: <E17bLKe-0001p2-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 08 Jul 2002 14:36:57 -0700

(Sorry for the delay - found an old email lost between tons of spam...)

> On Sun, Aug 04, 2002 at 03:22:04PM +0200, Marek Michalkiewicz wrote:
> > Hi,
> > 
> > > Heh, send this to me again after 2.4.19-final is out, and I'll
> > > reconsider it :)
> > 
> > Over a month later, here it is - this drivers/usb/storage/unusual_devs.h
> > entry appears to be sufficient to make my Sagatek DCS-CF work:
> > 
> > /* aka Sagatek DCS-CF */
> > UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
> > 		"Datafab",
> > 		"KECF-USB",
> > 		US_SC_SCSI, US_PR_BULK, NULL,
> > 		US_FL_FIX_INQUIRY ),
> 
> That's a wide range for this device, do you really need 0x0000 - 0xffff
> for this?

Well, I don't know what to do - the device I have is reported as
revision 0113.  But the patch on http://martin.wilck.bei.t-online.de/
has a range of 0x0000 - 0x0015 so it would not handle my device.

> And send a patch to Matt, if he agrees with it, he'll send it on to me.

He is on the Cc: list.  Please consider this entry, possibly with
US_FL_START_STOP and US_FL_MODE_XLATE flags added (no difference
for me, but present in the patch on the above mentioned page), for
inclusion in 2.4.20.  I can make a patch if you tell me what range
and flags would be accepted.

Support for such devices out of the box becomes more important now
that motherboard BIOSes start supporting boot from USB storage
(so you could easily install a Linux distribution on a CF card,
or use one as a rescue disk simply plugged into an USB port if ever
needed - no need for a floppy or CD-ROM drive in a server).
I don't know how widespread this is, but such a feature has just
appeared in the latest MSI MS-6368 BIOS upgrade, for example...

Thanks,
Marek

