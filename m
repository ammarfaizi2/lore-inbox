Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWGLNcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWGLNcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWGLNcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:32:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63139 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751253AbWGLNcE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:32:04 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
Date: Wed, 12 Jul 2006 15:32:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com> <p73ac7fok13.fsf@verdi.suse.de> <m1sll7ecr4.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1sll7ecr4.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200607121532.05227.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 05:13, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> > ebiederm@xmission.com (Eric W. Biederman) writes:
> >> Since sys_sysctl is deprecated start allow it to be compiled out.
> >> This should catch any remaining user space code that cares,
> >
> > I tried this long ago, but found that glibc uses sysctl in each
> > program to get the kernel version. It probably handles ENOSYS,
> > but there might be slowdowns or subtle problems from it not knowing
> > the kernel version.
> >
> > So I think it's ok to remove the big sysctl, but at a very minimal
> > replacement that just handles (CTL_KERN, KERN_VERSION) is needed.
>
> If glibc is looking at kernel.osrelease it might make sense.
> If glibc is looking at kernel.version which is just the build number
> and date I can't imagine a correct usage.

It's KERN_VERSION 

>From my /bin/ls:

_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfc8e1e0, 30, (nil), 0}) = 0

> If this usage is still common in glibc we can decide what to do
> when the warnings pop up.

printk for everything would annoy basically everybody. Not a good idea.

-Andi
