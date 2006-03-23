Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWCWXvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWCWXvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWCWXvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:51:46 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:61913 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1422729AbWCWXvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:51:46 -0500
Date: Fri, 24 Mar 2006 00:51:44 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, micah@riseup.net, daniel@hozac.com
Subject: Re: [PATCH] mtd: fix broken name_to_dev_t() declaration
Message-ID: <20060323235144.GB21324@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, micah@riseup.net, daniel@hozac.com
References: <20060323200205.GJ17981@MAIL.13thfloor.at> <20060323154625.16dfeb3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323154625.16dfeb3f.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 03:46:25PM -0800, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> > drivers/mtd/devices/blkmtd.c uses a local declaration
> > of name_to_dev_t() which is inconsistant with the real
> > one. the following patch fixes this by removing the 
> > local declaration and including mount.h instead
> 
> OK..
> 
> Does that name_to_dev_t() call actually work?  In my experience,
> name_to_dev_t() just doesn't work if called at times other than during
> early boot.
> 
> #ifdef MODULE
> 	mode = (readonly) ? O_RDONLY : O_RDWR;
> 	bdev = open_bdev_excl(devname, mode, NULL);
> #else
> 	mode = (readonly) ? FMODE_READ : FMODE_WRITE;
> 	bdev = open_by_devnum(name_to_dev_t(devname), mode);
> #endif
> 
> OK, I guess it still works at initcall-time.  Still, the code is a bit,
> err, innovative.

ah, well, I was not judging the mtd code ... 
just fixing an issue which popped up :)

best,
Herbert

