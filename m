Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVCMNwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVCMNwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 08:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCMNwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 08:52:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261173AbVCMNwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 08:52:20 -0500
Subject: Re: [PATCH] break_lock forever broken
From: Arjan van de Ven <arjan@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503130931140.15083@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com>
	 <20050311203427.052f2b1b.akpm@osdl.org>
	 <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com>
	 <1110702194.6278.31.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0503130931140.15083@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 14:52:11 +0100
Message-Id: <1110721931.6278.55.camel@laptopd505.fenrus.org>
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

On Sun, 2005-03-13 at 09:35 +0000, Hugh Dickins wrote:
> On Sun, 13 Mar 2005, Arjan van de Ven wrote:
> > > 							\
> > > +	if ((lock)->break_lock)						\
> > > +		(lock)->break_lock = 0;					\
> > >  }									\
> > if it really worth an conditional there? the cacheline of the lock is
> > made dirty anyway on unlock, so writing an extra 0 is like almost free
> > (maybe half a cycle) while a conditional jump can be 100+....
> 
> I wondered the same, I don't know and would defer to those who do:
> really I was just following the style of where break_lock is set above,
> which follows soon (unless preempted) after a _raw_whatever_trylock.

if the cacheline is dirtied previously it's just free to do the write so
I suggest to remove the conditional...


