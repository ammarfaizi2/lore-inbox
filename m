Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131546AbRBJSRt>; Sat, 10 Feb 2001 13:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131608AbRBJSRk>; Sat, 10 Feb 2001 13:17:40 -0500
Received: from colorfullife.com ([216.156.138.34]:46597 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131546AbRBJSRb>;
	Sat, 10 Feb 2001 13:17:31 -0500
Message-ID: <3A8585D8.E016E162@colorfullife.com>
Date: Sat, 10 Feb 2001 19:18:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com> <961rkk$fgm$1@penguin.transmeta.com> <3A847729.2C868879@redhat.com> <3A850555.488DE444@colorfullife.com> <3A8577FD.AEFDBB56@redhat.com> <3A8581C2.4C0ECC05@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> copy_*_user is probably not worth the effort for a Pentium III, but even
> for that function I don't see a problem with SSE, as long as
>
> * the clobbered registers are stored on the stack (and not in
>   thread.i387.fxsave)
> * the SSE/SSE2 instructions can't cause SIMD exceptions.
> * noone saves the fpu state into thread.i387.fxsave from interrupts /
> softirq's. Currently it's impossible, but I haven't checked Montavista's
> preemptive kernel scheduler.
>
I overlooked one restriction:
* you must not schedule() with the "wrong" sse registers: switch_to()
saves into i387.fxsave.

This means that copy_*_user isn't that simple.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
