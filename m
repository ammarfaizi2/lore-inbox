Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129696AbQJaW7W>; Tue, 31 Oct 2000 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQJaW7M>; Tue, 31 Oct 2000 17:59:12 -0500
Received: from chiara.elte.hu ([157.181.150.200]:48135 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129696AbQJaW66>;
	Tue, 31 Oct 2000 17:58:58 -0500
Date: Wed, 1 Nov 2000 01:08:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF4B99.1746E06E@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011010102370.17233-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Jeff V. Merkey wrote:

> One more optimization it has.  NetWare never "calls" functions in the
> kernel.  There's a template of register assignments in between kernel
> modules that's very strict (esi contains a WTD head, edi has the target
> thread, etc.) and all function calls are jumps in a linear space. 

this might be a win on a i486, but is a loss with any branch predicting,
large-pipeline CPUs (think Pentium IV), which are optimized for CALLs, not
for JMP *EAX instructions. This is the problem with assembly optimizations
that try to compete with the compiler's work: hand-made assembly can only
get worse over time (stay constant in the best case), while compilers are
known to improve slowly but steadily. Plus hand-made assembly is a huge
stone tied to your legs if you try to swim to other architectures. Eg. we
quite often make use of GCC's register-based function parameter passing
optimization. We do use hand-made assembly in a number of cases in Linux
as well, and double-check GCC's assembly output in critical code paths,
but we try to not make it an essential facility.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
