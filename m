Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbULHVqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbULHVqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbULHVqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:46:55 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:6289 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261376AbULHVqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:46:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CyRbDOVCAZXnYn273Pm9Ybp9sWwCU3rG/fLwVJUcWGJyge9x3kefOAh7EkFkIcsEK4jGmQpE+WgSWQ/h2H4p7yuGEqQp96uSBLWzbb2KnRCoD0xf1qJmjq0qDmSv9OCupK20Ai7TaOUjoZOWm+dwHFYjuS8nlOc6erUIZzdGQ4w=
Message-ID: <58cb370e0412081346554cf3d8@mail.gmail.com>
Date: Wed, 8 Dec 2004 22:46:50 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Pope <alan.pope@gmail.com>
Subject: Re: PDC202XX_OLD broken
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <8e93903b041208132573a3c118@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8e93903b041206140529a8baa9@mail.gmail.com>
	 <1102425655.17950.21.camel@localhost.localdomain>
	 <58cb370e041207125864b97eea@mail.gmail.com>
	 <8e93903b041208132573a3c118@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004 21:25:56 +0000, Alan Pope <alan.pope@gmail.com> wrote:
> On Tue, 7 Dec 2004 21:58:52 +0100, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> > You are using 40c cable instead of 80c one.
> > Thus transfer rate is limited to UDMA33.
> >
> 
> No, I'm using an 80c cable. I have even gone out and bought a new 80c
> one just to make sure the cable isn't broken. I have also got two
> identical disks, and experience exactly the same problem on both.

Ah, my mistake, you have 40c cable connected to VIA not Promise...

> I booted with "ide2=dma" because it was booting with the disk in pio mode.

If you are talking about:

ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:pio, hdh:pio

it reports BIOS settings not the ones used by driver, no need for
"ide=dma2" if you have CONFIG_IDEDMA_PCI_AUTO=y.

> > Moreover pdc202xx_old has a bug in cable detection code.
> > pdc202xx_old_cable_detect() always returns '0' (which means
> > 80c cable) due to a sloppy coding - result of CIS & mask is
> > truncated to 8 bits although CIS holds cable info in bits 10-11.
> >
> > Does this fix work for you?
> >
> 
> Not tried it, but it wouldn't help me would it? I *do* have an 80c
> cable, and the disk does show up in dmesg as a UDMA100 disk..

It wouldn't, it must be another bug.
