Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWCWXoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWCWXoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWCWXoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:44:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422639AbWCWXoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:44:22 -0500
Date: Thu, 23 Mar 2006 15:46:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, micah@riseup.net, daniel@hozac.com
Subject: Re: [PATCH] mtd: fix broken name_to_dev_t() declaration
Message-Id: <20060323154625.16dfeb3f.akpm@osdl.org>
In-Reply-To: <20060323200205.GJ17981@MAIL.13thfloor.at>
References: <20060323200205.GJ17981@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> drivers/mtd/devices/blkmtd.c uses a local declaration
> of name_to_dev_t() which is inconsistant with the real
> one. the following patch fixes this by removing the 
> local declaration and including mount.h instead

OK..

Does that name_to_dev_t() call actually work?  In my experience,
name_to_dev_t() just doesn't work if called at times other than during
early boot.

#ifdef MODULE
	mode = (readonly) ? O_RDONLY : O_RDWR;
	bdev = open_bdev_excl(devname, mode, NULL);
#else
	mode = (readonly) ? FMODE_READ : FMODE_WRITE;
	bdev = open_by_devnum(name_to_dev_t(devname), mode);
#endif

OK, I guess it still works at initcall-time.  Still, the code is a bit,
err, innovative.

