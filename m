Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUG0IBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUG0IBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUG0IBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:01:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12683 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266327AbUG0IBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:01:08 -0400
Date: Tue, 27 Jul 2004 10:01:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J4
Message-ID: <20040727080127.GA6988@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040727053338.GE1433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727053338.GE1433@suse.de>
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


[i've sent a second patch too since the first version.]

* Jens Axboe <axboe@suse.de> wrote:

> I don't like it. First of all, the implementation really should drain
> the queue first, then set max value before allowing people to queue
> more io. The queue lock doesn't help here, readers don't even attempt
> to serialize access to max_sectors. 

why should the queue be drained? There might be a few leftover big
requests, but these are not a problem.

> Secondly, I don't like the concept of exposing this value. If you want
> to do something like this, we must split the value into two like
> proposed (and patched) some months ago into a hardware and user value.

yes, agreed - that's what the second patch does.

> I don't see why we can't just drop ata48 default value to 256kb
> instead. There's very little command over head on ide, I bet the
> majority of the change in performance when playing with 256kb vs
> 1024kb is not the command overhead itself, rather things like
> read-ahead that could be more intelligent.

256kb isnt enough from a latency POV either - and if a user wants some
extreme setting like 16KB per request why not allow it? Especially since
these tunables cause zero runtime overhead.

	Ingo
