Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317203AbSFHCmE>; Fri, 7 Jun 2002 22:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSFHCmD>; Fri, 7 Jun 2002 22:42:03 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:29744 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317203AbSFHCmC>;
	Fri, 7 Jun 2002 22:42:02 -0400
Date: Sat, 8 Jun 2002 05:40:30 +0300
From: Dan Aloni <da-x@gmx.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More list_del_init cleanups
Message-ID: <20020608024030.GA18037@callisto.yi.org>
In-Reply-To: <3CFEDE73.80202@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 12:00:51AM -0400, Brian Gerst wrote:
> Clean up some other instances of list_del + INIT_LIST_HEAD.
> 
> --
> 				Brian Gerst
[snip]
> -		        list_del(&entry->hash);
> -			INIT_LIST_HEAD(&entry->hash);
> +		        list_del_init(&entry->hash);
>  			list_del(&entry->list);
>  			list_add(&entry->list, dispose);
>  			continue;


If we are at it, how about replacing:

	list_del(&entry->list);
	list_add(&entry->list, dispose);
	
with something like:

	list_del_add(&entry->list, dispose);
	
	
-- 
Dan Aloni
da-x@gmx.net
