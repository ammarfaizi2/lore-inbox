Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWACVe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWACVe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWACVe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:34:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:39893 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964928AbWACVe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:34:27 -0500
Message-ID: <43BAEDDD.8080805@austin.ibm.com>
Date: Tue, 03 Jan 2006 15:34:21 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Patch] New zone ZONE_EASY_RECLAIM take 4. (disable gfp_easy_reclaim
 bit)[5/8]
References: <20051220173013.1B10.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20051220173013.1B10.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ===================================================================
> --- zone_reclaim.orig/fs/pipe.c	2005-12-16 18:36:20.000000000 +0900
> +++ zone_reclaim/fs/pipe.c	2005-12-16 19:15:35.000000000 +0900
> @@ -284,7 +284,7 @@ pipe_writev(struct file *filp, const str
>  			int error;
>  
>  			if (!page) {
> -				page = alloc_page(GFP_HIGHUSER);
> +				page = alloc_page(GFP_HIGHUSER & ~__GFP_EASY_RECLAIM);
>  				if (unlikely(!page)) {
>  					ret = ret ? : -ENOMEM;
>  					break;

That is a bit hard to understand.  How about a new GFP_HIGHUSER_HARD or 
somesuch define back in patch 1, then use it here?


