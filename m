Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269964AbUJHAkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269964AbUJHAkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269899AbUJHAjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:39:33 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:22407 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269964AbUJHAew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:34:52 -0400
Message-ID: <4165E0A7.7080305@yahoo.com.au>
Date: Fri, 08 Oct 2004 10:34:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
References: <20041007142019.D2441@build.pdx.osdl.net> <20041007164044.23bac609.akpm@osdl.org>
In-Reply-To: <20041007164044.23bac609.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>This probably won't fix it.
>
>It looks like the code will lock up if all zones are out of unreclaimable
>memory, but you won't be hitting that.
>
>

Out of _reclaimable_ memory?

It shouldn't if all_unreclaimable is being set correctly.

>I also wonder if it'll lock up if just the first zone has ->all_unreclaimable.
>
>

Well, not if the all_unreclaimable flag is set, but if it should be and 
isn't,
then probably it will lock up.

>I think a good starting point here will be to revert the most recent
>change.
>

That may fix it for the simple fact that kswapd will just go through its
priority loop once then stop.

I think that resetting all_unreclaimable in free_pages_bulk is the wrong
idea though, because that will keep it clear if a bit of kernel memory is
being pinned and freed in the background, won't it?

I had a look and decided that all_unreclaimable should probably be cleared
only if vmscan.c frees some memory - but I couldn't really come up with any
hard numbers to back me up :P

