Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbUK0AuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUK0AuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbUKZXzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:55:52 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263112AbUKZToz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:44:55 -0500
Date: Thu, 25 Nov 2004 16:00:15 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch, 2.6.10-rc2] floppy boot-time detection fix
Message-ID: <20041125150015.GA3844@devserv.devel.redhat.com>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041124112745.GA3294@elte.hu> <21889.195.245.190.93.1101377024.squirrel@195.245.190.93> <20041125120133.GA22431@elte.hu> <20041125143337.GA32051@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125143337.GA32051@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 03:33:37PM +0100, Ingo Molnar wrote:
> --- linux/drivers/block/floppy.c.orig
> +++ linux/drivers/block/floppy.c
> @@ -4504,6 +4578,13 @@ int __init floppy_init(void)
>  		floppy_track_buffer = NULL;
>  		max_buffer_sectors = 0;
>  	}
> +	/*
> +	 * Small 10 msec delay to let through any interrupt that
> +	 * initialization might have triggered, to not
> +	 * confuse detection:
> +	 */
> +	current->state = TASK_UNINTERRUPTIBLE;
> +	schedule_timeout(HZ/100 + 1);


how about using msleep() ?
