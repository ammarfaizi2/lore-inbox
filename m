Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTKKRLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTKKRLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:11:04 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27295 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263586AbTKKRK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:10:57 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Subject: Re: PATCH: CMD640 IDE chipset
Date: Tue, 11 Nov 2003 17:50:25 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031110130021.35782.qmail@web20604.mail.yahoo.com>
In-Reply-To: <20031110130021.35782.qmail@web20604.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311111750.25292.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 of November 2003 14:00, Stefan Talpalaru wrote:

> > >   I also removed the CONFIG_BLK_DEV_CMD640_ENHANCED config option, as it
> > > makes little difference for the kernel size.
> > >   The init_hwif_cmd640() function had to be rewritten because it is
> > > called once for each ide interface found, so the old way of addressing
> > > all the drives in one run was no longer working. Therefore, to not
> > > break all the code, came the need for a function that computes the
> > > index from the ide_drive_t* : calculate_index().
> >
> > ide_probe_for_cmd640x() should be still be used instead.
>
>   I disagree.
>
> > By removing setup_device_ptrs() and moving this driver to generic PCI
> > layer, you broke support for VLB version of CMD640.
>
>   I don't have a VLB version to test it on, but by reading the code I think
>   that it will work just fine.

No, it won't be even probed.  Note that ide_probe_for_cmd640x() was detecting
both VLB and PCI chipsets.  After moving detection to generic IDE PCI layer,
only PCI version of the chipset will be probed (and only after Device/Vendor
ID matching).  You are of course free to disagree as much as you want...

>   Anyway, if I'm wrong I should get a prize for breaking something that was
>   allready broken :-)))) .
>
> > Also there is a comment in a cmd640.c:
> > /*
> >  * The CMD640x chip does not support DWORD config write cycles, but some
> >  * of the BIOSes use them to implement the config services.
> >  */
> > which worries me that it might be not safe to move this driver to generic
> > IDE PCI layer (at least for now).
>
>   Don't worry man, just read the code and you shall find peace of mind....

Get serious, piece of mind after reading drivers/ide code?  Nah.

> > >   The code that handles PIO settings was rearanged in a new function:
> > > cmd640_tuneproc().
> >
> > Is this really necessary, it is even harder to read it now...
>
>   It is necessary, unless the purpose of this piece of code is readability.
>
> > Stefan, please rework your patch.  Thanks.
>
>   If you say that the only way I will get this driver fixed is to keep it
>   ugly then I will send you a lame patch that does just that.

Minimize changes, then next time when you need to fix this driver (say in 2.7)
you will spend much less time on tracking changes 2.0.x->2.7.x.



