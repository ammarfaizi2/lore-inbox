Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVI0As1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVI0As1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 20:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVI0As1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 20:48:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49847
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932173AbVI0As0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 20:48:26 -0400
Date: Mon, 26 Sep 2005 17:48:05 -0700 (PDT)
Message-Id: <20050926.174805.31061388.davem@davemloft.net>
To: kuznet@ms2.inr.ac.ru
Cc: greearb@candelatech.com, ja@ssi.bg, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Debugging neighbour.c: timers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050927003845.GA8273@ms2.inr.ac.ru>
References: <20050907.141847.95180907.davem@davemloft.net>
	<43387327.20006@candelatech.com>
	<20050927003845.GA8273@ms2.inr.ac.ru>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "A.N.Kuznetsov" <kuznet@ms2.inr.ac.ru>
Date: Tue, 27 Sep 2005 04:38:45 +0400

> Actually, when this code was written, add_timer() behaved differently,
> double add_timer() was prohibited and it printked
> "bug: kernel timer added twice at...".

Yes, it calls __mod_timer() now.  That's quite bad and
the debugging check should be re-added I think.

Is there some reason why we want add_timer() to behave like
__mod_timer(timer, timer->expires)?  I can't see any...

So perhaps we should add the simple BUG_ON(timer->pending) check to
include/linux/timer.h:add_timer()

add_timer_on() does this check btw....
