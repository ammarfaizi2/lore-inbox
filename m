Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTEGQMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264121AbTEGQMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:12:15 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:9935 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264120AbTEGQMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:12:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Date: Wed, 7 May 2003 18:20:31 +0200
User-Agent: KMail/1.5.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20030507104008$12ba@gated-at.bofh.it> <200305071746.15908.arnd@arndb.de> <20030507160726.GM823@suse.de>
In-Reply-To: <20030507160726.GM823@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305071820.31898.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 18:07, Jens Axboe wrote:
> On Wed, May 07 2003, Arnd Bergmann wrote:
> > No, it has indeed been possible to build scsi as a module for a long
> > time and in that case, scsi_ioctl becomes part of that module. The same
> > problem also exists for any user of register_ioctl32_conversion(), e.g.
> > ieee1394.
>
> drivers/block/scsi_ioctl.c is not part of the scsi layer, it provides
> generic SG_IO functionality for scsi-like block drivers.

Ok, sorry about the confusion. I was thinking of drivers/scsi/scsi_ioctl.c
all the time. However, the problem I meant is still present in the patch
for drivers/serial/core.c, which does get built as a module, and potentially
in any other module. Note that the whole purpose of
register_ioctl32_conversion() is to be able to put the wrappers in modules:
If you put your wrapper function in a file that is never a module, you
can simply put HANDLE_IOCTL(FOO, compat_foo) in include/linux/compat_ioctl.h.

	Arnd <><
