Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282447AbRKZTsp>; Mon, 26 Nov 2001 14:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282445AbRKZTra>; Mon, 26 Nov 2001 14:47:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:3333 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282435AbRKZTqa>; Mon, 26 Nov 2001 14:46:30 -0500
Message-ID: <3C029BE0.2BEA2264@zip.com.au>
Date: Mon, 26 Nov 2001 11:45:36 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mingo@elte.hu, velco@fadata.bg, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>,
		<87vgfxqwd3.fsf@fadata.bg>
		<Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain> <20011126.111854.102567147.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Ingo Molnar <mingo@elte.hu>
>    Date: Mon, 26 Nov 2001 22:09:02 +0100 (CET)
> 
>    something like this:
> 
>    - #define SetPageReferenced(page)    set_bit(PG_referenced, &(page)->flags)
>    + #define SetPageReferenced(page) \
>    +    if (!test_bit(PG_referenced), &(page)->flags) \
>    +            set_bit(PG_referenced, &(page)->flags)
> 
> On some platforms all the {test_,}{clear,change,set}_bit() ops give
> you this cache behavior.  How hard would it be to make ix86 act
> similarly?

It would be nice to have a full complement of non-atomic
bitops.  At present we have __set_bit, but no __clear_bit, etc.

So we often do buslocked RMW's in places where it's not needed.

-
