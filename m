Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSJDNx3>; Fri, 4 Oct 2002 09:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261752AbSJDNx3>; Fri, 4 Oct 2002 09:53:29 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:36626 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261748AbSJDNx1>; Fri, 4 Oct 2002 09:53:27 -0400
Date: Fri, 4 Oct 2002 14:58:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Corry <kcorry@austin.rr.com>
Cc: Greg KH <greg@kroah.com>, Mark Peloquin <peloquin@us.ibm.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
Message-ID: <20021004145850.B30064@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kevin Corry <kcorry@austin.rr.com>, Greg KH <greg@kroah.com>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <OF9EDF8472.CDE2D9D8-ON85256C47.0080772B@pok.ibm.com> <20021003234430.GG2289@kroah.com> <02100319254700.00236@cygnus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02100319254700.00236@cygnus>; from kcorry@austin.rr.com on Thu, Oct 03, 2002 at 07:25:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> =========================================================
> diff -Naur linux-2.5.40a/include/linux/list.h linux-2.5.40b/include/linux/list.h
> --- linux-2.5.40a/include/linux/list.h	Tue Oct  1 02:05:48 2002
> +++ linux-2.5.40b/include/linux/list.h	Thu Oct  3 19:17:27 2002
> @@ -137,6 +137,15 @@
>  	return head->next == head;
>  }
>  
> +/**
> + * list_member - tests whether a list member is currently on a list
> + * @member:	member to evaulate
> + */
> +static inline int list_member(struct list_head *member)
> +{
> +	return ((!member->next || !member->prev) ? 0 : 1);

Wouldn't return (member->next && member->prev); be simpler?

> + */
> +#define list_for_each_entry_safe(pos, n, head, member)			\
> +	for (pos = list_entry((head)->next, typeof(*pos), member),	\
> +		n = list_entry(pos->member.next, typeof(*pos), member);	\
> +	     &pos->member != (head);					\
> +	     pos = n,							\
> +		n = list_entry(pos->member.next, typeof(*pos), member))
>  

Identation looks a little strange..

