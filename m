Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbTDAWFg>; Tue, 1 Apr 2003 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbTDAWFg>; Tue, 1 Apr 2003 17:05:36 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15117
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262877AbTDAWFf>; Tue, 1 Apr 2003 17:05:35 -0500
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Wayne Whitney <whitney@math.berkeley.edu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304011320580.13867-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0304011320580.13867-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049235419.754.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 01 Apr 2003 17:16:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 16:28, Linus Torvalds wrote:

> Can you test this patch? It turns out that "get_cpu()/put_cpu()" are not 
> enough - on UP they don't actually disable preemption, since the CPU 
> number itself is perfectly stable at 0, of course.

Actually, do they do disable preemption - if they do not, something is
broken.

Because, even on UP, preemption can lead to a race over a variable that
has no locking because its per-CPU.  But it would need locking
otherwise, and thus we do need to disable preemption.  I.e., per-CPU
vars are only safe on SMP because we assume the other processors won't
touch them.  If we start preempting, even on UP, we have problems.

So something else is amiss here...

	Robert Love

