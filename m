Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVBJBbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVBJBbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 20:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVBJBbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 20:31:06 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:23407 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262004AbVBJBbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 20:31:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RK9m17e+LWzW6U7SXSenQimOE5OJKa663fNAb8ZlIyvjwgME96uW3nEhac5qtkYPQh4uYa08iNWB5PQ6vZ1+F2jZY29LWtv4l0hdMHeW7Cuztfxs1ros/M488bNljF+7YcTNatY5H65oBtjqdzPIklwsF4WeUP4LGR6jKrnd0FI=
Message-ID: <58cb370e05020917312994f531@mail.gmail.com>
Date: Thu, 10 Feb 2005 02:31:00 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <420AB049.4040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl>
	 <4206F2E5.7020501@gmail.com>
	 <200502070959.54973.bzolnier@elka.pw.edu.pl>
	 <420AA476.1040406@gmail.com>
	 <58cb370e050209162437808733@mail.gmail.com>
	 <420AB049.4040705@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 09:52:25 +0900, Tejun Heo <htejun@gmail.com> wrote:
> 
>   Okay, another quick question.
> 
>   To fix the io_32bit race problem in ide_taskfile_ioctl() (and later
> ide_cmd_ioctl() too), it seems simplest to mark the taskfile with
> something like ATA_TFLAG_IO_16BIT flag and use the flag in task_in_intr().
> 
>   However, ATA_TFLAG_* are used by libata, and I think that, although
> sharing hardware constants is good if the hardware is similar, sharing
> driver-specific flags isn't such a good idea.  So, what do you think?
> 
>   1. Add ATA_TFLAG_IO_16BIT to ata.h
>   2. Make ide's own set of task flags, maybe IDE_TFLAG_* (including
>      IDE_TFLAG_LBA48)

Please add it to <ata.h> (unless Jeff complains loudly),
I have a patch converting ide_task_t to use struct ata_taskfile
(except ->protocol for now).

Bartlomiej
