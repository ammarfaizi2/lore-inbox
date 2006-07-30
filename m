Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWG3Rcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWG3Rcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWG3Rcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:32:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:2007 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932376AbWG3Rcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:32:53 -0400
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FP in kernelspace
References: <44CC97A4.8050207@gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Jul 2006 19:32:50 +0200
In-Reply-To: <44CC97A4.8050207@gmail.com>
Message-ID: <p733bcj3sn1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

> I have a driver written for 2.4 + RT patches with FP support. I want
> it to work in 2.6. How to implement FP? Has anybody developped some
> "protocol" between KS and US yet? If not, could somebody point me, how
> to do it the best -- with low latency.
> The device doesn't generate irqs 

Doesn't sound like something that should be supported for mainline
then.

> So 2 questions are:
> 1) howto FP in kernel

You can use kernel_fpu_begin()/_end() around the FP code in the
kernel, but the real time people will probably hate you for it because
it disables preemption.

> 3) any way to have faster ticks (up to 5000Hz)?

There are plenty of interval timers in various hardware in a typical
system that can be used.  e.g. RTC is a common choice. Drawback is
that you might conflict with other users, especially in user space.
 
But please don't try to submit such a hack.

-Andi
