Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVDOKOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVDOKOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 06:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVDOKOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 06:14:49 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:33520 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261796AbVDOKOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 06:14:33 -0400
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Further copy_from_user() discussion.
References: <Pine.LNX.4.58.0504131342530.14888@shell4.speakeasy.net>
	<tnxzmw1d7io.fsf@arm.com>
	<Pine.LNX.4.58.0504141001580.5403@shell2.speakeasy.net>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 15 Apr 2005 11:14:28 +0100
In-Reply-To: <Pine.LNX.4.58.0504141001580.5403@shell2.speakeasy.net> (Vadim
 Lobanov's message of "Thu, 14 Apr 2005 10:04:33 -0700 (PDT)")
Message-ID: <tnx64yobb3v.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> I think I misspoke a bit in my email above. The intent was not to
> eliminate all might_sleep() calls from the copy_from_user() code path;
> but rather juggle the source around a bit so there is only one
> might_sleep() call per each code path. Currently, in the default case,
> it calls it twice.
>
> By the way, is the following still true about might_sleep()?
> http://kerneltrap.org/node/3440/10103

With Ingo's realtime-preempt patch, might_sleep() expands to
might_resched(). The latter expands to cond_resched() only if
CONFIG_PREEMPT_VOLUNTARY is enabled (for CONFIG_PREEMPT_RT this is not
needed since the kernel is involuntarily preemptible). In this case it
might be useful to have might_sleep() only called before memset().

-- 
Catalin

