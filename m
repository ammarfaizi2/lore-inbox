Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTFJOFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTFJOE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:04:56 -0400
Received: from mail.zmailer.org ([62.240.94.4]:23711 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262884AbTFJOET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:04:19 -0400
Date: Tue, 10 Jun 2003 17:17:59 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Large files
Message-ID: <20030610141759.GU28900@mea-ext.zmailer.org>
References: <Pine.LNX.4.53.0306100952560.4080@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306100952560.4080@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 09:57:57AM -0400, Richard B. Johnson wrote:
> With 32 bit return values, ix86 Linux has a file-size limitation
> which is currently about 0x7fffffff. Unfortunately, instead of
> returning from a write() with a -1 and errno being set, so that
> a program can do something about it, write() executes a signal(25)
> which kills the task even if trapped. Is this one of those <expletive
> deleted> POSIX requirements or is somebody going to fix it?

  http://www.sas.com/standards/large.file/

#define SIGXFSZ    25    /* File size limit exceeded (4.2 BSD). */

from  fs/buffer.c:

        err = -EFBIG;
        limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
        if (limit != RLIM_INFINITY && size > (loff_t)limit) {
                send_sig(SIGXFSZ, current, 0);
                goto out;
        }
        if (size > inode->i_sb->s_maxbytes)
                goto out;


> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).

/Matti Aarnio
