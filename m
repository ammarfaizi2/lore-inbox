Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA3I0G>; Tue, 30 Jan 2001 03:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129360AbRA3IZ5>; Tue, 30 Jan 2001 03:25:57 -0500
Received: from zeus.kernel.org ([209.10.41.242]:52964 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129172AbRA3IZu>;
	Tue, 30 Jan 2001 03:25:50 -0500
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11) 
In-Reply-To: Message from Rasmus Andersen <rasmus@jaquet.dk> 
   of "Mon, 29 Jan 2001 22:43:11 +0100." <20010129224311.H603@jaquet.dk> 
Date: Tue, 30 Jan 2001 08:18:56 +0000
Message-ID: <13240.980842736@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>...
> +	spin_lock(&mm->page_table_lock);
>  	mm->rss++;
> +	spin_unlock(&mm->page_table_lock);
>...

Would it not be better to use some sort of atomic add/subtract/clear operation
rather than a spinlock? (Which would also give you fewer atomic memory access
cycles).

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
