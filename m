Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVJTWxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVJTWxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVJTWxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:53:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38619 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932532AbVJTWxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:53:24 -0400
Date: Fri, 21 Oct 2005 00:53:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, arjan@infradead.org, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8 bits
Message-ID: <20051020225347.GA29303@elte.hu>
References: <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org> <434BEA0D.9010802@cosmosbay.com> <20051017000343.782d46fc.akpm@osdl.org> <1129533603.2907.12.camel@laptopd505.fenrus.org> <20051020215047.GA24178@elte.hu> <Pine.LNX.4.64.0510201455030.10477@g5.osdl.org> <20051020220228.GA26247@elte.hu> <Pine.LNX.4.64.0510201512480.10477@g5.osdl.org> <20051020222703.GA28221@elte.hu> <20051020154457.100b5565.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020154457.100b5565.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> spin_lock is still uninlined.

yes, and that should stay so i believe, for text size reasons. The BTB 
should eliminate most effects of the call+ret itself.

> as is spin_lock_irqsave() and spin_lock_irq()

yes, for them the code length is even higher.

> uninlining spin_lock will probably increase overall text size, but 
> mainly in the out-of-line section.

you mean inlining it again? I dont think we should do it.

> read_lock is out-of-line.  read_unlock is inlined
> 
> write_lock is out-of-line.  write_unlock is out-of-line.

hm, with my patch, write_unlock should be inlined too.

	Ingo
