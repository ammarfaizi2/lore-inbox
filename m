Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUEOR4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUEOR4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 13:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUEOR4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 13:56:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62461 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261712AbUEOR4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 13:56:19 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 15 May 2004 19:58:03 +0200
User-Agent: KMail/1.5.3
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <20040515173430.GA28873@havoc.gtf.org>
In-Reply-To: <20040515173430.GA28873@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405151958.03322.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 of May 2004 19:34, Jeff Garzik wrote:
> On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > - do not believe in popular myth that driver code
> >   can be of less quality than core kernel code
>
> chuckle :)

hehe :)

> > - don't copy without thinking ugly and bogus code
> >   (there is still lot of such in IDE)
>
> Agreed, but I think most driver authors will not know what is ugly
> and bogus code, otherwise they would probably not copy it... (I hope!)

Some just copy _everything_ what is in other driver, really...

> > - host drivers should request/release IO resource
> >   themelves and set hwif->mmio to 2
>
> Don't you mean, hwif->mmio==2 for MMIO hardware?

It is was historically for MMIO, now it means that driver
handles IO resource itself (per comment in <linux/ide.h>).

> > - ide_init_hwif_ports() is obsolete and dying,
> >   define IDE_ARCH_NO_OBSOLETE_INIT in <asm/ide.h>
>
> hmmmm.  Please consider reversing this:
>
> Make ide_init_hwif_ports() present _only_ if IDE_ARCH_OBSOLETE_INIT
> is defined.
>
> Then add that define for all arches that still use ide_init_hwif_ports().

Well, I started with this idea but it requires adding this define for far
too many archs.  This is a problem especially for arm because we have to
either leave <asm-arm/arch-*/ide.h> or add #ifdef horror <asm-arm/ide.h>.

> > - define ide_default_irq(), ide_init_default_irq()
> >   and ide_default_io_base() to (0)
>
> Maybe provide generic definitions, so that new arches don't even
> have to care about this?

Please explain.

Thanks,
Bartlomiej

