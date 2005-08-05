Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVHEWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVHEWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVHEV5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:57:32 -0400
Received: from ns.suse.de ([195.135.220.2]:61146 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261985AbVHEV4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:56:51 -0400
Date: Fri, 5 Aug 2005 23:56:50 +0200
From: Andi Kleen <ak@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, John B?ckstrand <sandos@home.se>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: lockups with netconsole on e1000 on media insertion
Message-ID: <20050805215650.GH8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <20050805201215.GG7425@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805201215.GG7425@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I still don't like this fix. Yes, you're right, it should eventually
> give up. But here it gives up way too easily - 5 could easily
> translate to 5 microseconds. This is analogous to giving up on serial
> transmit if CTS is down for 5 loops.
> 
> I'd be much happier if there were some udelay or the like in here so
> that we're not giving up on such a short timeframe.

Problem is that it could translate to a long aggregate delay
e.g. when the kernel tries to dump the backlog after console_init.
That is why I made the delay so short.

Longer delay would be possible, but then it would need some logic
to detect down links and don't delay on them and then retry later etc. 
Would be all far more complicated.

-Andi
