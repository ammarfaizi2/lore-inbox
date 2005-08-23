Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVHWRqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVHWRqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVHWRqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:46:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29669
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932243AbVHWRqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:46:48 -0400
Date: Tue, 23 Aug 2005 10:46:40 -0700 (PDT)
Message-Id: <20050823.104640.25158087.davem@davemloft.net>
To: arjan@infradead.org
Cc: tedu@coverity.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: some missing spin_unlocks
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1124818806.3218.20.camel@laptopd505.fenrus.org>
References: <1124816044.3218.18.camel@laptopd505.fenrus.org>
	<20050823.103010.51024114.davem@davemloft.net>
	<1124818806.3218.20.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: some missing spin_unlocks
Date: Tue, 23 Aug 2005 19:40:06 +0200

> On Tue, 2005-08-23 at 10:30 -0700, David S. Miller wrote:
> > From: Arjan van de Ven <arjan@infradead.org>
> > Date: Tue, 23 Aug 2005 18:54:03 +0200
> > 
> > > does it matter? can ANYTHING be spinning on the lock? if not .. can we
> > > just let the lock go poof and not unlock it... 
> > 
> > I believe socket lookup can, otherwise the code is OK as-is.
> 
> lookup while the object is in progress of being destroyed sounds really
> bad though....

This happens all the time with TCP sockets, for example.
When we're trying to kill off a socket which is in time
wait state, the receive path can find it, grab a reference,
and process a packet against it right as we're trying to
kill it off.

This is completely normal.
