Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318100AbSGMFiI>; Sat, 13 Jul 2002 01:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318101AbSGMFiH>; Sat, 13 Jul 2002 01:38:07 -0400
Received: from codepoet.org ([166.70.99.138]:20184 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318100AbSGMFiG>;
	Sat, 13 Jul 2002 01:38:06 -0400
Date: Fri, 12 Jul 2002 23:40:58 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020713054058.GA19292@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Joerg Schilling <schilling@fokus.gmd.de>,
	linux-kernel@vger.kernel.org
References: <200207121955.g6CJtQur018433@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207121955.g6CJtQur018433@burner.fokus.gmd.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jul 12, 2002 at 09:55:26PM +0200, Joerg Schilling wrote:
> Erik Andersen wrote:
> 
> >cdrecord should use the CDROM_SEND_PACKET ioctl, then it would
> >work regardless,
> 
> Wis you ever look at the cdrecord sources?

Yes, I have read the cdrecord source.  As you may recall from the
bug reports I would send periodically, I maintained the Debian
cdrecord/cdrtools package from 1998 till late last year...

> Cdrecord relies on libscg which is a generic SCSI transport library.
> It has been first written in August 1986 when I wrote the first SCSI
> pass through driver (for SunOS-3.0) - long before Adapted came out with
> ASPI. In the 16 years of evolution, it has been ported to > 30
> different platforms (not including CPU variants like sparc/x86).

Yup.  It's very portable, and I know you are very proud of libscg.
For Linux you have made libscg work using the "broken Linux SCSI
generic driver", and you have gone to great lengths to describe
how much you hate it. 

> If you force cdrecord to rely on CD-ROM only interfaces, you make Linux
> unusable in general. Do you really like to create an unusable Linux just
> to avoid creating a usable generic SCSI transport interface?

Lets step back a moment here.  The cdrecord package is not
responsible for making "Linux usable in general".  It is
responsible for writing data to CD-ROMs.  It is _not_ responsible
for driving scanners, hard drives, or enforcing policy on the
Linux kernel.

If you would throw away crdrecord's desire to do its own private
SCSI bus scanning, and throw away your attachment to addressing
devices only by host, channel, id, and lun a number of things
happen.  For starters, Linux devices don't have to be forced to
all be sitting on the SCSI bus.  You could use standard Linux
device names (i.e. /dev/hdc or /dev/scd0).  And you could still
send all the SCSI/ATAPI packet commands you want to the device
that was selected  using the CDROM_SEND_PACKET ioctl.

Ever look at the CDROM_SEND_PACKET ioctl?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
