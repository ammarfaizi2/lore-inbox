Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752548AbWAFUeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbWAFUeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbWAFUeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:34:03 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11684
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750714AbWAFUeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:34:00 -0500
Date: Fri, 06 Jan 2006 12:33:32 -0800 (PST)
Message-Id: <20060106.123332.109879608.davem@davemloft.net>
To: paulmck@us.ibm.com
Cc: dada1@cosmosbay.com, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060106202626.GA5677@us.ibm.com>
References: <20060106164702.GA5087@us.ibm.com>
	<43BEA693.5010509@cosmosbay.com>
	<20060106202626.GA5677@us.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@us.ibm.com>
Date: Fri, 6 Jan 2006 12:26:26 -0800

> If not, it may be worthwhile to limit the number of times that
> rt_run_flush() runs per RCU grace period.

This is mixing two sets of requirements.

rt_run_flush() runs periodically in order to regenerate the hash
function secret key.  Now, for that specific case it might actually be
possible to rehash instead of flush, but the locking is a little bit
tricky :-)  And also, I think we're regenerating the secret key
just a little bit too often, I think we'd get enough security
with a less frequent regeneration.

I'll look into this and your other ideas later today hopefully.
