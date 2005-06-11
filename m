Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVFKLYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVFKLYy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 07:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVFKLYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 07:24:54 -0400
Received: from one.firstfloor.org ([213.235.205.2]:34720 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261685AbVFKLYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 07:24:52 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, akpm@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, jk@blackdown.de
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
	<17063.31568.618739.165823@cargo.ozlabs.ibm.com>
	<20050608.161633.55509444.davem@davemloft.net>
From: Andi Kleen <ak@muc.de>
Date: Sat, 11 Jun 2005 13:24:50 +0200
In-Reply-To: <20050608.161633.55509444.davem@davemloft.net> (David S.
 Miller's message of "Wed, 08 Jun 2005 16:16:33 -0700 (PDT)")
Message-ID: <m1slzpcf0d.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Paul Mackerras <paulus@samba.org>
> Date: Thu, 9 Jun 2005 09:12:16 +1000
>
>> There is still a point of difference between ppc64 and x86_64: on
>> ppc64 (and on sparc64), if the personality is PER_LINUX32, the
>> personality(0xffffffffUL) system call returns PER_LINUX, and attempts
>> to set the personality to PER_LINUX don't change the personality
>> (i.e. it stays set to PER_LINUX32), for both 32-bit and 64-bit
>> processes.  On x86_64 this is true for 32-bit processes but not for
>> 64-bit processes AFAICT.  Does anyone know why we do this at all, and
>> whether doing it for 64-bit processes makes sense?
5A>
> We do this because, at least when this code was written,
> glibc would do a personality(PER_LINUX) call (either via
> the dynamic linker or via some other libc startup code)
> and this would undo the PER_LINUX32 setting.
>
> Therefore, it makes sense to do this for all cases, not
> just for 32-bit processes.  The x86_64 code ought to be
> fixed, I think.

I have never seen a report of such a case (glibc undoing linux32).
Do you have details? 

But I agree 64bit should be consistent to 32bit. Will fix.

-Andi

