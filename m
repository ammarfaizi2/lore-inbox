Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVBDBjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVBDBjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVBDBj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:39:27 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:10166 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263312AbVBDBhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:37:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=JSNA5yev8nDz+D+DpNIYbIDYi+yqOIHIkLiIYm1PiPNlblkIV9+7d8jkllPcV+WNLvwzsKiVZScKqmALRJYQNgoOJY836D/sLwxXtHbncT6nnF5nGlCuM7HgR2oyV3OdezE+8P+BT0Y+JfQpErPo0i95UJKEJ1AWMthoIU9Gj5w=
Message-ID: <58cb370e05020317375ae36558@mail.gmail.com>
Date: Fri, 4 Feb 2005 02:37:40 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 29/29] ide: make data_phase explicit in NO_DATA cases
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <4202C8EA.7060802@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202031238.GN1187@htj.dyndns.org>
	 <58cb370e050203094326ddfce8@mail.gmail.com>
	 <4202C8EA.7060802@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2005 09:59:22 +0900, Tejun Heo <tj@home-tj.org> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 2 Feb 2005 12:12:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> >
> >>>29_ide_explicit_TASKFILE_NO_DATA.patch
> >>>
> >>>      Make data_phase explicit in NO_DATA cases.
> >>
> >>Signed-off-by: Tejun Heo <tj@home-tj.org>
> >>
> >>Index: linux-ide-export/drivers/ide/ide-disk.c
> >>===================================================================
> >>--- linux-ide-export.orig/drivers/ide/ide-disk.c        2005-02-02 10:28:07.852771465 +0900
> >>+++ linux-ide-export/drivers/ide/ide-disk.c     2005-02-02 10:28:08.121727827 +0900
> >>@@ -300,6 +300,7 @@ static unsigned long idedisk_read_native
> >>        args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
> >>        args.tfRegister[IDE_COMMAND_OFFSET]     = WIN_READ_NATIVE_MAX;
> >>        args.command_type                       = IDE_DRIVE_TASK_NO_DATA;
> >>+       args.data_phase                         = TASKFILE_NO_DATA;
> >>        args.handler                            = &task_no_data_intr;
> >
> >
> > Could you add small helper to ide.h for doing this?
> >
> > static inline void ide_prep_no_data_cmd(ide_task_t *task)
> > {
> >         task->command_type = IDE_DRIVE_TASK_NO_DATA;
> >         task->data_phase      = TASKFILE_NO_DATA;
> >         task->handler            = &task_no_data_intr;
> > }
> 
> I am thinking about removing task->handler initialization.  Such that it
> defaults to task_no_data_intr if data_phase == TASKFILE_NO_DATA and so
> on for all other data_phases.  Currently, the same information is
> specified repeatedly.  What do you think?

Please do it.
