Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271222AbTHHGlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbTHHGlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:41:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:26824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271222AbTHHGlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:41:50 -0400
Date: Thu, 7 Aug 2003 23:43:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lou Langholtz <ldl@aros.net>
Cc: Paul.Clements@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
Message-Id: <20030807234346.12eb3724.akpm@osdl.org>
In-Reply-To: <3F334396.7030008@aros.net>
References: <3F2FE078.6020305@aros.net>
	<3F300760.8F703814@SteelEye.com>
	<3F303430.1080908@aros.net>
	<3F30510A.E918924B@SteelEye.com>
	<3F30AF81.4070308@aros.net>
	<3F332ED7.712DFE5D@SteelEye.com>
	<3F334396.7030008@aros.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz <ldl@aros.net> wrote:
>
> >+				spin_unlock(&lo->queue_lock);
>  >+				printk(KERN_DEBUG "%s: request %p: still in use (%d), waiting...\n",
>  >+				    lo->disk->disk_name, req, req->ref_count);
>  >+				schedule_timeout(HZ); /* wait a second */
>  >
>  Isn't there something more deterministic than just waiting a second and 
>  hoping things clear up that you can use here?

you'll be needing a set_current_state() before calling schedule_timeout()
anyway.  It will fall straight through as it is now.

