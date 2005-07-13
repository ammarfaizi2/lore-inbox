Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVGMPMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVGMPMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVGMPMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:12:16 -0400
Received: from mail0.lsil.com ([147.145.40.20]:29591 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262674AbVGMPMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:12:13 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C03157442@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Christoph Hellwig <hch@infradead.org>, Matt Domsch <Matt_Domsch@dell.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, Olaf Hering <olh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: RE: [PATCH 22/82] remove linux/version.h from drivers/message/fus
	 ion
Date: Wed, 13 Jul 2005 09:11:26 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 13, 2005 8:38 AM, Christoph Hellwig wrote:
> 
> > In general, this construct:
> > 
> > > > -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
> > > > -static int inline scsi_device_online(struct scsi_device *sdev)
> > > > -{
> > > > -	return sdev->online;
> > > > -}
> > > > -#endif
> > 
> > is better tested as:
> > 
> > #ifndef scsi_device_inline
> > static int inline scsi_device_online(struct scsi_device *sdev)
> > {
> >     return sdev->online;
> > }
> > #endif
> 
> Even better fusion should stop using this function because doing so
> is broken.. We tried that long ago but it got stuck somewhere.
>

Christoph - We have already fixed the problem long ago; e.g.
remember when you asked me to kill the timers from the eh threads.  
Thus in todays drivers you will not find scsi_device_online called anywhere
in 
the fusion drivers.

I only objected to killing the linux_compat.h file because its being used
in our internal supported drivers, and it makes it easier upgrade path
for maintaining mainstream drivers if that was left behind in the kernel
tree.
However everybody has ambushed me on this stance, so go ahead and kill it.
We'll manage fine without it.

Eric Moore

