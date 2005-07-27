Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVG0P7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVG0P7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVG0P60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:58:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46228 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262388AbVG0P4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:56:55 -0400
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 27 Jul 2005 09:56:17 -0600
In-Reply-To: <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Wed, 27 Jul 2005 09:32:32 -0600")
Message-ID: <m1fyu09ra6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Andrew Morton <akpm@osdl.org> writes:
>
>> My fairly ordinary x86 test box gets stuck during reboot on the
>> wait_for_completion() in ide_do_drive_cmd():
>
> Hmm. The only thing I can think of is someone started adding calls
> to device_suspend() before device_shutdown().  Not understanding
> where it was a good idea I made certain the calls were in there
> consistently.  
>
> Andrew can you remove the call to device_suspend from kernel_restart
> and see if this still happens?
>
> I would suspect interrupts of being disabled but it looks like
> kgdb is working and I think that requires an interrupt to notice
> new characters.

Looking at it the device_suspend calls should be safe but
in case we need to follow it up the device_suspend calls in sys_reboot
were initially introduced in:


commit 620b03276488c3cf103caf1e326bd21f00d3df84
Author: Pavel Machek <pavel@ucw.cz>
Date:   Sat Jun 25 14:55:11 2005 -0700

    [PATCH] properly stop devices before poweroff

    Without this patch, Linux provokes emergency disk shutdowns and
    similar nastiness. It was in SuSE kernels for some time, IIRC.

    Signed-off-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Eric


