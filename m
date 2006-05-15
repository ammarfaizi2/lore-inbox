Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWEOUpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWEOUpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWEOUpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:45:05 -0400
Received: from stinky.trash.net ([213.144.137.162]:39890 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751502AbWEOUpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:45:03 -0400
Message-ID: <4468E84C.9000408@trash.net>
Date: Mon, 15 May 2006 22:45:00 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Frost <sfrost@snowman.net>
CC: Amin Azez <azez@ufomechanic.net>, "David S. Miller" <davem@davemloft.net>,
       willy@w.ods.org, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
References: <20060507.224339.48487003.davem@davemloft.net> <44643BFD.3040708@trash.net> <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com> <44647280.1030602@trash.net> <446490BB.10801@ufomechanic.net> <44683AFF.4070200@trash.net> <20060515142834.GL7774@kenobi.snowman.net> <4468CD3C.3000908@trash.net> <20060515192738.GN7774@kenobi.snowman.net> <4468DFF6.5020304@trash.net> <20060515204142.GO7774@kenobi.snowman.net>
In-Reply-To: <20060515204142.GO7774@kenobi.snowman.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Frost wrote:
> * Patrick McHardy (kaber@trash.net) wrote:
> 
>>This is the updated patch, it changes the eviction strategy
>>to LRU and fixes a bug related to TTL handling, the TTL stored
>>in the entry should only be overwritten if the IPT_RECENT_TTL
>>flag is set.
> 
> 
> This looks like least-recently-added as opposed to least-recently-used
> (or, really, least-recently-updated).  Not sure how you move an entry in
> the lru list (perhaps just delete/add?) but I'm pretty sure
> recent_entry_update() needs to be modified to move the updated entry to
> the end of the list for correct operation.


Good point, I'll fix the patch.

> You also don't appear to check if 't' (the table following the
> recent_table_lookup() call) is valid in the 'match' (around
> line 191).  recent_entry_lookup() doesn't check that either.  It seems
> like you should be guarenteed to always get a table back but it might be
> prudent to check anyway.


It is guaranteed that we will get a valid table back, otherwise
there must be a serious bug somewhere else, in which case I
prefer to crash instead of hiding it away.
