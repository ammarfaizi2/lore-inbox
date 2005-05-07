Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVEGHSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVEGHSe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 03:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVEGHSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 03:18:34 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:20356 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262744AbVEGHSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 03:18:30 -0400
Message-ID: <427C6D7D.878935F1@tv-sign.ru>
Date: Sat, 07 May 2005 11:25:49 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Priority Lists for the RT mutex
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Perez-Gonzalez, Inaky" wrote:
>
> >Oleg Nesterov wrote:
> >>
> >> Daniel Walker wrote:
> >> >
> >> > Description:
> >> > 	This patch adds the priority list data structure from Inaky Perez-Gonzalez
> >> > to the Preempt Real-Time mutex.
> >> >
> >> ...
> >And I think it is possible to simplify plist's design.
> >
> > ...
> >
> >lt_prio:
> >	list_add_tail(&new->prio_list, &pos->prio_list);
> >eq_prio:
> >	list_add_tail(&new->node_list, &pos->node_list);
> >}
>
> Isn't this adding them to *both* lists in the lt_prio
> case? I don't understand what do you want to accomplish
> in this case.

Yes. ->node_list contains *ALL* nodes, that is why we can:

	#define	plist_for_each(pos, head)	\
		 list_for_each_entry(pos, &(head)->node_list, node_list)

head <=======>  prio=1 <===> prio=2 <===> ...
                 /\        /|  /\
                 |         |   |
                 \/        |   \/
                prio=1     | prio=2
                 /\       /    /\
                 |       /     |
                 \/     /      \/
                prio=1 /      ....
                  <---/

                               /\
Where <===> means ->prio_list, |  ->node_list.
                               \/

Daniel Walker wrote:
>
> Make a patch .

Will do. However, I'm unfamiliar with Ingo's tree, so I
can send only new plist's implementation.

Oleg.
