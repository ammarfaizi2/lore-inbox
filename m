Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVCMJh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVCMJh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 04:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbVCMJh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 04:37:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11056 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261826AbVCMJhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 04:37:22 -0500
Date: Sun, 13 Mar 2005 09:35:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
In-Reply-To: <1110702194.6278.31.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0503130931140.15083@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com> 
    <20050311203427.052f2b1b.akpm@osdl.org> 
    <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com> 
    <1110702194.6278.31.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2005, Arjan van de Ven wrote:
> > 							\
> > +	if ((lock)->break_lock)						\
> > +		(lock)->break_lock = 0;					\
> >  }									\
> if it really worth an conditional there? the cacheline of the lock is
> made dirty anyway on unlock, so writing an extra 0 is like almost free
> (maybe half a cycle) while a conditional jump can be 100+....

I wondered the same, I don't know and would defer to those who do:
really I was just following the style of where break_lock is set above,
which follows soon (unless preempted) after a _raw_whatever_trylock.

Hugh
