Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWDFT6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWDFT6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWDFT6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 15:58:23 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:3494 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751292AbWDFT6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 15:58:22 -0400
Date: Fri, 7 Apr 2006 03:55:19 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] coredump: speedup SIGKILL sending
Message-ID: <20060406235519.GA331@oleg>
References: <20060406220628.GA237@oleg> <1144352758.2866.105.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144352758.2866.105.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06, Lee Revell wrote:
> On Fri, 2006-04-07 at 02:06 +0400, Oleg Nesterov wrote:
> > With this patch a thread group is killed atomically under ->siglock.
> > This is faster because we can use sigaddset() instead of force_sig_info()
> > and this is used in further patches.
> > 
> > Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> Won't this cause huge latencies when a process with lots of threads is
> killed?

Yes, irqs are disabled. But this is not worse than 'kill -9 pid', note
that __group_complete_signal() or zap_other_threads() do the same.

Oleg.

