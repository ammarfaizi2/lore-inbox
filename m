Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266690AbSKLRuY>; Tue, 12 Nov 2002 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266906AbSKLRuY>; Tue, 12 Nov 2002 12:50:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:28299 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266930AbSKLRuX>;
	Tue, 12 Nov 2002 12:50:23 -0500
Message-ID: <3DD140F1.F4AED387@digeo.com>
Date: Tue, 12 Nov 2002 09:57:05 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Mark Hazell <nutts@penguinmail.com>, adilger@clusterfs.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch/2.4] ll_rw_blk stomping on bh state [Re: kernel BUG at 
 journal.c:1732! (2.4.19)]
References: <20021028111357.78197071.nutts@penguinmail.com> <20021112150711.F2837@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Nov 2002 17:57:06.0413 (UTC) FILETIME=[E9DBC9D0:01C28A74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
>                 if (maxsector < count || maxsector - count < sector) {
>                         /* Yecch */
>                         bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
> 
> ...
> 
> Folks, just which buffer flags do we want to preserve in this case?
> 

Why do we want to clear any flags in there at all?  To prevent
a storm of error messages from a buffer which has a silly block
number?

If so, how about setting a new state bit which causes subsequent
IO attempts to silently drop the IO on the floor?
