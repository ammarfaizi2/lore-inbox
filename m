Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVAXWUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVAXWUC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVAXWSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:18:03 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:37603 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261690AbVAXWNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:13:33 -0500
From: Elias da Silva <silva@aurigatec.de>
Organization: aurigatec Informationssysteme GmbH
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Date: Mon, 24 Jan 2005 23:10:00 +0100
User-Agent: KMail/1.7.2
References: <200501220327.38236.silva@aurigatec.de> <200501242059.06307.silva@aurigatec.de> <20050124203948.GR2707@suse.de>
In-Reply-To: <20050124203948.GR2707@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501242310.00184.silva@aurigatec.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:71cf304d62c8802a383a5ddf42c5bd08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 January 2005 21:39, you wrote:
[snip]
: > This is true for protected media because of the authentication
: > process needed between "host" 	and DVD device. IMHO,
: > the classification of the opcodes
: > 
: > 	a. GPCMD_SEND_KEY and
: > 	b. GPCMD_SET_STREAMING
: > 
: > as only "save for write" is wrong.
: 
: You need to explain why you think that is so, since this is the core of
: the argument. The only thing I can say is that perhaps SEND_KEY should
: even be root only, since it has a fairly large scope.

This is exactly the point: if the kernel wants to be safe, the
authentication procedure should be totally implemented in the kernel
and be protected against further changes via "alternative" ways...
but it isn't now and probably won't be although it could be.

On the other hand I don't think it is a good idea to let only
root read a video DVD an a Linux system.

[snip]
: > Furthermore, if you use
: > 	a. cdrom_ioctl (..., DVD_AUTH,...) instead of
: > 	b. cdrom_ioctl (..., CDROM_SEND_PACKET,...)
: > 	-> scsi_cmd_ioctl()-> sg_io()-> verify_command()
: > 
: > the same authentication procedure works as expected on a
: > RONLY opened device!
: 
: DVD_AUTH by-passes scsi_ioctl.c, so yes.
[snip]
:The problem is that it is policy, and it has to
: be restrictive to be safe.

Yes, and with this "alternative" way to to things in the kernel
a user can complete circumvent the restrictive policy now
implemented in verify_command(). So you are securing
the backdoor and leaving the frontdoor completely open, right?

Now if safety is top priority, than

  a. the authentication must be implemented by the kernel and

  b. there should be no other way to access the device and
	completely circumvent the policy enforcement.

or

we both agree, that in a situation where a user has exclusive
access to the device it would be OK to issue a SEND_KEY, even
if he uses RONLY mode for access.

It is as you wrote a silly situation but the current implementation
don't augment security but instead prevents "innocent" software
to continue to run.

Regards,

Elias
