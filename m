Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUETPSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUETPSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 11:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUETPSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 11:18:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2235 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265141AbUETPSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 11:18:49 -0400
Date: Thu, 20 May 2004 17:19:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: overlaping printk
Message-ID: <20040520151939.GA3562@elte.hu>
References: <1XBEP-Mc-49@gated-at.bofh.it> <1XBXw-13D-3@gated-at.bofh.it> <1XWpp-zy-9@gated-at.bofh.it> <m3lljnnoa0.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3lljnnoa0.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> One alternative way would be to use locks with timeouts for these two
> locks (e.g. checking the TSC on x86, since the timer interrupt may not
> be running anymore) and only break the lock when the wait time is too
> long.
> 
> Of course serial lines can be quite slow so even that may not help
> always (for unknown reasons far too many people use 9600 baud for
> their serial line)

another solution would be to break the lock only once during the
kernel's lifetime. The system is messed up anyway if it needs multiple
lock breaks to get an oops out to the console. We dont care about
followup oopses - the first oops is that matters.

	Ingo
