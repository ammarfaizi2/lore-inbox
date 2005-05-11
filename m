Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVEKXQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVEKXQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVEKXQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 19:16:52 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:48398 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261312AbVEKXQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 19:16:45 -0400
Date: Wed, 11 May 2005 16:20:10 -0700
To: kus Kusche Klaus <kus@keba.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Real-Time Preemption: BUG initializing kgdb
Message-ID: <20050511232010.GA9451@nietzsche.lynx.com>
References: <AAD6DA242BC63C488511C611BD51F36732320E@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F36732320E@MAILIT.keba.co.at>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 04:41:16PM +0200, kus Kusche Klaus wrote:
> These changes resulted in a kernel which compiles and works fine, they
> cured the BUG I reported yesterday, and they made kgdb "basically work":
> I can connect over serial line or over ethernet, I can get "where"s and
> variables etc., I can "cont", ...
> 
> However, there are still some issues:
> 
> * When debugging over ethernet, the kernel produces the following
> messages in an infinite loop at full speed as long as it is halted by
> gdb:

You'll have to survey the lock graph and make sure that all locks beneath
the reverted spinlocks are also atomic locks. You can't sleep within an
atomic critical section which creates a deadlock situation. I suspect that
those warnings are related to that in one way or another.

That means any use of the serial or ethernet systems must have their
locks revert to atomic locks as well. However this make those places
non-preemptible and you'll have to be careful about this proces so that
you don't defeat latency performance with theses changes.

bill

