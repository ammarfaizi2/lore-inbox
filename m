Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUIWTQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUIWTQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUIWTQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:16:37 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:63689 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268218AbUIWTQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:16:34 -0400
Date: Thu, 23 Sep 2004 21:18:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
Message-ID: <20040923191819.GA30482@elte.hu>
References: <20040923103723.GA12145@mail.muni.cz> <E1CARaS-00071j-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CARaS-00071j-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> > 
> > However there is still the issue with endless loop in fn_hash_delete :(
> 
> Same problem, same fix.  Can someone think of a generic fix to
> list_for_each_*?
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

did the trick here too.

on a related note, e100 ifup still gives:

enable_irq(16) unbalanced from c021afa5
 [<c01322a0>] enable_irq+0xd0/0xe0
 [<c021afa5>] e100_up+0xf5/0x1e0
 [<c021afa5>] e100_up+0xf5/0x1e0
 [<c021a500>] e100_intr+0x0/0x130
 [<c021c19d>] e100_open+0x2d/0x80
 [<c014741a>] handle_mm_fault+0x14a/0x1f0
 [<c02d9c55>] dev_open+0x85/0xa0
 [<c02ddc04>] dev_mc_upload+0x24/0x40
 [<c02db363>] dev_change_flags+0x53/0x130
 [<c0314bcb>] devinet_ioctl+0x26b/0x6c0
 [<c0317106>] inet_ioctl+0x66/0xb0
 [<c02d1019>] sock_ioctl+0xc9/0x290
 [<c0169eda>] sys_ioctl+0xca/0x230
 [<c01140c0>] do_page_fault+0x0/0x6f0
 [<c01044c9>] sysenter_past_esp+0x52/0x71

this is with Andrew's current tree (x.bz2).

	Ingo
