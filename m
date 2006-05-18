Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWEREbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWEREbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWEREbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:31:34 -0400
Received: from xenotime.net ([66.160.160.81]:4046 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750701AbWEREbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:31:33 -0400
Date: Wed, 17 May 2006 21:34:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, chase.venters@clientec.com,
       nickpiggin@yahoo.com.au, kaos@ocs.com.au, akpm@osdl.org,
       clameter@sgi.com, fche@redhat.com, peterc@gelato.unsw.edu.au,
       hch@infradead.org, arjan@infradead.org, ak@suse.de
Subject: Re: [RFC] [Patch 1/6] statistics infrastructure - prerequisite:
 list operation
Message-Id: <20060517213401.b97cc0ee.rdunlap@xenotime.net>
In-Reply-To: <1147891845.3076.11.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1147891845.3076.11.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006 20:50:44 +0200 Martin Peschke wrote:

> This patch adds another list_for_each_* derivate. I can't work around it
> because there is a list that I need to search both ways.
> 
> Signed-off-by: Martin Peschke <mp3@de.ibm.com>
> ---
> 
>  list.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+)
> 
> diff -Nurp a/include/linux/list.h b/include/linux/list.h
> --- a/include/linux/list.h	2006-05-17 19:02:03.000000000 +0200
> +++ b/include/linux/list.h	2006-05-17 19:05:41.000000000 +0200
> @@ -411,6 +411,18 @@ static inline void list_splice_init(stru
>  	     pos = list_entry(pos->member.next, typeof(*pos), member))
>  
>  /**
> + * list_for_each_entry_continue_reverse -	iterate backwards over list
> + *			of given type continuing before existing point

kernel-doc function name and short description need to fit on one line.
(list.h has some other problems like that; I'll fix those up.)

> + * @pos:	the type * to use as a loop counter.
> + * @head:	the head for your list.
> + * @member:	the name of the list_struct within the struct.
> + */
> +#define list_for_each_entry_continue_reverse(pos, head, member) 	\
> +	for (pos = list_entry(pos->member.prev, typeof(*pos), member);	\
> +	     prefetch(pos->member.prev), &pos->member != (head);	\
> +	     pos = list_entry(pos->member.prev, typeof(*pos), member))
> +
> +/**
>   * list_for_each_entry_from -	iterate over list of given type
>   *			continuing from existing point
>   * @pos:	the type * to use as a loop counter.


---
~Randy
