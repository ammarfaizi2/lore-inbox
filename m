Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTBXWzM>; Mon, 24 Feb 2003 17:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBXWzM>; Mon, 24 Feb 2003 17:55:12 -0500
Received: from dial-ctb05215.webone.com.au ([210.9.245.215]:10756 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S263204AbTBXWzK>;
	Mon, 24 Feb 2003 17:55:10 -0500
Message-ID: <3E5AA51F.20402@cyberone.com.au>
Date: Tue, 25 Feb 2003 10:05:03 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: anticipation is killing me
References: <Pine.LNX.4.44.0302242142570.1343-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0302242142570.1343-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>With 2.5.62-mm3 (not -mm2) I need small patch to can_start_anticipation.
>I've not studied the code, this patch may be the worst nonsense; and if
>it's at all mysterious to you, sorry, I probably won't be able to give
>more info until tomorrow...
>
>Hugh
>
>--- 2.5.62-mm3/drivers/block/as-iosched.c	Mon Feb 24 12:29:49 2003
>+++ linux/drivers/block/as-iosched.c	Mon Feb 24 21:38:39 2003
>@@ -856,7 +856,8 @@
> 		 */
> 		del_timer(&ad->antic_timer);
> 		ad->antic_status = ANTIC_FINISHED;
>-		blk_remove_plug(arq->request->q);
>+		if (arq)
>+			blk_remove_plug(arq->request->q);
> 		schedule_work(&ad->antic_work);
> 		return 0;
> 	}
>
No that makes sense. We want to remove the plug even if
arq is null however so I'll have to pass it in I suppose.

