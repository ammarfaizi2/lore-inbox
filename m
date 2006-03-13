Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWCMQcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWCMQcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWCMQcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:32:14 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:27277 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751357AbWCMQcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:32:13 -0500
Subject: Re: [PATCH 004 of 4] Make address_space_operations->invalidatepage
	return void
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1060312235331.15985@suse.de>
References: <20060313104910.15881.patches@notabene>
	 <1060312235331.15985@suse.de>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 10:32:11 -0600
Message-Id: <1142267531.9971.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 10:53 +1100, NeilBrown wrote:
> diff ./fs/jfs/jfs_metapage.c~current~ ./fs/jfs/jfs_metapage.c
> --- ./fs/jfs/jfs_metapage.c~current~    2006-03-09 17:29:35.000000000
> +1100
> +++ ./fs/jfs/jfs_metapage.c     2006-03-13 10:46:55.000000000 +1100
> @@ -578,14 +578,13 @@ static int metapage_releasepage(struct p
>         return 0;
>  }
>  
> -static int metapage_invalidatepage(struct page *page, unsigned long
> offset)
> +static void metapage_invalidatepage(struct page *page, unsigned long
> offset)
>  {
>         BUG_ON(offset);
>  
> -       if (PageWriteback(page))
> -               return 0;
> +       BUG_ON(PageWriteback(page));

I'm a little concerned about adding a BUG_ON for something this function
used to allow, but it looks like the BUG_ON is valid.  I'm asking myself
why did I add the test for PageWriteback in the first place.

>  
> -       return metapage_releasepage(page, 0);
> +       metapage_releasepage(page, 0);
>  }
>  
>  struct address_space_operations jfs_metapage_aops = { 

I'll try to stress test jfs with these patches to see if I can trigger
the an oops here.
-- 
David Kleikamp
IBM Linux Technology Center

