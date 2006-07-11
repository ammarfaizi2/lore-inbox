Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWGKHEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWGKHEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWGKHEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:04:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030221AbWGKHEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:04:36 -0400
Date: Tue, 11 Jul 2006 00:04:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
Message-Id: <20060711000434.6c25d9c2.akpm@osdl.org>
In-Reply-To: <m1bqrwiq74.fsf@ebiederm.dsl.xmission.com>
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<20060710211951.7bf8320b.akpm@osdl.org>
	<m1bqrwiq74.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 00:57:35 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Mon, 10 Jul 2006 16:38:59 -0600
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> >> Since sys_sysctl is deprecated start allow it to be compiled out.
> >
> > This could be a tough one to get rid of (looks at sys_bdflush() again).
> >
> > I'd suggest we put a sys_bdflush()-style warning in there, see what that
> > flushes out.
> 
> Sounds sane.  I know I have booted several kernels with it compiled out
> but just because you can do without it doesn't mean that something
> isn't using it.
> 
> Hmm.  The question is where do I want the put the warning message?
> 
> When the code is compiled out?
> When the code is compiled in?

Both.  We want to find out who is using it.

> Probably both places at this point, and using the rate limited printk
> I think instead of just the 5 printks that sys_bdflush uses...

No, I think five is enough.  If something's using sys_sysctl() then it
might be using it a lot - there's no point in irritating people over it.
