Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVISOdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVISOdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 10:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVISOdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 10:33:55 -0400
Received: from ns1.coraid.com ([65.14.39.133]:1768 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932435AbVISOdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 10:33:54 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, jmacbaine@gmail.com
Subject: Re: aoe fails on sparc64
References: <3afbacad0508310630797f397d@mail.gmail.com>
	<87u0glxhfw.fsf@coraid.com>
	<20050916.163554.79765706.davem@davemloft.net>
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 19 Sep 2005 10:24:00 -0400
In-Reply-To: <20050916.163554.79765706.davem@davemloft.net> (David S.
 Miller's message of "Fri, 16 Sep 2005 16:35:54 -0700 (PDT)")
Message-ID: <87slw1b0fz.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Ed L Cashin <ecashin@coraid.com>
> Date: Fri, 16 Sep 2005 09:36:51 -0400
>
>> I've been working with Jim MacBaine, and he reports that the patch
>> below gets rid of the problem.  I don't know why.  When I test
>> le64_to_cpup by itself, it works as expected.
>
> This patch should fix the bug.
>
> diff --git a/arch/sparc64/kernel/una_asm.S b/arch/sparc64/kernel/una_asm.S
> --- a/arch/sparc64/kernel/una_asm.S
> +++ b/arch/sparc64/kernel/una_asm.S

So it's OK to use the "...._to_cpup" macros with unaligned pointers?
I'm asking whether ...

  1) Passing le64_to_cpup an unaligned pointer is "OK" and within the
     intended use of the function.  I'm having trouble finding whether
     this is documented somewhere.

  2) These new changes to the sparc64 unaligned access fault handling
     will make it OK to leave the aoe driver the way it is in the
     mainline kernel.

...
> diff --git a/arch/sparc64/kernel/unaligned.c b/arch/sparc64/kernel/unaligned.c


-- 
  Ed L Cashin <ecashin@coraid.com>

