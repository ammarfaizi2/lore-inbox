Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVLVNVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVLVNVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbVLVNVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:21:53 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:26580 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965148AbVLVNVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:21:53 -0500
Message-ID: <43AABA29.6948B18B@tv-sign.ru>
Date: Thu, 22 Dec 2005 17:37:29 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, tglx@linutronix.de, inaky.perez-gonzalez@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02] RT: add back plist docs
References: <1135202200.22970.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
>
> 	Add back copyrights, documentation, and function descriptions.

Thank you for doing that!

> + * This is a priority-sorted list of nodes; each node has a >= 0
> + * priority from 0 (highest) to INT_MAX (lowest).

Why >= 0 ? ->prio is just integer, it can be < 0.

                                                     The list itself has
> + * a priority too (the highest of all the nodes), stored in the head
> + * of the list (that is a node itself).

No, the head is not a node, and does not have ->prio field. It is easy
to get plist's priority:

	plist_empty(head) ? INT_MAX // or 0?
		: plist_last(head)->prio

> + * INT_MIN is the highest priority, 0 is the medium highest, INT_MAX
> + * is lowest priority.

This is right, but contradicts with 'each node has a >= 0 priority' above.

Actually I don't understand why should we talk about min/max at all.
plist is sorted by ->prio which is integer. That's all.

> + * plist_add - add @node to @head returns !0 if the plist prio changed, 0
> + * otherwise. XXX: Fix return code.
> + *
> + * @node:	&struct pl_node pointer
> + * @head:	&struct pl_head pointer
> + */
>  void plist_add(struct pl_node *node, struct pl_head *head)
>  {
>  	struct pl_node *iter;
> @@ -25,6 +48,12 @@ eq_prio:
>  	list_add_tail(&node->plist.node_list, &iter->plist.node_list);
>  }

> +/**
> + * plist_del - Remove a @node from plist. returns !0 if the plist prio
> + * changed, 0 otherwise. XXX: Fix return code.
> + *
> + * @node:	&struct pl_node pointer
> + */
>  void plist_del(struct pl_node *node)
>  {
>  	if (!list_empty(&node->plist.prio_list)) {

Both of them have 'void' return type.

Oleg.
