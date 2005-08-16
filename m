Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVHPUmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVHPUmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVHPUmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:42:14 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:32989 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932441AbVHPUmL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:42:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FRljgkxMzIFgzXOuT0pDF8g7DHLNW9vvjK8h9NGv8eW7urFoZJbBe4XtY0w7lJH0lI3VONBHwl53/zs5QTPqtASkdx4fNihp9/LjYuOfy2kdSxF4niRXPuuhptwWV1NIvcKsmnMgLrT37hV27GXpMHnBPrtbYc2mDuKDQsxh0Uw=
Message-ID: <58cb370e050816134270b445ea@mail.gmail.com>
Date: Tue, 16 Aug 2005 22:42:07 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <1124223946.22924.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
	 <200508161316.32602.bjorn.helgaas@hp.com>
	 <1124223946.22924.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > >   * non-functional HDIO_REGISTER_HWIF ioctl (ain't really working either)
> >
> > HDIO_SCAN_HWIF - I don't know about this one.  How are we supposed to
> > follow the "new ports shouldn't define IDE_ARCH_OBSOLETE_INIT" injunction
> > if we lose all this functionality without it?  ia64 is about as close to
> > a new port as you get :-)
> 
> It allows you to register interfaces from user space.
> 
> As to IDE_ARCH_OBOSOLETE_INIT, its a red herring. It's not worth the
> trouble to avoid it given the expected short remaining life time of the
> old IDE layer. Far better would be to help get the new SATA layer doing
> PATA so drivers/ide can be deleted.

My opinion on this matter differ, I want to:
* finish rewriting IDE code
* deprecate crap
* (later) drop crap and merge rest with libata

I will write precised TODO (w/ status) soon.

IMO this is much better solution as:
* you go from working code into small steps (evolution)
* you don't have to maintain both libata and IDE driver
   for X years (deleting drivers/ide anytime soon is a pipedream)
* as IDE becomes less popular testing gets harder
  (especially when developing new code - you don't
   have previous state)
* it shouldn't be that hard - I have many parts of the stuff
  done (they need some polishing)

Bjorn, thanks for working on this, IDE_ARCH_OBSOLETE_INIT
( -> ide_init_hwif_ports() ) needs to be fixed in order to make REAL
improvements.

Bartlomiej
