Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVDFQC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVDFQC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVDFQC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:02:56 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:37036 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262242AbVDFQCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:02:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KEFpyENBbgCXI0vBYltUIen2r2X4whWEX9ZTDva1hSBuua+zTIPGNnN5HGwK2sfD5a6GdDiXh9665H5vPiR34j/03/jKIlj7co7ePcB/PaFbe7Tga2NFs0lmFnWCdZg0IuOfx6lsBxFQ6W9yrHQXMvbV9UlzOuiXOWmdvxL+cdE=
Message-ID: <58cb370e0504060902442082ee@mail.gmail.com>
Date: Wed, 6 Apr 2005 18:02:00 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-os@analogic.com
Subject: Re: How's the nforce4 support in Linux?
Cc: Julien Wajsberg <julien.wajsberg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504060737130.21548@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <2a0fbc5905040506422fbf6356@mail.gmail.com>
	 <Pine.LNX.4.61.0504050957400.15886@chaos.analogic.com>
	 <2a0fbc59050405155815666e8d@mail.gmail.com>
	 <Pine.LNX.4.61.0504060737130.21548@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 6, 2005 1:41 PM, Richard B. Johnson <linux-os@analogic.com> wrote:
> On Tue, 5 Apr 2005, Julien Wajsberg wrote:
> 
> > On Apr 5, 2005 4:10 PM, Richard B. Johnson <linux-os@analogic.com> wrote:
> >> On Tue, 5 Apr 2005, Julien Wajsberg wrote:
> >>
> >>> On Mar 26, 2005 12:59 AM, Julien Wajsberg <julien.wajsberg@gmail.com> wrote:
> >>>> I own an Asus A8N-Sli motherboard with the Nforce4-Sli chipset, and I
> >>>> experiment the following problem :
> >>>>
> >>>> Mar 25 22:42:55 evenflow kernel: hda: dma_timer_expiry: dma status == 0x60
> >>>> Mar 25 22:42:55 evenflow kernel: hda: DMA timeout retry
> >>>> Mar 25 22:42:55 evenflow kernel: hda: timeout waiting for DMA
> >>>> Mar 25 22:42:55 evenflow kernel: hda: status error: status=0x58 {
> >>>> DriveReady SeekComplete DataRequest }
> >>>> Mar 25 22:42:55 evenflow kernel:
> >>>> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> >>>> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
> >>>> Mar 25 22:42:55 evenflow kernel: hda: status timeout: status=0xd0 { Busy }
> >>>> Mar 25 22:42:55 evenflow kernel:
> >>>> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> >>>> Mar 25 22:42:55 evenflow kernel: hdb: DMA disabled
> >>                                       ^^^^^^^^^^^^^^^^^
> >>>> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
> >>>>
> >>>> Of course, if I disable DMA with hdparm, this problem disappear.. but
> >>>> it isn't a long-term solution ;-)
> >>>>
> >>
> >> The long-term solution is to replace either the drive, cable, or the
> >> motherboard that can't do DMA.
> > It's a recent drive that did ultra DMA on another motherboard, and a
> > recent motherboard with a cable that did ultra DMA before.It was ultra
> > DMA2 on this old motherboard, but it still was ultra DMA.
> >
> >> A bad DMA operation can write data
> >> anywhere (right into the middle of the kernel). There isn't
> >> anything software can do about it. Software sets up the
> >> controller for a DMA operation, then waits for an interrupt
> >> that tells it has completed or failed. Software can retry failed
> >> operations until software gets destroyed by the hardware, but
> >> there isn't anything else that can be done.
> >>
> >> The fact that disabling DMA makes the problem(s) go away is
> >> proof that it isn't a software problem. There are flash-RAM
> >> devices that emulate IDE drives. Most of these can't do DMA
> >> and the IDE driver doesn't accept that fact. That is a known
> >> bug. One needs to use hdparm to tell it to stop trying to
> >> use DMA. In your case, the driver stopped using DMA when
> >> it found out that it didn't work. There is no bug.

There still can be a bug in setting up DMA timings etc.

It is hard to even guess as you haven't given any details about your
system: dmesg/hdparm/lspci/config... (or I overlooked it somehow).

> > In my case, the driver stopped for hdb, that is my dvd-burner/player.
> > It did nothing for hda or hdc, I had to disable DMA myself.
> >
> > Will I have to install Windows XP to prove ultra DMA works correctly
> > on this setup ? I really don't hope...

That would be very helpful.

Another useful thing would be to try non-nVidia motherboard
(if you have one handy) without changing anything else.

Bartlomiej
