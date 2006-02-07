Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWBGWRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWBGWRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWBGWRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:17:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5010 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030200AbWBGWRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:17:05 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 15:16:28 -0700
In-Reply-To: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com> (linux-os@analogic.com's
 message of "Tue, 7 Feb 2006 11:23:56 -0500")
Message-ID: <m1pslystkz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Linux, type pid_t is defined as an int if you look
> through all the intermediate definitions such as S32_T,
> etc. However, it wraps at 32767, the next value being 300.
>
> Does anybody know why it doesn't go to 0x7fffffff and
> then wrap to the first unused pid value? I know the
> code "reserves" the first 300 pids. That's not the
> question. I wonder why. Also I see the code setting
> the upper limit as well. I want to know why it is
> set within the range of a short and is not allowed
> to use the full range of an int. Nothing I see in
> the kernel, related to the pid, ever uses a short
> and no 'C' runtime interface limits this either!

I have a vague memory about some old kernel interfaces
where pid was a short.  That said 32768 is also the number
of bits in a page so it is a very good number for the bitmap
allocator we currently have.

I know for certain that proc assumes it can fit pid in
the upper bits of an ino_t taking the low 16bits for itself
so that may the entire reason for the limit.

> Also, attempts to change /proc/sys/kernel/pid_max fail
> if I attempt to increase it, but I can decrease it
> to where I don't have enough pids available to fork()
> the next command! Is this the correct behavior?

You can increase pid_max if you have a 64bit kernel.

Eric

