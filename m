Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288742AbSAYX1J>; Fri, 25 Jan 2002 18:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290826AbSAYX0y>; Fri, 25 Jan 2002 18:26:54 -0500
Received: from aldebaran.sra.com ([163.252.31.31]:59132 "EHLO
	aldebaran.sra.com") by vger.kernel.org with ESMTP
	id <S288742AbSAYX0d>; Fri, 25 Jan 2002 18:26:33 -0500
From: David Garfield <garfield@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15441.59731.568087.579456@irving.iisd.sra.com>
Date: Fri, 25 Jan 2002 18:25:07 -0500
To: Robert Love <rml@tech9.net>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] add BUG_ON to 2.4 #2
In-Reply-To: <1012000599.3799.85.camel@phantasy>
In-Reply-To: <1012000599.3799.85.camel@phantasy>
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
...
 > diff -urN linux-2.4.18-pre7/mm/vmscan.c linux/mm/vmscan.c
 > --- linux-2.4.18-pre7/mm/vmscan.c	Thu Jan 24 13:48:18 2002
 > +++ linux/mm/vmscan.c	Fri Jan 25 18:05:14 2002
...
 > @@ -354,10 +354,8 @@
 >  
 >  		page = list_entry(entry, struct page, lru);
 >  
 > -		if (unlikely(!PageLRU(page)))
 > -			BUG();
 > -		if (unlikely(PageActive(page)))
 > -			BUG();
 > +		BUG_ON(unlikely(!PageLRU(page)));
 > +		BUG_ON(unlikely(PageActive(page)))
 >  
 >  		list_del(entry);
 >  		list_add(entry, &inactive_list);
 > 


While I don't know the exact definitions, this works out to:

        if (unlikely(unlikely(!PageLRU(page)))) BUG();

which I doubt is a good idea.

--David Garfield
