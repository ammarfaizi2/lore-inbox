Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVDOPzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVDOPzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVDOPzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:55:31 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:47274 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261840AbVDOPz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:55:26 -0400
Date: Fri, 15 Apr 2005 08:55:24 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Further copy_from_user() discussion.
In-Reply-To: <tnx64yobb3v.fsf@arm.com>
Message-ID: <Pine.LNX.4.58.0504150852580.18867@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0504131342530.14888@shell4.speakeasy.net>
 <tnxzmw1d7io.fsf@arm.com> <Pine.LNX.4.58.0504141001580.5403@shell2.speakeasy.net>
 <tnx64yobb3v.fsf@arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Catalin Marinas wrote:

> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> > I think I misspoke a bit in my email above. The intent was not to
> > eliminate all might_sleep() calls from the copy_from_user() code path;
> > but rather juggle the source around a bit so there is only one
> > might_sleep() call per each code path. Currently, in the default case,
> > it calls it twice.
> >
> > By the way, is the following still true about might_sleep()?
> > http://kerneltrap.org/node/3440/10103
>
> With Ingo's realtime-preempt patch, might_sleep() expands to
> might_resched(). The latter expands to cond_resched() only if
> CONFIG_PREEMPT_VOLUNTARY is enabled (for CONFIG_PREEMPT_RT this is not
> needed since the kernel is involuntarily preemptible). In this case it
> might be useful to have might_sleep() only called before memset().
>
> --
> Catalin
>

I agree that might_sleep() needs to be placed in the code judiciously...
just probably not so close together as it is now. :-) I can work this
out in a patch, _if_ people want me to roll a patch in the first place.

-Vadim Lobanov
