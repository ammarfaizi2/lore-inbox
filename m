Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131403AbRAQCWK>; Tue, 16 Jan 2001 21:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132104AbRAQCWB>; Tue, 16 Jan 2001 21:22:01 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:63708 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131403AbRAQCVn>; Tue, 16 Jan 2001 21:21:43 -0500
Message-ID: <3A650198.8523D94F@Home.net>
Date: Tue, 16 Jan 2001 21:21:12 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@linuxcare.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.4.1-preX series
In-Reply-To: <3A64F6E0.778F5734@Home.net> <d3bst6kjml.fsf@lxplus015.cern.ch>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fair enough, but something in bugs.h changed from 2.4.0 to 2.4.1-preX and
broke my GCC, I shall recompile GCC with no PGCC patches however if this
happens still then there's a problem somewhere.

I dont know what FXSR is but there was no problem in 2.4.0 with this.


 diff include/asm-i386/bugs.h ../linux/include/asm-i386/bugs.h  |
more78a79
> #if defined(CONFIG_X86_FXSR) || defined(CONFIG_X86_RUNTIME_FXSR)
82,85c83,85
<  if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
<   extern void __buggy_fxsr_alignment(void);
<   __buggy_fxsr_alignment();
<  }
---
>  if (offsetof(struct task_struct, thread.i387.fxsave) & 15)
>   panic("Kernel compiled for PII/PIII+ with FXSR, data not 16-byte
aligned!");
>
90a91,92


Jes Sorensen wrote:

> >>>>> "Shawn" == Shawn Starr <Shawn.Starr@Home.net> writes:
>
> Shawn> Which compiler will compile the 2.4.1-preX series? Since 2.4.0,
> Shawn> my GCC 2.95.2 patched with PGCC 2.95.3 (which creates
> Shawn> pgcc-2.95.2) refuses to compile any versions after this. Which
> Shawn> is the next stable and binary compatable compiler?
>
> Shawn> Anyone have any suggestions? I dont wish to use the development
> Shawn> GCC 2.96/2.97 because they will break my binary compatability
> Shawn> with pgcc-2.95.2/3.
>
> Yes, it's simple you want the real gcc 2.96/2.97 or egcs-1.1.2. pgcc
> is not supported.
>
> Jes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
