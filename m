Return-Path: <linux-kernel-owner+w=401wt.eu-S1754021AbWLXBmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbWLXBmN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 20:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbWLXBmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 20:42:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:33765 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbWLXBmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 20:42:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender;
        b=TefFeaIRlPb0X1OfezH0rDrHbN1TM0iQ+PLHDMSeiWDnk9G8QKkHaSt/FJ4G0ivnAWVMpyuJeHcS8YL367ohdElWrvq7qcjIohrCLbB86aQgex7mjxvVE/VEXxAkZM++emrUmiLtl5Dh50g7CzIrAE6xLxVIYZTdXD/fMH4DOWs=
From: David Wragg <david@wragg.org>
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
References: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
	<878xh2aelz.fsf@wragg.org>
	<787b0d920612200936w186a783aj81d10384c54dfc7e@mail.gmail.com>
Date: Sun, 24 Dec 2006 01:40:52 +0000
In-Reply-To: <787b0d920612200936w186a783aj81d10384c54dfc7e@mail.gmail.com>
	(Albert Cahalan's message of "Wed\, 20 Dec 2006 12\:36\:23 -0500")
Message-ID: <87y7oy840r.fsf@wragg.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:
> The cumulative ones are still not justified though, and I fear they
> may be 64-bit even on i386.

All the context switch counts are unsigned long.

> It turns out that an i386 procps spends
> much of its time doing 64-bit division to parse the damn ASCII crap.
> I suppose I could just skip those fields, but generating them isn't
> too cheap and probably I'd get stuck parsing them for some other
> reason -- having them separate is probably a good idea.

I can't think of a compelling justification for the cumulative context
switch counts.  But I suggest that if the cost of exposing these
values is low enough, they should be exposed anyway, just for the sake
of uniformity (these would be the only two getrusage values not
present in /proc/pid/stat).

If the decimal representation of values in /proc/pid/stat has such
unpleasant overheads, then I wonder if that is something worth fixing,
whether the context switch counts are added or not?  It occurs to me
that it would be easy to add support for a hex version of
/proc/pid/stat with very little additional code, by using an alternate
sprintf format string in fs/proc/array.c:do_task_stat().  I assume
that procps could be adapted quite easily to take advantage of this?


David
