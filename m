Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTEGPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTEGPzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:55:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48831 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264087AbTEGPzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:55:05 -0400
Date: Wed, 7 May 2003 18:07:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030507160726.GM823@suse.de>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071518.25595.arnd@arndb.de> <20030507151613.GB412@elf.ucw.cz> <200305071746.15908.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305071746.15908.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, Arnd Bergmann wrote:
> On Wednesday 07 May 2003 17:16, Pavel Machek wrote:
> 
> > > Has anyone solved the register_ioctl32_conversion() from module problem
> > > yet? The patch will break if you build scsi as a module because you
> > > never unregister the conversion helper on unload.
> > > Even if you do the unregister from a module_exit() function, there
> > > will still be a small race against running ioctl handlers. I suppose
> > > we have to add an 'owner' field to struct ioctl_trans in order to
> > > get it right.
> >
> > Its in drivers/block/scsi_ioctl.c. AFAICS, its always compiled in, so
> > I'm not hitting that problem *yet*.
> 
> No, it has indeed been possible to build scsi as a module for a long
> time and in that case, scsi_ioctl becomes part of that module. The same 
> problem also exists for any user of register_ioctl32_conversion(), e.g.
> ieee1394.

drivers/block/scsi_ioctl.c is not part of the scsi layer, it provides
generic SG_IO functionality for scsi-like block drivers.

-- 
Jens Axboe

