Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263269AbVBDBpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbVBDBpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbVBDBpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:45:42 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:29386 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263321AbVBDBko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:40:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SYBarQorAeb2NQVZ+zRs0ITsmLajrXTu7Oc27IvXE9LzWbOem7V8/0++yIXDP2wie0U2QlgCnd2ItDVokMY3b9AT5xVjOA/Pt69eUxW5/aYKYob39TuBLRbKv6DebGEOYi0zpCc9bJFLeF39su143asrOA1HoZ8hNan7I6FroZg=
Message-ID: <58cb370e0502031740141468d4@mail.gmail.com>
Date: Fri, 4 Feb 2005 02:40:02 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 25/29] ide: convert REQ_DRIVE_CMD to REQ_DRIVE_TASKFILE
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <4202CA95.6030801@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202031559.GP1187@htj.dyndns.org>
	 <58cb370e05020309464a106816@mail.gmail.com>
	 <4202CA95.6030801@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2005 10:06:29 +0900, Tejun Heo <tj@home-tj.org> wrote:
> Hello,
> 
> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 2 Feb 2005 12:15:59 +0900, Tejun Heo <tj@home-tj.org> wrote:
> >
> >>>25_ide_taskfile_cmd.patch
> >>>
> >>>      All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
> >>>      converted to use REQ_DRIVE_TASKFILE.
> >>
> >>Signed-off-by: Tejun Heo <tj@home-tj.org>
> >>
> >>Index: linux-ide-export/drivers/ide/ide-disk.c
> >>===================================================================
> >>--- linux-ide-export.orig/drivers/ide/ide-disk.c        2005-02-02 10:28:06.527986413 +0900
> >>+++ linux-ide-export/drivers/ide/ide-disk.c     2005-02-02 10:28:07.204876587 +0900
> >>@@ -750,7 +750,7 @@ static int set_multcount(ide_drive_t *dr
> >>        if (drive->special.b.set_multmode)
> >>                return -EBUSY;
> >>        ide_init_drive_cmd (&rq);
> >>-       rq.flags = REQ_DRIVE_CMD;
> >>+       rq.flags = REQ_DRIVE_TASKFILE;
> >
> >
> > Please instead fix ide_init_drive_cmd() to set REQ_DRIVE_TASKFILE
> > and add set REQ_DRIVE_CMD only in ide_cmd_ioctl().
> >
> 
> This is done in patch #28.  If you don't like the ordering of the
> patches, I can change the orders but I don't think that improves
> anything.  This order is as good as the other order.

Actually no - if you change this then patch #28 becomes NOP.

So please do it, thanks.
