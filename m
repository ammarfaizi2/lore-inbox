Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUCXAAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUCXAAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:00:38 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43677 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262931AbUCXAAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:00:37 -0500
Date: Wed, 24 Mar 2004 01:01:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.3 Posix scheduling violation for !SCHED_OTHER
Message-ID: <20040324000121.GA2321@elte.hu>
References: <20040323233554.GA24010@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323233554.GA24010@tsunami.ccur.com>
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


* Joe Korty <joe.korty@ccur.com> wrote:

> Andrew,
>  The following fixes a problem where a SCHED_FIFO task would on
> occasion be moved to the end of its runqueue when returned to from a
> preemption. Cause was do to some SCHED_OTHER code in schedule() which
> was being run for tasks of every policy.

yes, indeed this is a bug.

> -	if (next->activated > 0) {
> +	if (!rt_task(next) && next->activated > 0) {

the patch looks good. Andrew, please apply.

	Ingo
