Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVBCSA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVBCSA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbVBCSAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:00:00 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:20148 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262863AbVBCRv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:51:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oXQKpksR5B9PViDkT3miPSoEcfbbR0qr562FKPabJsKjffmQsI6czlep/U9PcM9GEQKo+qqMF9H1U2Y5YPj6VXYH2tIsX/Fd0Iui3vDjKWu5LfnNbZdt4/1EOaAVOpV021/p4eVj4UeP+C+PSlAzK8fiCy3m+sVPeWSSzY5Fy0Q=
Message-ID: <58cb370e050203094326ddfce8@mail.gmail.com>
Date: Thu, 3 Feb 2005 18:43:07 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 29/29] ide: make data_phase explicit in NO_DATA cases
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202031238.GN1187@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202031238.GN1187@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 12:12:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 29_ide_explicit_TASKFILE_NO_DATA.patch
> >
> >       Make data_phase explicit in NO_DATA cases.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>
> 
> Index: linux-ide-export/drivers/ide/ide-disk.c
> ===================================================================
> --- linux-ide-export.orig/drivers/ide/ide-disk.c        2005-02-02 10:28:07.852771465 +0900
> +++ linux-ide-export/drivers/ide/ide-disk.c     2005-02-02 10:28:08.121727827 +0900
> @@ -300,6 +300,7 @@ static unsigned long idedisk_read_native
>         args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
>         args.tfRegister[IDE_COMMAND_OFFSET]     = WIN_READ_NATIVE_MAX;
>         args.command_type                       = IDE_DRIVE_TASK_NO_DATA;
> +       args.data_phase                         = TASKFILE_NO_DATA;
>         args.handler                            = &task_no_data_intr;

Could you add small helper to ide.h for doing this?

static inline void ide_prep_no_data_cmd(ide_task_t *task)
{
        task->command_type = IDE_DRIVE_TASK_NO_DATA;
        task->data_phase      = TASKFILE_NO_DATA;
        task->handler            = &task_no_data_intr;
}

Also please move this patch earlier in the series
so I can merge it quickly.

Thanks.
