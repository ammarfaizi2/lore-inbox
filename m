Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268007AbUHPWxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268007AbUHPWxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUHPWxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:53:18 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30592 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268007AbUHPWxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:53:03 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040816080745.GA18406@k3.hellgate.ch>
References: <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <1092612264.867.9.camel@krustophenia.net>
	 <20040816080745.GA18406@k3.hellgate.ch>
Content-Type: text/plain
Message-Id: <1092696835.13981.61.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 18:53:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 04:07, Roger Luethi wrote:
> On Sun, 15 Aug 2004 19:24:24 -0400, Lee Revell wrote:
> > Also, isn't there a better solution than for network drivers to actively 
> > poll for changes in link status?  Can't they just register a callback that 
> 
> For the Rhine, there is, but making it work requires some extra black
> magic we didn't know until a few months ago. It's fixed in -mm now and
> will probably be in 2.6.9. That doesn't mean the media_check is gone,
> though. It just means it only happens on actual events.
> 

OK, this would certainly be an improvement, I was using the driver from
-mm until 2.6.8.1 anyway due to that damn rhine_power_init bug, with no
problems whatsoever.

What do you think of Ingo's solution of trying to move the problematic
call to mdio_read out of the spinlocked section?  It does seem that the
slowness of mdio_read causes the rp->lock spinlock to be held for an
awfully long time.  In a live audio setting you would actually get lots
of media events.

Lee

