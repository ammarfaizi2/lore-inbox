Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263409AbVBDBUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263409AbVBDBUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbVBDBUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:20:09 -0500
Received: from [211.58.254.17] ([211.58.254.17]:49539 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261842AbVBDA7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:59:25 -0500
Message-ID: <4202C8EA.7060802@home-tj.org>
Date: Fri, 04 Feb 2005 09:59:22 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 29/29] ide: make data_phase explicit in NO_DATA
 cases
References: <20050202024017.GA621@htj.dyndns.org>	 <20050202031238.GN1187@htj.dyndns.org> <58cb370e050203094326ddfce8@mail.gmail.com>
In-Reply-To: <58cb370e050203094326ddfce8@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 2 Feb 2005 12:12:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> 
>>>29_ide_explicit_TASKFILE_NO_DATA.patch
>>>
>>>      Make data_phase explicit in NO_DATA cases.
>>
>>Signed-off-by: Tejun Heo <tj@home-tj.org>
>>
>>Index: linux-ide-export/drivers/ide/ide-disk.c
>>===================================================================
>>--- linux-ide-export.orig/drivers/ide/ide-disk.c        2005-02-02 10:28:07.852771465 +0900
>>+++ linux-ide-export/drivers/ide/ide-disk.c     2005-02-02 10:28:08.121727827 +0900
>>@@ -300,6 +300,7 @@ static unsigned long idedisk_read_native
>>        args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
>>        args.tfRegister[IDE_COMMAND_OFFSET]     = WIN_READ_NATIVE_MAX;
>>        args.command_type                       = IDE_DRIVE_TASK_NO_DATA;
>>+       args.data_phase                         = TASKFILE_NO_DATA;
>>        args.handler                            = &task_no_data_intr;
> 
> 
> Could you add small helper to ide.h for doing this?
> 
> static inline void ide_prep_no_data_cmd(ide_task_t *task)
> {
>         task->command_type = IDE_DRIVE_TASK_NO_DATA;
>         task->data_phase      = TASKFILE_NO_DATA;
>         task->handler            = &task_no_data_intr;
> }

I am thinking about removing task->handler initialization.  Such that it 
defaults to task_no_data_intr if data_phase == TASKFILE_NO_DATA and so 
on for all other data_phases.  Currently, the same information is 
specified repeatedly.  What do you think?

> Also please move this patch earlier in the series
> so I can merge it quickly.
> 
> Thanks.

Sure.

-- 
tejun

