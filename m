Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUIAPny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUIAPny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUIAPnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:43:42 -0400
Received: from daq3.if.pw.edu.pl ([194.29.174.23]:44672 "HELO milosz.na.pl")
	by vger.kernel.org with SMTP id S267205AbUIAPm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:42:27 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Reply-To: bzolnier@milosz.na.pl
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] Configure IDE probe delays
Date: Wed, 1 Sep 2004 17:40:32 +0200
User-Agent: KMail/1.6.2
Cc: Lee Revell <rlrevell@joe-job.com>, Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <200408272059.51779.bzolnier@elka.pw.edu.pl> <4135CC9E.5060905@rtr.ca>
In-Reply-To: <4135CC9E.5060905@rtr.ca>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409011740.32908.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens come with this long time ago but IDE driver is not ready for it,
there are some gaps to fill first.

Anyway, thanks for reminding me about this.

Cheers.

On Wednesday 01 September 2004 15:20, Mark Lord wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >
> >>What determines whether 48 bit addressing will be used then?
> > 
> > Availability of 48-bit addressing feature set and host capabilities
> > (some don't support LBA48 when DMA is used etc.).
> 
> I haven't examined the "released" IDE drivers in some time,
> but one optimisation that can save a LOT of CPU usage
> is for the driver to only use LBA48 *when necessary*,
> and use LBA28 I/O otherwise.
>
> Each access to an IDE register typically chews up 600+ns,
> or the equivalent of a couple thousand instruction executions
> on a modern core.  Avoiding LBA48 when it's not needed will
> save four such accesses per I/O, or about 2.5us.
> 
> LBA48 is only needed when (1) the sector count is greater than 256,
> and/or (2) the ending sector number >= (1<<28).
> 
> I regularly include this optimisation in the drivers I have been
> working on since LBA48 first appeared.
> 
> Cheers
