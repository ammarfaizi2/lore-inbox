Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbSJDOQe>; Fri, 4 Oct 2002 10:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbSJDOQe>; Fri, 4 Oct 2002 10:16:34 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:28591 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261809AbSJDOQd>; Fri, 4 Oct 2002 10:16:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
Date: Fri, 4 Oct 2002 08:48:52 -0500
X-Mailer: KMail [version 1.2]
Cc: Greg KH <greg@kroah.com>, Mark Peloquin <peloquin@us.ibm.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <OF9EDF8472.CDE2D9D8-ON85256C47.0080772B@pok.ibm.com> <02100319254700.00236@cygnus> <20021004145850.B30064@infradead.org>
In-Reply-To: <20021004145850.B30064@infradead.org>
MIME-Version: 1.0
Message-Id: <02100408485201.02266@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 08:58, Christoph Hellwig wrote:
> > +/**
> > + * list_member - tests whether a list member is currently on a list
> > + * @member:	member to evaulate
> > + */
> > +static inline int list_member(struct list_head *member)
> > +{
> > +	return ((!member->next || !member->prev) ? 0 : 1);
>
> Wouldn't return (member->next && member->prev); be simpler?

Sure. New patch below with new list_member() function.

> > + */
> > +#define list_for_each_entry_safe(pos, n, head, member)			\
> > +	for (pos = list_entry((head)->next, typeof(*pos), member),	\
> > +		n = list_entry(pos->member.next, typeof(*pos), member);	\
> > +	     &pos->member != (head);					\
> > +	     pos = n,							\
> > +		n = list_entry(pos->member.next, typeof(*pos), member))
>
> Identation looks a little strange..

Perhaps. But there are plenty of places in list.h that have some strange
indenting. If you'd like it another way, please post a patch with your
preferred version.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/

