Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWAaS4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWAaS4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWAaS4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:56:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11675 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751347AbWAaS4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:56:41 -0500
Date: Tue, 31 Jan 2006 19:57:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, davem@redhat.com
Subject: Re: [PATCH] 8139too: fix a TX timeout watchdog thread against NAPI softirq race
Message-ID: <20060131185714.GA24635@elte.hu>
References: <E1F2JFb-0007MW-00@gondolin.me.apana.org.au> <43D98915.6040004@pobox.com> <20060131002418.GA917@electric-eye.fr.zoreil.com> <20060131184957.GA22660@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131184957.GA22660@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Ingo's stealth lock validator detected that both thread acquire
> > dev->xmit_lock and tp->rx_lock in reverse order.
> > 
> > Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
> 
> i've ported this to -mm4 (see the attached patch), but i'm also 
> getting a new deadlock message. Seems to be a separate issue, not 
> introduced by your patch - but still needs fixing i guess.

sorry - this is a false alarm. (caused by the lock validator not 
properly handling DEBUG_SHIRQ)

	Ingo
