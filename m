Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132394AbRAYQuT>; Thu, 25 Jan 2001 11:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRAYQuJ>; Thu, 25 Jan 2001 11:50:09 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:36090 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S132264AbRAYQty>; Thu, 25 Jan 2001 11:49:54 -0500
Date: Thu, 25 Jan 2001 10:49:50 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Roman Zippel <roman@augan.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <3A705802.5C4DD2F2@augan.com>
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> 
	<20010123165117Z131182-221+34@kanga.kvack.org> ; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600 <20010125155345Z131181-221+38@kanga.kvack.org>
Subject: Re: ioremap_nocache problem?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Message-Id: <20010125165001Z132264-460+11@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Roman Zippel <roman@augan.com> on Thu, 25 Jan 2001
17:44:51 +0100


> set_bit(PG_reserved, &page->flags);
> 	ioremap();
> 	...
> 	iounmap();
> 	clear_bit(PG_reserved, &page->flags);

The problem with this is that between the ioremap and iounmap, the page is
reserved.  What happens if that page belongs to some disk buffer or user
process, and some other process tries to free it.  Won't that cause a problem?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
