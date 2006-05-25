Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWEYFNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWEYFNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWEYFNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:13:21 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:65395 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964978AbWEYFNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:13:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VtWSyKej87wXzoiaHum85LcjyZwEd/wtN36QqKBzH3Edf67EDrAQbwD1pkRmiIKrRcCiFzRnrAz1cXdzH8otxOTog5+Df+Kru+RXalCfg0vmbRzBBoz4nnpewT3pcsw+bb36VEMmoKq4EmWA0H4PJl2EIKcAVoctD4JBVmiC9+k=  ;
Message-ID: <44753CEC.6090308@yahoo.com.au>
Date: Thu, 25 May 2006 15:13:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/33] readahead: support functions
References: <20060524111246.420010595@localhost.localdomain> <348469540.21464@ustc.edu.cn>
In-Reply-To: <348469540.21464@ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:

>+#ifdef CONFIG_ADAPTIVE_READAHEAD
>+
>+/*
>+ * The nature of read-ahead allows false tests to occur occasionally.
>+ * Here we just do not bother to call get_page(), it's meaningless anyway.
>+ */
>+static inline struct page *__find_page(struct address_space *mapping,
>+							pgoff_t offset)
>+{
>+	return radix_tree_lookup(&mapping->page_tree, offset);
>+}
>+
>+static inline struct page *find_page(struct address_space *mapping,
>+							pgoff_t offset)
>+{
>+	struct page *page;
>+
>+	read_lock_irq(&mapping->tree_lock);
>+	page = __find_page(mapping, offset);
>+	read_unlock_irq(&mapping->tree_lock);
>+	return page;
>+}
>  
>

Meh, this is just open-coded elsewhere in readahead.c; I'd either
open code it, or do a new patch to replace the existing callers.
find_page should be in mm/filemap.c, btw (or include/linux/pagemap.h).

>+
>+/*
>+ * Move pages in danger (of thrashing) to the head of inactive_list.
>+ * Not expected to happen frequently.
>+ */
>+static unsigned long rescue_pages(struct page *page, unsigned long nr_pages)
>  
>

Should probably be in mm/vmscan.c

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
