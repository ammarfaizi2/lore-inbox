Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTKEIlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 03:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTKEIlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 03:41:13 -0500
Received: from ns.suse.de ([195.135.220.2]:41955 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262422AbTKEIlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 03:41:06 -0500
Date: Wed, 5 Nov 2003 09:40:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] fix rq->flags use in ide-tape.c
Message-ID: <20031105084004.GY1477@suse.de>
References: <200311041718.hA4HIBmv027100@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311041718.hA4HIBmv027100@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1413, 2003/11/04 08:01:30-08:00, B.Zolnierkiewicz@elka.pw.edu.pl
> 
> 	[PATCH] fix rq->flags use in ide-tape.c
> 	
> 	Noticed by Stuart_Hayes@Dell.com:

Guys, this is _way_ ugly. We definitely dont need more crap in ->flags
for private driver use, stuff them somewhere else in the rq. rq->cmd[0]
usage would be a whole lot better. This patch should never have been
merged. If each and every driver needs 5 private bits in ->flags,
well...

Was this even posted on linux-kernel for review?

> @@ -218,6 +223,11 @@
>  #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
>  #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
>  #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
> +#define REQ_IDETAPE_PC1 (1 << __REQ_IDETAPE_PC1)
> +#define REQ_IDETAPE_PC2 (1 << __REQ_IDETAPE_PC2)
> +#define REQ_IDETAPE_READ	(1 << __REQ_IDETAPE_READ)
> +#define REQ_IDETAPE_WRITE	(1 << __REQ_IDETAPE_WRITE)
> +#define REQ_IDETAPE_READ_BUFFER	(1 << __REQ_IDETAPE_READ_BUFFER)


-- 
Jens Axboe

