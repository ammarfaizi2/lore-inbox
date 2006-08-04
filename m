Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWHDFWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWHDFWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWHDFWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:22:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030238AbWHDFWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:22:11 -0400
Date: Thu, 3 Aug 2006 22:22:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Nate Diller" <nate.diller@gmail.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] [2/3] add list_merge to list.h
Message-Id: <20060803222204.f369e6da.akpm@osdl.org>
In-Reply-To: <5c49b0ed0608031915g2c1fc44ch623a7657b994bf9c@mail.gmail.com>
References: <5c49b0ed0608031915g2c1fc44ch623a7657b994bf9c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 19:15:15 -0700
"Nate Diller" <nate.diller@gmail.com> wrote:

> +/**
> + * list_merge - merge two headless lists
> + * @list: the new list to merge.
> + * @head: the place to add it in the first list.
> + *
> + * This is similar to list_splice(), except it merges every item onto @list,
> + * not excluding @head itself.  It is a noop if @head already immediately
> + * preceeds @list.

"precedes"

> + */
> +static inline void list_merge(struct list_head *list, struct list_head *head)
> +{
> +	struct list_head *last = list->prev;
> +	struct list_head *at = head->next;
> +
> +	list->prev = head;
> +	head->next = list;
> +
> +	last->next = at;
> +	at->prev = last;
> +}

Interesting.  I didn't realise that none of the existing functions could do
this.  I wonder if we can flesh the comment out a bit: define "headless" a
little more verbosely.

Should we call it list_splice_headless() or something?  list_merge is a bit
vague.

