Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVAGMvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVAGMvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVAGMvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:51:45 -0500
Received: from darwin.snarc.org ([81.56.210.228]:42113 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261394AbVAGMvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:51:44 -0500
Date: Fri, 7 Jan 2005 13:51:40 +0100
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][4/4] let's kill verify_area - convert kernel/printk.c to access_ok()
Message-ID: <20050107125140.GA2774@snarc.org>
References: <Pine.LNX.4.61.0501070207460.3430@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501070207460.3430@dragon.hygekrogen.localhost>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040907i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 02:18:55AM +0100, Jesper Juhl wrote:
> @@ -300,8 +300,8 @@ int do_syslog(int type, char __user * bu
>  		error = 0;
>  		if (!len)
>  			goto out;
> -		error = verify_area(VERIFY_WRITE,buf,len);
> -		if (error)
> +		error = access_ok(VERIFY_WRITE,buf,len);
> +		if (!error)

I would rather put the ! on access_ok
"if (!error)" is read as "if no error"

-- 
Vincent Hanquez
