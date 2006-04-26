Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWDZTAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWDZTAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWDZTAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:00:36 -0400
Received: from [198.99.130.12] ([198.99.130.12]:34753 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964821AbWDZTAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:00:35 -0400
Date: Wed, 26 Apr 2006 14:01:10 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <20060426180110.GB8142@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> <m1d5feotur.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5feotur.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 02:25:00AM -0600, Eric W. Biederman wrote:
> That patch should probably be separated, from the rest.
> But it looks like a fairly sane idea. 

Yeah, I'll keep these together for now, but the ptrace one is
conceptually different from the rest.

> I think you missed a couple essential things to a time namespace.
> Timers.  The posix timers, in particular.  The worst
> of those is the monotonic timer.  

Oops, thanks for pointing that out.

> In the case of migration the ugly case to properly handle is the
> monotonic timer.   That needs an offset yet it is absolutely forbidden
> to provide that offset from the inside.  So this is the one namespace
> that I think is inappropriate to use sys_unshare to create.
> We need a system call so that we can specify the minimum or the
> starting monotonic time base.

For migration, it looks like the container will have to specify the
time base at creation so that everything in it will have a consistent
view of time if they get moved around.

So, maybe it belongs in clone as a "backwards" flag similar to
CLONE_NEWNS.

				Jeff
