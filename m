Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTJPRqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTJPRqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:46:15 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:47806
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S263077AbTJPRqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:46:11 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
References: <HbGf.8rL.1@gated-at.bofh.it> <HbQ5.ep.27@gated-at.bofh.it> <Hdyv.2Vd.13@gated-at.bofh.it> <HeE6.4Cc.1@gated-at.bofh.it> <HjaT.3nN.7@gated-at.bofh.it> <Hjkw.3Al.11@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 16 Oct 2003 10:46:10 -0700
In-Reply-To: <Hjkw.3Al.11@gated-at.bofh.it>
Message-ID: <ugzng1axel.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 16 Oct 2003 18:40:12 +0200, Jeff Garzik <jgarzik@pobox.com> said:

  Jeff> We don't need "low cost RNG" and "high cost RNG" in the same
  Jeff> kernel. That just begs a "reduce RNG cost" solution...  I
  Jeff> think security experts can easily come up with arguments as to
  Jeff> why creating your own "low-cost crappy PRNG" isn't needed --
  Jeff> you either need crypto-secure, or you don't.  If you don't,
  Jeff> then you could just as easily create an ascending 64-bit
  Jeff> number for your opaque filehandle, or use a hash value, or
  Jeff> some other solution that doesn't require an additional PRNG in
  Jeff> the kernel.

I don't think that's true.  For example, the perfmon module in ia64
needs a fast pseudo-random number generator in order to randomize
sampling intervals.  It doesn't have to be a great RNG (certainly not
crypto-secure), but it does have to have reasonable properties to
avoid statistical bias.  We have tried without in-kernel RNG and the
results were unusable (e.g., resetting the sampling intervals in
user-space was far too costly and not randomizing the sampling
intervals caused horrible bias).  The RNG we settled on for now is the
Carta's (see arch/ia64/lib/carta_random.S), which is quite fast and
compact (all of 19 machine instructions).

	--david
--
David Mosberger; 35706 Runckel Lane; Fremont, CA 94536; David.Mosberger@acm.org
