Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWALKwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWALKwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWALKwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:52:14 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:59303 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030366AbWALKwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:52:12 -0500
Date: Thu, 12 Jan 2006 02:51:15 -0800
From: Paul Jackson <pj@sgi.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: akpm@osdl.org, kurosawa@valinux.co.jp, simon.derr@bull.net,
       linux-kernel@vger.kernel.org, st@sw.ru, den@sw.ru, djwong@us.ibm.com
Subject: Re: [PATCH] cpuset oom lock fix
Message-Id: <20060112025115.3d9c7754.pj@sgi.com>
In-Reply-To: <43C62A39.50606@sw.ru>
References: <20060112091627.18409.49780.sendpatchset@jackhammer.engr.sgi.com>
	<43C62A39.50606@sw.ru>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill wrote:
> To tell the truth I don't like such approaches, when more and more hooks 
> are create and scattered all aroung. maybe it is possible to split 
> semaphore to lock and sem and use lock where possible?

Hmmm ...

I'm not sure what to make of your comments.

I guess you are suggesting a different locking scheme with your phrase
"split semaphore to lock and sem and use lock", but I can't parse
your phrase, nor guess what you have in mind.

And I am guessing that you recommend this alternative locking scheme
(whatever it is) because you think it would reduce the number of
cpuset_*() hooks in the kernel -- or at least avoid this one in the
oom code.

There are various reasons I could imagine why you might not like
"more and more hooks", but I don't have a guess as to which of these
possible reasons are your chief concerns, so cannot evaluate whether
said locking scheme would address those concerns.

I just went through a substantial amount of work refining and fine
tuning the cpuset locking structure, and at the moment am both
pleased with the result, and not enthusiastic about recommendations
to rework it all again.  The result we have now is very low impact
on the important code paths (oom is not an important code path,
performance wise).

So ...

Could you please elaborate on why you don't like the hooks, on
what this alternative locking scheme is (if indeed that's what
you meant) and how such a scheme addresses your concerns with
the hooks?

Take a close look at the comments in kernel/cpuset.c, explaining
the current cpuset locking mechanims, as part of your recommending
alternatives.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
