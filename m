Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278205AbRKFIBq>; Tue, 6 Nov 2001 03:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278617AbRKFIBh>; Tue, 6 Nov 2001 03:01:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:33551 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S278205AbRKFIBV>;
	Tue, 6 Nov 2001 03:01:21 -0500
Subject: Re: Using %cr2 to reference "current"
From: Robert Love <rml@tech9.net>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <9s82rl$k51$1@cesium.transmeta.com>
In-Reply-To: <9s82rl$k51$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 06 Nov 2001 03:01:29 -0500
Message-Id: <1005033690.808.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-06 at 02:18, H. Peter Anvin wrote:
> 2.4.13-ac8 uses %cr2 rather than (%esp & 0xfffe0000) to get "current".
> I've been trying to figure out the point of this...  <snip>

I too am confused.  More so, the difference between hard_get_current and
get_current is confusing.  I further question things because I suspect
there is a problem: hard_get_current is commented as "for within NMI,
do_page_fault, cpu_init" but all these functions call other functions
that may very well use get_current.  How is this going to work?

Further, the preemptible kernel patch oopses with this patch (IOW, don't
use 2.4.13-ac8 + preempt-kernel, unless you remove all these bits like I
did :>).  I think it may be because of:

Manfred Spraul wrote:
> error_code:
> [...]
> -       GET_CURRENT(%ebx)
>         call *%edi
>         addl $8,%esp
> +       GET_CURRENT(%ebx)
> The pointer to current was loaded into %ebx before the call to the error
> handler, now that only happens after the call. As far as I can see the
> load before the call is not required.

this change but I am unsure.  Would Manfred or someone knowledgeable in
this mind letting me pick their brain?

	Robert Love

