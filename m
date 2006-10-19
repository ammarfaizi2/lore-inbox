Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWJSMDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWJSMDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWJSMDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:03:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27849 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751512AbWJSMDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:03:35 -0400
Subject: Re: [PATCH] genhd fix or ide workaround -- choose one
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: cbou@mail.ru
Cc: kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061018221506.GA4187@localhost>
References: <20061018221506.GA4187@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 13:05:52 +0100
Message-Id: <1161259553.17335.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 02:15 +0400, ysgrifennodd Anton Vorontsov:
> Hi all,
> 
> I've caught deadlock inside IDE layer using IDE-CS: after accessing
> to IDE disk placed in PCMCIA (CF card really), it will never probe
> again after pulling it from PCMCIA/CF.

Works for me, and has done for a long time and I've also had no other
reports of this in the past couple of years so I'm curious what trips it
in your case ?

> The kernel is stuck at
> drivers/ide/ide.c:ide_unregister():604:
> 
>         602                 spin_unlock_irq(&ide_lock);
>         603                 device_unregister(&drive->gendev);
>         604                 wait_for_completion(&drive->gendev_rel_comp);
>         605                 spin_lock_irq(&ide_lock);

We need to know all the references have gone away, if someone has a disk
referenced and you pull it out we can't clean up immediately so this is
the right place to get stuck both on a refcounting bug and if you've got
something holding a reference for real (eg HAL)



