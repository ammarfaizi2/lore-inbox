Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSK3WGW>; Sat, 30 Nov 2002 17:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSK3WGW>; Sat, 30 Nov 2002 17:06:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:16624 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261310AbSK3WGV>;
	Sat, 30 Nov 2002 17:06:21 -0500
Message-ID: <3DE93813.C8B61048@digeo.com>
Date: Sat, 30 Nov 2002 14:13:39 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       hugang <hugang@soulinfo.com>
Subject: Re: [BUG] ext3-orlov for 2.4
References: <20021130161618.GK2517@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2002 22:13:40.0141 (UTC) FILETIME=[BCABC5D0:01C298BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> HI all...
> 
> Tell me if this is correct. GCC-3.2 spits a wrning like this when
> building -jam, I did not noticed before:
> 
> ialloc.c: In function `ext3_new_inode':
> ialloc.c:546: warning: comparison between pointer and integer
> ialloc.c:682: warning: label `out' defined but not used
> ialloc.c:520: warning: `gdp' might be used uninitialized in this function
> 
> Line is question is:
>     if (gdp == -1)
>         goto fail;
> It comes from the orlov-allocator for ext3.

gdp will be NULL on failure.  The above code isn't right.

> Should not the structure be:
>     gdp = ext3_get_group_desc (sb, group, &bh2);
>     if (!gdp)
>         goto fail;

yes.
 
> Can anybody check 2.5 for this also ?
> 

Is OK.
