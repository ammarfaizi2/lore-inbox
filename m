Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVBXP4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVBXP4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVBXPy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:54:26 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:20429 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262372AbVBXPum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:50:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uGmBNt9f3nOafykYoME8siRth/EXdWXlmYenJQsbKZWcxvnENmev4K+PsDBTUioe0LBseB6YLCqQY/B0LUrPtqSOyPy8WiChI+9X7G/FdAaDWot6F7PilTk6imOXDsHEnHLNVNVJgTdaPNb0oHlgQvKlPB1yBMejnccEBr4O1I4=
Message-ID: <58cb370e050224075040f5c031@mail.gmail.com>
Date: Thu, 24 Feb 2005 16:50:39 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 10/11] ide: make ide_cmd_ioctl() use TASKFILE
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050210083854.BD13DFBD@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083854.BD13DFBD@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +       in_valid->b.status_command      = 1;
> +       in_valid->b.error_feature       = 1;
> +       in_valid->b.nsector             = 1;

ide_end_drive_cmd() must be fixed first to respect ->tf_in_flags
and it must be done *without* affecting HDIO_DRIVE_TASKFILE.

>  extern int ide_driveid_update(ide_drive_t *);
> -extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
> +int ide_ata66_check(ide_drive_t *, ide_task_t *);
>  extern int ide_config_drive_speed(ide_drive_t *, u8);
>  extern u8 eighty_ninty_three (ide_drive_t *);
> -extern int set_transfer(ide_drive_t *, ide_task_t *);
> +int set_transfer(ide_drive_t *, ide_task_t *);
>  extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);

leftovers from previous version of the patch
