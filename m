Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbVCXREp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbVCXREp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbVCXREk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:04:40 -0500
Received: from geode.he.net ([216.218.230.98]:43022 "HELO noserose.net")
	by vger.kernel.org with SMTP id S263121AbVCXRET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 12:04:19 -0500
From: ecashin@noserose.net
Message-Id: <1111683853.31205@geode.he.net>
Date: Thu, 24 Mar 2005 09:04:13 -0800
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Arjan van de Ven <arjan@infradead.org>, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.11] aoe [5/12]: don't try to free null bufpool
X-Draft-From: ("nntp+news.gmane.org:gmane.linux.kernel" 290230)
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
	<1111677437.28285@geode.he.net>
	<1111679884.6290.93.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Thu, 2005-03-24 at 07:17 -0800, ecashin@noserose.net wrote:
>> don't try to free null bufpool
>
> in linux there is a "rule" that all memory free routines are supposed to
> also accept NULL as argument, so I think this patch is not needed (and
> even wrong)
>

Hmm.  The mm/mempool.c:mempool_destroy function immediately
dereferences the pointer passed to it:

void mempool_destroy(mempool_t *pool)
{
	if (pool->curr_nr != pool->min_nr)
		BUG();		/* There were outstanding elements */
	free_pool(pool);
}

... so I'm not sure mempool_destroy fits the rule.  Are you suggesting
that the patch should instead modify mempool_destroy?

-- 
  Ed L Cashin <ecashin@coraid.com>
