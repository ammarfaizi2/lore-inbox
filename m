Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbRERStV>; Fri, 18 May 2001 14:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261445AbRERStL>; Fri, 18 May 2001 14:49:11 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:45545 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261433AbRERSs5>; Fri, 18 May 2001 14:48:57 -0400
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC, AMD-K6/2 -mcpu=586...
In-Reply-To: <m2u22ibww6.fsf@sympatico.ca> <m2d796twqe.fsf@sympatico.ca> <20010518203446.A1066@werewolf.able.es>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 18 May 2001 14:47:26 -0400
In-Reply-To: "J . A . Magallon"'s message of "Fri, 18 May 2001 20:34:46 +0200"
Message-ID: <m2eltm335t.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> On 05.18 Bill Pringlemeir wrote:

 >> Why don't the build scripts run a dummy file to determine where
 >> the floating point registers should be placed?
 >> 
 >> ...  const int value = offsetof(struct task_struct,
 >> thread.i387.fxsave) & 15; ...

>>>>> "JAM" == J A Magallon <jamagallon@able.es> writes:

 JAM> That is not the problem. The problem is that the registers have
 JAM> to lay in a defined way, transcribed to a C struct, and that
 JAM> pgcc lays badly that struct.

Yes, I understand that.  I was showing a way to find the value of padding
needed to align the register store in the structure.  Perhaps I should have
shown a mod to asm/processor.h,

...
        /* floating point info */
#if PAD_SIZE  /* not needed if gcc accepts zero size arrays? */
        unsigned char fpAlign[PAD_SIZE];
#endif
	union i387_union	i387;
...

Before compiling the `real source', the dummy file would be compiled
with PAD_SIZE set to zero.  Then objdump (or some other tool) can find
out what the value is.  Then when the task_struct is compiled in the
kernel, PAD_SIZE is set to the appropriate value to align the
structure.

I was describing a way to make things independent of the compiler layout
of the structs.  However, this complicates the build process, and people
might not like the padding due to cache alignment details.

I am pretty sure what I am saying works... It might not be right though.

regards,
Bill Pringlemeir.


