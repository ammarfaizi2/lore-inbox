Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262842AbSJFWc7>; Sun, 6 Oct 2002 18:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbSJFWc6>; Sun, 6 Oct 2002 18:32:58 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:60428
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262842AbSJFWcY>; Sun, 6 Oct 2002 18:32:24 -0400
Subject: Re: 2.5.40-mm2
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Ingo Molnar <mingo@redhat.com>
In-Reply-To: <3DA0BA33.5B295A46@digeo.com>
References: <3DA0B422.C23B23D4@digeo.com>
	<1033943021.27093.29.camel@phantasy>  <3DA0BA33.5B295A46@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 18:38:05 -0400
Message-Id: <1033943886.26955.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 18:33, Andrew Morton wrote:

> I think it's a way of doing "cond_resched() if cond_resched() is
> a legal thing to do right now".
> 
> I'm sure David isn't using preempt though.


If the system is preemptible, then the call can be replaced with
preempt_check_resched() which avoids the unneeded inc and dec.

But if the system is preemptible, it probably does not accomplish much
because we will already have preempted (e.g. the interrupt handler that
woke up a new task set need_resched and on return from interrupt we
serviced it).

If the system is not preemptible (non-zero preempt_count here) this
accomplishes nothing.

	Robert Love

