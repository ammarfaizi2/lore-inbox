Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318902AbSH1QIm>; Wed, 28 Aug 2002 12:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSH1QIm>; Wed, 28 Aug 2002 12:08:42 -0400
Received: from p50846B1C.dip.t-dialin.net ([80.132.107.28]:21217 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S318902AbSH1QIh>;
	Wed, 28 Aug 2002 12:08:37 -0400
To: "qwerty314" <qwerty314@voila.fr>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: devfs cdrom mount pb
References: <H1K50B$AC854D30BB224167685C29984508D6D1@voila.fr>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Wed, 28 Aug 2002 18:12:56 +0200
In-Reply-To: <H1K50B$AC854D30BB224167685C29984508D6D1@voila.fr> ("qwerty314"'s
 message of "Wed, 28 Aug 2002 16:16:59 +0200")
Message-ID: <m365xvnerb.fsf@terra.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"qwerty314" <qwerty314@voila.fr> writes:

> My linux box was runing fine till I decide to try devfs on RH7.3
> with 2.4.18-3 kernel after some adjustments everything is nearly OK
> with the new /dev concepts but when I try to mount a cdrom it says
> that the device is not a block device.  cat /proc/scsi/scsi gives :
>
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: PLEXTOR  Model: CD-R   PX-W1610A Rev: 1.02
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: SAMSUNG  Model: CD-ROM SC-152C   Rev: CS05
>   Type:   CD-ROM                           ANSI SCSI revision: 02
>
> and ls -l /dev/scsi/host0/bus0/target1/lun0/* gives
> crw-rw-rw-    1 root     root      21,   1 jan  1  1970
> /dev/scsi/host0/bus0/target1/lun0/generic
>
> quid?
> why has my cdrom entry switched from a block to a character device
> and how to cure it ?

You do not have the sr_mod module loaded; thus /dev/scsi/<address>/
only contains the "generic" device node, not the "cdrom" block device
node.

Either load sr_mod from a startup script (/etc/rc.modules comes to
mind), or set up the devfs module autoloader appropriately.

The device to be used for mounting is /dev/scsi/<address>/cdrom, not
/dev/scsi/<address>/generic. The generic device is "only" used for
special-purpose commands, such as for scanners or CD writing. Those
special commands are not block-level, thus "generic" is a character
device.


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
