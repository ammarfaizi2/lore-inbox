Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbUBDAh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUBDAh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:37:27 -0500
Received: from peabody.ximian.com ([130.57.169.10]:3478 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266230AbUBDAhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:37:20 -0500
Subject: Re: 2.6.1 Scheduler Latency Measurements (Preemption
	diabled/enabled)
From: Robert Love <rml@tech9.net>
To: Christoph Stueckjuergen <christoph.stueckjuergen@siemens.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200402031724.17994.christoph.stueckjuergen@siemens.com>
References: <200402031724.17994.christoph.stueckjuergen@siemens.com>
Content-Type: text/plain
Message-Id: <1075855055.8022.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Tue, 03 Feb 2004 19:37:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-03 at 17:24 +0100, Christoph Stueckjuergen wrote:

> The results are:
> "loaded" system, 10.000 samples
> average scheduler latency (preemption enabled / disabled): 170 us / 232 us
> minimum scheduler latency (preemption enabled / disabled): 49 us / 43 us
> maximum scheduler latency (preemption enabled / disabled): 840 us / 1063 us
> 
> "unloaded" system, 10.000 samples
> average scheduler latency (preemption enabled / disabled): 50 us / 44 us
> minimum scheduler latency (preemption enabled / disabled): 46 us / 41 us
> maximum scheduler latency (preemption enabled / disabled): 233 us / 215 us
> 
> Any help in interpreting the data would be highly appreciated. Especially:
> - Why does preemption lead to a higher minimum scheduler latency in the loaded 
> case?
>
> - Why does preemption worsen scheduler latency on the unloaded system?

Overhead, I guess - the place where preemption ought to pay off is with
worst-case latency, where your results do show an improvement.

That said, I would of expected slightly better numbers.  Although, note
that you are not measuring latency, you are measuring jitter.

Latency is time actual minus time expected.  It thus requires some
notion of the absolute expected time.  Without hardware support you
generally cannot measure this.

Jitter is measuring the time between successive events subtracted by the
expected duration, e.g. actual duration minus expected duration.  It
requires no knowledge of the absolute time.

Jitter tends to approximate latency, so that is OK, but all it really
measures is the variance in results (the "jitter" between the
durations).

Most people mix the two up.

	Robert Love


