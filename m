Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbUKILhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUKILhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUKILbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:31:49 -0500
Received: from mx1.elte.hu ([157.181.1.137]:41413 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261477AbUKILU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:20:58 -0500
Date: Tue, 9 Nov 2004 13:22:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Amit Shah <amit.shah@codito.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT-V0.7.22 Bug with fbdev and e100
Message-ID: <20041109122242.GA25077@elte.hu>
References: <200411091623.51495.amit.shah@codito.com> <20041109121330.GA23533@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109121330.GA23533@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> [...] This will reduce the utility of fbcon when debugging kernel
> crashes, but it should avoid this assert [...]

in fact the way i implemented it in my tree:

#define in_atomic_rt()  (!oops_in_progress && (in_atomic() || irqs_disabled()))

still enables crash messages to make it to fbcon. So the only thing
skipped will be non-fatal messages printed from 'raw' critical sections.
(which are very rare in PREEMPT_RT kernels).

	Ingo
