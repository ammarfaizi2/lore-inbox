Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVKEHAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVKEHAu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVKEHAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:00:50 -0500
Received: from drugphish.ch ([69.55.226.176]:14002 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751271AbVKEHAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:00:50 -0500
Message-ID: <436C5895.3040409@drugphish.ch>
Date: Sat, 05 Nov 2005 08:00:37 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <gcoady@gmail.com>
Subject: Re: Linux-2.4.31-hf8
References: <20051104231815.GA26093@alpha.home.local>
In-Reply-To: <20051104231815.GA26093@alpha.home.local>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Willy,

> This is the eighth hotfix for 2.4.31. OK, I know there was one not long ago,
> but a recent fix in IPVS which got merged into -hf7 left a refcnt problem in
> ip_vs_conn_expire_now, which can cause mid-term/long-term stability problems.
> I took this opportunity to merge a backport from 2.6 of another fix from Yan
> Zheng affecting multicast source filters.

Well, to be honest, Horms just found another IPVS "issue" :). It seems
we are getting into reviewing 2.4.x IPVS a bit more closely. The problem
is that if you have setups where the persistency timeout is below the
IPVS state machine related FIN_WAIT (not TCP state) timeout (currently
2*60*HZ) persistent templates will not be invalidated and the timer gets
re-set if a we still have a valid connection entry hashed. I've first
noted this somewhat aberrant behaviour in 2.2.x kernels but never got
around looking at it too closely because in 2.2.x we had a timer mess.

This issue however is absolutely minor since this buglet has been there
for ages already and we never received such a bug report. In fact, it
would be quite unusual to set a persistency timeout below fin_wait in a
LVS_DR setup for productive environments. And I didn't see it because I
set the FIN_WAIT to 10*HZ to relax sockets lingering. We can/will queue
it up, together with a small refcnt change for -hf9 and post 2.4.32.

I take it you read netdev as well, since we will post those patches
there. I'm delighted to see your -hf kernels since lately I have been
told off by a couple of kernel maintainers regarding 2.4.x, which we use
in about 100 of our boxes all over the world, about 300 still run 2.2.x
  and are slowly migrated to the now stable 2.4.x series. Doing business
in the finance sector really opts for stability, which is given by 2.4.x.

Have a nice weekend,
Roberto Nibali, ratz
-- 
echo
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
