Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVAXR3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVAXR3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVAXR3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:29:07 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:43389 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261539AbVAXR0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:26:06 -0500
Subject: Re: DVD burning still have problems
From: Kasper Sandberg <lkml@metanurb.dk>
To: Tim Fairchild <tim@bcs4me.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200501241146.32427.tim@bcs4me.com>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com>
	 <200501241146.32427.tim@bcs4me.com>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 18:26:00 +0100
Message-Id: <1106587560.13336.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 11:46 +1000, Tim Fairchild wrote:
> On Monday 24 Jan 2005 06:59, Alessandro Suardi wrote:
> > On Sun, 23 Jan 2005 21:26:55 +0100, Volker Armin Hemmann
> >
> > <volker.armin.hemmann@tu-clausthal.de> wrote:
> > > Hi,
> > >
> > > have you checked, that cdrecord is not suid root, and
> > > growisofs/dvd+rw-tools is?
> > >
> > > I had some probs, solved with a simple chmod +s growisofs :)
> >
> > Lucky you. Burning as root here, cdrecord not suid. Tried also
> >  burning with a +s growisofs, but...
> 
> You can test if it's the kernel/growisofs clashing by hacking the
> drivers/block/scsi_ioctl.c  code
> 
> It's around line 193 in 2.6.9, and line 196 in 2.6.10
> not sure about 2.6.11
at line 196
> 
> find the code:
> 
>         /* Write-safe commands just require a writable open.. */
>         if (type & CMD_WRITE_SAFE) {
>                 if (file->f_mode & FMODE_WRITE)
>                         return 0;
>         }
> 
> edit it to something like:
> 
>         /* Write-safe commands just require a writable open.. */
>         if (type & CMD_WRITE_SAFE) {
>                 printk ("Write safe command in ");
>                 if (file->f_mode & FMODE_WRITE)
>                         printk ("write mode.\n");
>                 else
>                         printk ("read mode.\n");
>                 return 0;
>         }
> 
> Compile the kernel with that and that may make it work and burn dvd and let 
> you know if it's growisofs sending incorrect commands. You'll get messages in 
> dmesg like
> 
> Write safe command in read mode.
> 
> which means growisofs is still not right. Maybe later version fixed this?
i got the latest version, and i just did this, nothing of this appeared
in dmesg, but also, i dont see what scsi_ioctl has to do with anything?
i dont use scsi emulation


> 
> tim
> 
> 

