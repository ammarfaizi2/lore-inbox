Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUHVMSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUHVMSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUHVMSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:18:42 -0400
Received: from zero.aec.at ([193.170.194.10]:15366 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266705AbUHVMQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:16:30 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, eich@suse.de
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
References: <2vEzI-Vw-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 22 Aug 2004 14:16:00 +0200
In-Reply-To: <2vEzI-Vw-17@gated-at.bofh.it> (Ingo Molnar's message of "Sat,
 21 Aug 2004 16:00:14 +0200")
Message-ID: <m3n00nwepr.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> while debugging/improving scheduling latencies i got the following
> strange latency report from Lee Revell:
>
>   http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6
>
> this trace shows a 120 usec latency caused by XFree86, on a 600 MHz x86
> system. Looking closer reveals:
>
>   00000002 0.006ms (+0.003ms): __switch_to (schedule)
>   00000002 0.088ms (+0.082ms): finish_task_switch (schedule)
>
> it took more than 80 usecs for XFree86 to do a context-switch!
>
> it turns out that the reason for this (massive) context-switching
> overhead is the following change in 2.6.8:
>
>       [PATCH] larger IO bitmaps
[...]

At least older XFree86 (4.2/3 time frame) used to only use iopl(). I
know it because at some point ioperm() was completely broken on
x86-64, but the X server never hit it. I wonder why they changed
that. Anyways, perhaps it would be better to just change the X server
back to use iopl(), because it will be always faster than using
ioperm.

-Andi

