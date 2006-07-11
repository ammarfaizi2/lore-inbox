Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWGKW0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWGKW0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWGKW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:26:37 -0400
Received: from mx1.suse.de ([195.135.220.2]:10698 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932210AbWGKW0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:26:36 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 12 Jul 2006 00:26:32 +0200
In-Reply-To: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
Message-ID: <p73ac7fok13.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Since sys_sysctl is deprecated start allow it to be compiled out.
> This should catch any remaining user space code that cares,

I tried this long ago, but found that glibc uses sysctl in each
program to get the kernel version. It probably handles ENOSYS,
but there might be slowdowns or subtle problems from it not knowing
the kernel version.

So I think it's ok to remove the big sysctl, but at a very minimal
replacement that just handles (CTL_KERN, KERN_VERSION) is needed.

Also it's useful to printk for the rest at least for some time 
so we know what uses it.

-Andi
