Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWGLDO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWGLDO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGLDO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:14:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54980 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932363AbWGLDO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:14:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<p73ac7fok13.fsf@verdi.suse.de>
Date: Tue, 11 Jul 2006 21:13:51 -0600
In-Reply-To: <p73ac7fok13.fsf@verdi.suse.de> (Andi Kleen's message of "12 Jul
	2006 00:26:32 +0200")
Message-ID: <m1sll7ecr4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Since sys_sysctl is deprecated start allow it to be compiled out.
>> This should catch any remaining user space code that cares,
>
> I tried this long ago, but found that glibc uses sysctl in each
> program to get the kernel version. It probably handles ENOSYS,
> but there might be slowdowns or subtle problems from it not knowing
> the kernel version.
>
> So I think it's ok to remove the big sysctl, but at a very minimal
> replacement that just handles (CTL_KERN, KERN_VERSION) is needed.

If glibc is looking at kernel.osrelease it might make sense.
If glibc is looking at kernel.version which is just the build number
and date I can't imagine a correct usage.

If this usage is still common in glibc we can decide what to do
when the warnings pop up.

> Also it's useful to printk for the rest at least for some time 
> so we know what uses it.

Yes.  Andrew and I discussed that and when he picked up a patch.
A printk was added to warn of people using the interface.

Eric
