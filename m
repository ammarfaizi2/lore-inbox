Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRA3IcS>; Tue, 30 Jan 2001 03:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRA3IcI>; Tue, 30 Jan 2001 03:32:08 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:35185
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129172AbRA3IcG>; Tue, 30 Jan 2001 03:32:06 -0500
Date: Tue, 30 Jan 2001 09:31:59 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11)
Message-ID: <20010130093159.A3298@jaquet.dk>
In-Reply-To: <rasmus@jaquet.dk> <13240.980842736@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <13240.980842736@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Tue, Jan 30, 2001 at 08:18:56AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 08:18:56AM +0000, David Howells wrote:
> >...
> > +	spin_lock(&mm->page_table_lock);
> >  	mm->rss++;
> > +	spin_unlock(&mm->page_table_lock);
> >...
> 
> Would it not be better to use some sort of atomic add/subtract/clear operation
> rather than a spinlock? (Which would also give you fewer atomic memory access
> cycles).

This will unfortunately not do for all platforms. Please read
http://marc.theaimsgroup.com/?t=97630768100003&w=2&r=1 for the
last discussion of this.

Regards,
  Rasmus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
