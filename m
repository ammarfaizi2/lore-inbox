Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVAXUCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVAXUCr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVAXUCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:02:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:43774 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261603AbVAXUCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:02:43 -0500
From: Elias da Silva <silva@aurigatec.de>
Organization: aurigatec Informationssysteme GmbH
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Date: Mon, 24 Jan 2005 20:59:06 +0100
User-Agent: KMail/1.7.2
References: <200501220327.38236.silva@aurigatec.de> <20050124083600.GA3347@suse.de>
In-Reply-To: <20050124083600.GA3347@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501242059.06307.silva@aurigatec.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:71cf304d62c8802a383a5ddf42c5bd08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jan 22 2005, Elias da Silva wrote:
> > Attached patch fixes a problem of reading Video DVDs
> > through the cdrom_ioctl interface. VMware is among
> > the prominent victims.
> > 
> > The bug was introduced in kernel version 2.6.8 in the
> > function verify_command().
> 
> It's not a bug, add write permission to the device for the user using
> the drive.
Hi.

The device already has write permission for the user using the
drive... and this is not the point.

The point is
	a. the user (program) wants to read a protected DVD,

	b. the user has permission to read the device,

	c. since kernel 2.6.8 the user can't use his right to read a
	DVD media, because according to verify_command() he is forced
	to open the device with RW mode instead of RONLY.

This is true for protected media because of the authentication
process needed between "host" 	and DVD device. IMHO,
the classification of the opcodes

	a. GPCMD_SEND_KEY and
	b. GPCMD_SET_STREAMING

as only "save for write" is wrong.

Furthermore, if you use
	a. cdrom_ioctl (..., DVD_AUTH,...) instead of
	b. cdrom_ioctl (..., CDROM_SEND_PACKET,...)
	-> scsi_cmd_ioctl()-> sg_io()-> verify_command()

the same authentication procedure works as expected on a
RONLY opened device!

Please rethink your decisions introduced with verify_command()
and make for example VMware work _again_ with Video DVDs.

Regards,

Elias

