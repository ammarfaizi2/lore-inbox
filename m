Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVCXRRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVCXRRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVCXRRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:17:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21453 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261580AbVCXRRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 12:17:12 -0500
Subject: Re: [PATCH 2.6.11] aoe [5/12]: don't try to free null bufpool
From: Arjan van de Ven <arjan@infradead.org>
To: ecashin@noserose.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg K-H <greg@kroah.com>,
       axboe@suse.de
In-Reply-To: <1111683853.31205@geode.he.net>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
	 <1111677437.28285@geode.he.net>
	 <1111679884.6290.93.camel@laptopd505.fenrus.org>
	 <1111683853.31205@geode.he.net>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 18:17:06 +0100
Message-Id: <1111684626.6290.103.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 09:04 -0800, ecashin@noserose.net wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > On Thu, 2005-03-24 at 07:17 -0800, ecashin@noserose.net wrote:
> >> don't try to free null bufpool
> >
> > in linux there is a "rule" that all memory free routines are supposed to
> > also accept NULL as argument, so I think this patch is not needed (and
> > even wrong)
> >
> 
> Hmm.  The mm/mempool.c:mempool_destroy function immediately
> dereferences the pointer passed to it:
> 
> void mempool_destroy(mempool_t *pool)
> {
> 	if (pool->curr_nr != pool->min_nr)
> 		BUG();		/* There were outstanding elements */
> 	free_pool(pool);
> }
> 
> ... so I'm not sure mempool_destroy fits the rule.  Are you suggesting
> that the patch should instead modify mempool_destroy?

hmm perhaps... Jens?

