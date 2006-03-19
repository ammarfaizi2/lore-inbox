Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWCSOJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWCSOJm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWCSOJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 09:09:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20120 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932103AbWCSOJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 09:09:42 -0500
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cpuset: remove unnecessary NULL check
References: <20060319085743.18841.45970.sendpatchset@jackhammer.engr.sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Mar 2006 07:08:10 -0700
In-Reply-To: <20060319085743.18841.45970.sendpatchset@jackhammer.engr.sgi.com> (Paul
 Jackson's message of "Sun, 19 Mar 2006 00:57:43 -0800")
Message-ID: <m1acbmzfw5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> From: Paul Jackson <pj@sgi.com>
>
> Remove a no longer needed test for NULL cpuset pointer, with
> a little comment explaining why the test isn't needed.

Could we make that comment a little more explicit.  Say:

No need to check that tsk->cpuset != NULL, since cpuset_exit() sets
it to top_cpuset instead.

Comments that refer to a nebulous hack in some other function
a little hard to understand when new, and get really confusing
when the other function changes and it isn't clear what aspect
of that other function the comment depended on and if that property
still exists.

>   *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
>   *    doesn't really matter if tsk->cpuset changes after we read it,
>   *    and we take manage_mutex, keeping attach_task() from changing it
> - *    anyway.
> + *    anyway.  No need to check that tsk->cpuset != NULL, thanks to the
> + *    cpuset_exit() Hack.
>   */


Eric
