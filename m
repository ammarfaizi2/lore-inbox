Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVATQYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVATQYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVATQV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:21:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:56528 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262256AbVATQVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:21:01 -0500
Date: Thu, 20 Jan 2005 17:20:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, linux-kernel@vger.kernel.org,
       peterc@gelato.unsw.edu.au, tony.luck@intel.com, dsw@gelato.unsw.edu.au,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org, hch@infradead.org,
       wli@holomorphy.com, jbarnes@sgi.com
Subject: Re: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
Message-ID: <20050120162040.GA14002@elte.hu>
References: <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org> <Pine.LNX.4.58.0501200752280.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501200752280.8178@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> How about I just kill it now, so that it just doesn't exist, and the
> dust (from all the other things) can settle where it will?
> 
> In fact, I think I will remove the whole "rwlock_is_locked()" thing
> and the only user, since it's all clearly broken, and regardless of
> what we do it will be something else. That will at least fix the
> current problem, and only leave us doing too many bus accesses when
> BKL_PREEMPT is enabled.

in the 5-patch stream i just sent there's no need to touch exit.c, and
the debugging check didnt hurt. But if you remove it from spinlock.h now
then i'll probably have to regenerate the 5 patches again :-| We can:

 - nuke it afterwards

 - or can leave it alone as-is (it did catch a couple of bugs in the past)

 - or can change the rwlock_is_locked() to !write_can_lock() and remove
   rwlock_is_locked() [!write_can_lock() is a perfect replacement for 
   it].

i'd prefer #3.

	Ingo
