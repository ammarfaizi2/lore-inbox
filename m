Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbWJXWGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWJXWGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWJXWGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:06:39 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:12196 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161221AbWJXWGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:06:39 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061024204239.GA15689@infradead.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <20061024204239.GA15689@infradead.org>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 08:06:36 +1000
Message-Id: <1161727596.22729.11.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-10-24 at 21:42 +0100, Christoph Hellwig wrote:
> On Mon, Oct 23, 2006 at 02:14:17PM +1000, Nigel Cunningham wrote:
> > Switch from bitmaps to using extents to record what swap is allocated;
> > they make more efficient use of memory, particularly where the allocated
> > storage is small and the swap space is large.
> >     
> > This is also part of the ground work for implementing support for
> > supporting multiple swap devices.
> 
> In addition to the very useful comments from Rafael there's some observations
> of my own:
> 
>  - there's an awful lot of opencoded list manipulation, any chance you
>    could use list.h instead?

IIRC, I avoided list.h because I only wanted a singly linked list (it
never gets traversed backwards). List.h looks to me like all doubly
linked lists. Do you know if there are any other singly linked list
implementations I could piggy-back?

That said, since there's normally not that many extents, I could switch
quite easily and it wouldn't normally waste much memory.

>  - what unit are the extent values in?  The usage of unsigned long rings
>    warning bells for me, shouldn't this be something like pgoff_t or
>    sector_t depending on what you describe with it?

For this use, they're swap extents. For another use I have in suspend2,
they're sector_t >> block_device_size. That's why I picked ul; something
generic in what's supposed to be a generic implementation.

Thanks for the comments.

Nigel

