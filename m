Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWGLW1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWGLW1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWGLW1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:27:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48784 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750813AbWGLW1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:27:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
	<44B54EA4.5060506@redhat.com>
	<20060712195349.GW3823@sunsite.mff.cuni.cz>
	<44B556E5.5000702@zytor.com>
	<m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
	<1152739766.3217.83.camel@laptopd505.fenrus.org>
	<m1bqru8p36.fsf@ebiederm.dsl.xmission.com>
	<1152741665.3217.85.camel@laptopd505.fenrus.org>
	<44B57191.5000802@zytor.com>
Date: Wed, 12 Jul 2006 16:26:25 -0600
In-Reply-To: <44B57191.5000802@zytor.com> (H. Peter Anvin's message of "Wed,
	12 Jul 2006 15:02:57 -0700")
Message-ID: <m1zmfe794e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Arjan van de Ven wrote:
>>> It is a short busy wait before falling asleep.  I assume you mean
>>> busy wait is a loss even on SMP?
>> eh yeah I forgot to think for a second. But yes even for SMP busy wait
>> is pretty bad power wise nowadays.. at least if you wait more than a few
>> hundred cycles. (and if you wait less... then it's almost unlikely that
>> it'll be useful as well)
>>
>
> It depends greatly; if a lock is likely to get released by the user after a few
> memory accesses, spinning is likely to be a win.

But this requires that the lock be short lived, and highly contended.

If the lock is not short lived then the release is like to be a long
ways off.  If the lock is not highly contended then you are not likely
to hit the window when someone else as the contended lock.

How frequent are highly contended short lived locks in user space?

Eric
