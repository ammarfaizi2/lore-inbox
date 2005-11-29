Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVK2O6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVK2O6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVK2O6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:58:24 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:9651 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751369AbVK2O6X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:58:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MvnzCScgNfCGaUt+AEy5Hsqgv/RiUE+FU2RtPmBLMRgSoXl7LtK9Gpm9XDDTycBj7J0Xpwm4Yx14Xr4dHY5ty1E6nApsSiXpc7BodHJowEsnUd0epp+gzO2Ep2g3Q+DcTsyjffMD5qRUqBIkRI9nKAItAQEiQV6biZSIWs7VuyU=
Message-ID: <58cb370e0511290658m682ae978hea2100f57252a928@mail.gmail.com>
Date: Tue, 29 Nov 2005 15:58:22 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: ide-cd doesn't replace ide-scsi?
Cc: Luke-Jr <luke-jr@utopios.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <438B70AA.7090805@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511281218.17141.luke-jr@utopios.org> <438B70AA.7090805@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/05, Bill Davidsen <davidsen@tmr.com> wrote:
> Luke-Jr wrote:
> > Note: results are with 2.6.13 (-gentoo-r4 + supermount) and 2.6.14 (-gentoo)
> > I've been struggling with burning DVD+R DL discs and upgrading the firmware on
> > my DVD burner, and just today decided to rmmod ide-cd and try using ide-scsi.
> > Turns out it works... so is ide-cd *supposed* to handle cases other than
> > simple reading and burning or is this a bug? If not a bug, should ide-scsi
> > really be marked as deprecated?
> > Also, two bugs with ide-scsi:
> > 1. On loading the module, it detects and allocates 6 SCSI devices for a single
> > DVD burner (Toshiba ODD-DVD SD-R5272); kernel log for this event attached
> > 2. On attempted unloading of the module, rmmod says 'Killed' and the module
> > stays put, corrupt. There was some kind of error in dmesg, but it appears to
> > have avoided syslog-- If I see it again, I'll save it.
>
> I think you may have the probe-all-LUNs set, and a CD burner which
> responds to more than one. That's one possible cause for this.

That may be it.

> Unfortunately using ide-cd still doesn't have the code set to allow all
> burning features to work if you are not root. Even if you have
> read+write there's one command you need to do multi-session which is
> only allowed to root. Works fine for single sessions, I guess that's all
> someone uses.

Interesting because both drivers ide-cd and sr+ide-scsi use exactly
the same code (block/scsi_ioctl.c) to verify which commands don't
need root privileges.  Care to give details?

> Haven't tried unloading the module, so I have no advice on that other
> than "don't do that."

Known problem with ide-scsi, reference counting for "virtual" SCSI host
is missing (it was always buggy but was exposed in 2.6.x something by
sr.c changes).

Bartlomiej
