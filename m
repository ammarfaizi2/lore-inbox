Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUJEIDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUJEIDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 04:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268955AbUJEIDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 04:03:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16324 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268954AbUJEIDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 04:03:04 -0400
Date: Tue, 5 Oct 2004 10:03:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: bug in sched.c:task_hot()
Message-ID: <20041005080341.GA5897@elte.hu>
References: <200410050237.i952bx620740@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410050237.i952bx620740@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Current implementation of task_hot() has a performance bug in it
> that it will cause integer underflow.

> -#define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
> +#define task_hot(p, now, sd) ((long long) ((now) - (p)->timestamp)	\
> +				< (long long) (sd)->cache_hot_time)

ah ... nice catch.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
