Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131606AbRC0VUs>; Tue, 27 Mar 2001 16:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbRC0VUi>; Tue, 27 Mar 2001 16:20:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39941 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131589AbRC0VU1>; Tue, 27 Mar 2001 16:20:27 -0500
Subject: Re: Larger dev_t
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 27 Mar 2001 22:21:24 +0100 (BST)
Cc: hpa@transmeta.com (H. Peter Anvin), Andries.Brouwer@cwi.nl,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <Pine.LNX.4.31.0103271139530.24860-100000@penguin.transmeta.com> from "Linus Torvalds" at Mar 27, 2001 11:51:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14i0u8-0004N1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another example: all the stupid pseudo-SCSI drivers that got their own
> major numbers, and wanted their very own names in /dev. They are BAD for
> the user. Install-scripts etc used to be able to just test /dev/hd[a-d]
> and /dev/sd[0-x] and they'd get all the disks. Deficiencies in the SCSI

Sorry here I have to disagree. This is _policy_ and does not belong in the
kernel. I can call them all /dev/hdfoo or /dev/disc/blah regardless of 
major/minor encoding. If you dont mind kernel based policy then devfs
with /dev/disc already sorts this out nicely.

IMHO more procfs crud is also not the answer. procfs is already poorly 
managed with arbitary and semi-random namespace. Its a beautiful example of
why adhoc naming is as broken as random dev_t allocations. Maybe Al Viro's
per device file systems solve that.

> layer made it impossible for a driver writer to be nice to the user, so
> instead they got their own major numbers.

Not deficiencies in the SCSI layer, there is no way the scsi layer can
handle high end raid controllers. In fact one of the reasons we can beat
NT with some of these controllers is because NT does exactly what you
suggest with scsi miniport driver hacks and it _sucks_. Its an ugly hack.

A 20bit minor space actually solves most of this anyway. All the drivers
taking 8 majors suddenely need only one. We go back to 1 major per raid
controller class worst case. and we just about have enough minor numbers for the
extreme S/390 configuration of 65536 DASD volumes with 16 partitions per
volume.

12:20 sounds good to me. If need be we can have extend the small allocations
space as we have with 10,* now.

Alan

