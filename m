Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWGLWcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWGLWcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWGLWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:32:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39372 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751471AbWGLWcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:32:00 -0400
Message-ID: <44B57828.8070402@zytor.com>
Date: Wed, 12 Jul 2006 15:31:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Arjan van de Ven <arjan@infradead.org>, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>	<44B54EA4.5060506@redhat.com>	<20060712195349.GW3823@sunsite.mff.cuni.cz>	<44B556E5.5000702@zytor.com>	<m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>	<1152739766.3217.83.camel@laptopd505.fenrus.org>	<m1bqru8p36.fsf@ebiederm.dsl.xmission.com>	<1152741665.3217.85.camel@laptopd505.fenrus.org>	<44B57191.5000802@zytor.com> <m1zmfe794e.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1zmfe794e.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>>
>> It depends greatly; if a lock is likely to get released by the user after a few
>> memory accesses, spinning is likely to be a win.
> 
> But this requires that the lock be short lived, and highly contended.
> 

Correct, and incorrect, in that order.

The contention level of the lock determines how likely you are to fail 
to acquire it immediately, not how long it takes until it can be 
acquired *after you know a failure has already happened.*

> If the lock is not short lived then the release is like to be a long
> ways off.  If the lock is not highly contended then you are not likely
> to hit the window when someone else as the contended lock.

The last sentence makes no sense either grammatically or technically. 
Sorry.

> How frequent are highly contended short lived locks in user space?

Short-lived locks (which may be significantly contended) are very common 
to protect data structures.

	-hpa
