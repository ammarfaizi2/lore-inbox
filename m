Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282280AbRKZTVP>; Mon, 26 Nov 2001 14:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282381AbRKZTTt>; Mon, 26 Nov 2001 14:19:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4481 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282413AbRKZTTH>;
	Mon, 26 Nov 2001 14:19:07 -0500
Date: Mon, 26 Nov 2001 11:18:54 -0800 (PST)
Message-Id: <20011126.111854.102567147.davem@redhat.com>
To: mingo@elte.hu
Cc: velco@fadata.bg, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Scalable page cache
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>
In-Reply-To: <87vgfxqwd3.fsf@fadata.bg>
	<Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Mon, 26 Nov 2001 22:09:02 +0100 (CET)
   
   something like this:
   
   - #define SetPageReferenced(page)    set_bit(PG_referenced, &(page)->flags)
   + #define SetPageReferenced(page) \
   +	if (!test_bit(PG_referenced), &(page)->flags) \
   +		set_bit(PG_referenced, &(page)->flags)
   
On some platforms all the {test_,}{clear,change,set}_bit() ops give
you this cache behavior.  How hard would it be to make ix86 act
similarly?
