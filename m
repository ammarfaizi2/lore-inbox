Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWBHCNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWBHCNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWBHCNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:13:13 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:20704 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030444AbWBHCNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:13:12 -0500
From: Grant Coady <gcoady@gmail.com>
To: Pradeep Vincent <pradeep.vincent@gmail.com>
Cc: Willy Tarreau <willy@w.ods.org>, "David S. Miller" <davem@davemloft.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.4.32 - Neighbour Cache (ARP) State machine bug Fixed
Date: Wed, 08 Feb 2006 13:13:09 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <4skiu150r13a2a78i68bg28cvdb67a8qjb@4ax.com>
References: <9fda5f510511281257o364acb3gd634f8e412cd7301@mail.gmail.com> <9fda5f510602031806j2f9ef743t206c9ee2c3bef384@mail.gmail.com> <20060203.181839.104353534.davem@davemloft.net> <9fda5f510602062357n38292cebk3c5738ccdbee83@mail.gmail.com> <20060207215341.GC11380@w.ods.org> <9fda5f510602071750o53f76fc8gc94c280a9998343d@mail.gmail.com>
In-Reply-To: <9fda5f510602071750o53f76fc8gc94c280a9998343d@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006 17:50:03 -0800, Pradeep Vincent <pradeep.vincent@gmail.com> wrote:

>One more attempt. Attaching the diff file as well.
>
>Signed off by: Pradeep Vincent <pradeep.vincent@gmail.com>
>
>--- old/net/core/neighbour.c    Wed Nov  9 16:48:10 2005
>+++ new/net/core/neighbour.c    Tue Feb  7 17:38:26 2006
>@@ -14,6 +14,7 @@
>  *     Vitaly E. Lavrov        releasing NULL neighbor in neigh_add.
>  *     Harald Welte            Add neighbour cache statistics like rtstat
>  *     Harald Welte            port neighbour cache rework from 2.6.9-rcX
>+ *     Pradeep Vincent         fix neighbour cache state machine
>  */
>
> #include <linux/config.h>
>@@ -705,6 +706,13 @@
>                        neigh_release(n);
>                        continue;
>                }
>+               /* Move to NUD_STALE state */
>+               if (n->nud_state&NUD_REACHABLE &&
>+                   now - n->confirmed > n->parms->reachable_time) {

Hmm, you're suffering tab -> space conversion syndrome :(

Grant.
