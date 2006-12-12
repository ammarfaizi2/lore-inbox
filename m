Return-Path: <linux-kernel-owner+w=401wt.eu-S932782AbWLLVC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbWLLVC3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932845AbWLLVBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:01:52 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:3297 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932808AbWLLVBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:01:51 -0500
Date: Wed, 13 Dec 2006 08:00:53 +1100
From: Herbert Xu <herbert.xu@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] netpoll: fix netpoll lockup
Message-ID: <20061212210053.GB11713@gondor.apana.org.au>
References: <20061212101656.GA5064@elte.hu> <Pine.LNX.4.64.0612120811180.6452@woody.osdl.org> <20061212162042.GA18359@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212162042.GA18359@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 05:20:42PM +0100, Ingo Molnar wrote:
> 
> the first half of it is still needed - find the delta patch ontop of 
> current -git below.

The unlock in the else branch is definitely needed.  However, since
queue_process is always run from process context we don't need the
IRQ disabling.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
