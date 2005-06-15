Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVFOXlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVFOXlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFOXlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:41:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58261
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261669AbVFOXlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 19:41:23 -0400
Date: Wed, 15 Jun 2005 16:41:15 -0700 (PDT)
Message-Id: <20050615.164115.74747690.davem@davemloft.net>
To: ak@muc.de
Cc: cndougla@purdue.edu, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: TCP prequeue performance
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m1br679otj.fsf@muc.de>
References: <BED5FA3B.2A0%cndougla@purdue.edu>
	<m1br679otj.fsf@muc.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@muc.de>
Subject: Re: TCP prequeue performance
Date: Thu, 16 Jun 2005 01:34:48 +0200

> Chase Douglas <cndougla@purdue.edu> writes:
> >
> > I then disabled the prequeue mechanism by changing net/ipv4/tcp.c:1347 of
> > 2.6.11:
> >
> > if (tp->ucopy.task == user_recv) {
> >     to
> > if (0 && tp->ucopy.task == user_recv) {
> 
> You actually didn't disable it completely - it would still be filled. 

Not true, if this check does not pass, tp->ucopy.task is
never set, therefore prequeue processing is never performed.

This test must pass the first time, when both tp->ucopy.task
and user_recv are both NULL, in order for prequeue processing
to occur at all.

So his change did totally disable prequeue.
