Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311712AbSCNSG1>; Thu, 14 Mar 2002 13:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSCNSGR>; Thu, 14 Mar 2002 13:06:17 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:23529 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311701AbSCNSGG>;
	Thu, 14 Mar 2002 13:06:06 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15504.59019.157849.267434@napali.hpl.hp.com>
Date: Thu, 14 Mar 2002 10:06:03 -0800
To: Richard Henderson <rth@twiddle.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, davidm@hpl.hp.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
In-Reply-To: <20020314013721.A23274@twiddle.net>
In-Reply-To: <15504.7958.677592.908691@napali.hpl.hp.com>
	<E16lMzi-0002bb-00@wagner.rustcorp.com.au>
	<20020314013721.A23274@twiddle.net>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 14 Mar 2002 01:37:21 -0800, Richard Henderson <rth@twiddle.net> said:

  Richard> This definitely needs to be per-architecture.  On Alpha, I
  Richard> think I can use the Thread Local Storage model to be added
  Richard> to binutils 2.13 (and potentially compiler support to gcc
  Richard> 3.[23]).  IA-64 may be able to do the same.  It's certain
  Richard> that x86 can't, since the userland model requires %gs:0
  Richard> point to the thread base, and the kernel folk would never
  Richard> cotton to the segment swapping that would be needed.

Actually, on ia64 I want to use a pinned TLB entry to map the per-CPU
area.  This has the advantage that accessing the local version of a
per-CPU variable has zero extra overhead.  We have been doing this for
the cpu_info structure for a while now.

	--david
