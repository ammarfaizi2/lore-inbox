Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTLTDTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 22:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTLTDTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 22:19:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:33947 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263798AbTLTDTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 22:19:52 -0500
Date: Fri, 19 Dec 2003 19:20:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: Q@ping.be, linux-kernel@vger.kernel.org
Subject: Re: ext3 truncate bug in 2.6.0?
Message-Id: <20031219192042.47c6c690.akpm@osdl.org>
In-Reply-To: <20031219141420.GA21129@atrey.karlin.mff.cuni.cz>
References: <20031218210713.GA21777@ping.be>
	<20031219141420.GA21129@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
>   Hi,
> 
>   it seems there's really a problem - does attached patch fix it?
> 

I think it will - thanks for that.

> --- linux/fs/ext3/balloc.c	Fri Dec 19 15:09:19 2003
> +++ linux/fs/ext3/balloc.c	Fri Dec 19 15:10:18 2003
> @@ -517,7 +517,7 @@
>  		sbi->s_resuid != current->fsuid &&
>  		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
>  		*errp = -ENOSPC;
> -		return 0;
> +		goto out;
>  	}
>  
>  	/*
> 

