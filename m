Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVBCAYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVBCAYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVBCAYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:24:32 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:4841 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262734AbVBCAX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:23:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EyPuooqOpLu7PZtu7Gh/p4K3t4oMSN26+UgtoQDAU/0rby3PrzppD6EFA3L/Y9x6gDuv/WJ04J4vj8PIyXeCBJRc/n5uMeIP+Fn1tTzz+9nOpN7GzLYO19e6vXIMbbIr5z5FJN3pvlKByAC/kow9W85UFTWnrwypgr1bnzr4SWE=
Message-ID: <58cb370e050202162334828b55@mail.gmail.com>
Date: Thu, 3 Feb 2005 01:23:24 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 06/29] ide: IDE_CONTROL_REG cleanup
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202024830.GG621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024830.GG621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:48:30 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 06_ide_start_request_IDE_CONTROL_REG.patch
> >
> >       Replaced HWIF(drive)->io_ports[IDE_CONTROL_OFFSET] with
> >       equivalent IDE_CONTROL_REG in ide-io.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>
> 
> Index: linux-ide-export/drivers/ide/ide-io.c
> ===================================================================
> --- linux-ide-export.orig/drivers/ide/ide-io.c  2005-02-02 10:27:15.996184821 +0900
> +++ linux-ide-export/drivers/ide/ide-io.c       2005-02-02 10:28:03.340503581 +0900
> @@ -884,7 +884,7 @@ static ide_startstop_t start_request (id
>                 if (rc)
>                         printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
>                 SELECT_DRIVE(drive);
> -               HWIF(drive)->OUTB(8, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
> +               HWIF(drive)->OUTB(8, IDE_CONTROL_REG);
>                 rc = ide_wait_not_busy(HWIF(drive), 10000);
>                 if (rc)
>                         printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);

IDE_CONTROL_REG macro and co. are obfuscations and should die...
