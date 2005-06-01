Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVFAOfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVFAOfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVFAOfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:35:36 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:23741 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261381AbVFAOf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:35:26 -0400
Message-ID: <429DC99B.E88C6783@tv-sign.ru>
Date: Wed, 01 Jun 2005 18:43:39 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <Pine.LNX.4.10.10506010559050.23911-100000@godzilla.mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 
> On Wed, 1 Jun 2005, Ingo Molnar wrote:
> 
> > * Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> > > > existing_sp_head:
> > > >   itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
> > > >   list_add(&pl->sp_node, &itr_pl2->sp_node);
> > >
> > > This breaks fifo ordering.
> >
> > Daniel, is the issue (and other issues) Oleg noticed still present? I'm
> > still a bit uneasy about the complexity of the plist changes.
> 
> I think this one isn't right. We could make a test quite to check
> correctness. Find the errors before they find us. Oleg may even have
> something like that already half done.

Ok, I'll do the testing...

int main(void)
{
	struct plist head, node[3], *pos;
	int i;

	plist_init(&head, INT_MAX);

	for (i = 0; i < 3; ++i) {
		plist_init(node + i, 0);
		plist_add(node + i, &head);
	}

	plist_for_each(pos, &head)
		printf("fifo? %d\n", pos - node);

	return 0;
}

output:

fifo? 2
fifo? 1
fifo? 0

Oleg.
