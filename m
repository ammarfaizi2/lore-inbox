Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262015AbTCQXYj>; Mon, 17 Mar 2003 18:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbTCQXYj>; Mon, 17 Mar 2003 18:24:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:64191 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262015AbTCQXYi>;
	Mon, 17 Mar 2003 18:24:38 -0500
Date: Mon, 17 Mar 2003 15:28:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: wind@cocodriloo.com
Cc: bzzz@tmi.comex.ru, wind@cocodriloo.com, riel@surriel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-Id: <20030317152855.388b643f.akpm@digeo.com>
In-Reply-To: <20030317230839.GG11526@wind.cocodriloo.com>
References: <20030317151004.GR20188@holomorphy.com>
	<Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com>
	<20030317165223.GA11526@wind.cocodriloo.com>
	<m3hea2gcoz.fsf@lexa.home.net>
	<20030317140506.686282a5.akpm@digeo.com>
	<20030317230839.GG11526@wind.cocodriloo.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2003 23:34:43.0329 (UTC) FILETIME=[C98E9F10:01C2ECDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wind@cocodriloo.com wrote:
>
> > This is all a bit dubious for several reasons.  Most particularly, the
> > up-front instantiation of the pages in pagetables makes unneeded pages harder
> > to reclaim.  It would be really neat if someone could try putting the
> > madvise(MADV_WILLNEED) into glibc and test that.  Maybe on a 2.4 kernel.
> 
> 
> something like this one?
> 

No, not at all.  I meant a patch against glibc, not against the kernel!

Like this:

	map = mmap(..., PROT_EXEC, ...);
+	if (getenv("MAP_PREFAULT"))
+		madvise(map, length, MADV_WILLNEED);


