Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbSKTF5A>; Wed, 20 Nov 2002 00:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbSKTF5A>; Wed, 20 Nov 2002 00:57:00 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:14824 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S265800AbSKTF47>; Wed, 20 Nov 2002 00:56:59 -0500
Date: Wed, 20 Nov 2002 01:03:11 -0500
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Performance improvement with Akira Tsukamoto's Athlon copy_user patch
Cc: Akira Tsukamoto <at541@columbia.edu>, linux-kernel@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <3DDA8E81.4070508@colorfullife.com>
References: <3DDA8E81.4070508@colorfullife.com>
Message-Id: <20021120004212.5F4C.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop016.verizon.net from [138.89.33.207] at Wed, 20 Nov 2002 00:03:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not deeply but I looked your exception safe kfpu.

'kernel_fpu_begin/end' was like delayed FPU sate switching,
on the other hand, kfpu is more abstracted FPU semaphore
which works per cpu.

I have not compiled it but it should work fine on 2.4, but
have some questions using kfpu for 2.5.

 1)Is 'per CPU' safe for 2.5?
   I think the new O(1) scheduler has process migration between cpus
   and I am a bit afraid.
   If not safe, any good idea for it?
   May be per task could be safer even not optimal for smp?
 2)Need to add preempt_disable/enable().
 3)struct kfpuacquire {} kfpuacquire; is in the kfpu.h header,
   might cause compile problem.

> Have you tried SSE based copy_to_user? With SSE, you can just save the affected registers, without unexpected sideeffects.

No, my CPU don't run SSE......:)

By the way,
do you have separeted patch only for kfpu?

Thank you,

Akira Tsukamoto

On Tue, 19 Nov 2002 20:18:25 +0100
Manfred Spraul <manfred@colorfullife.com> mentioned:

> >I read the code of laze FPU state saving and confirmed that 
> >if the function does not generate exception than
> >'kernel_fpu_begin/end()' should assure fpu safe inside kernel.
> >
> >However, it is not enough where exception could rise, as Takahashi
> >mentioned.
> 
> 
> I had prototyped an exception safe kfpu framework, but then I didn't have the time to submit/cleanup it.
> 
> http://www.colorfullife.com/~manfred/linux-2.5/sse/patch-kfpu
> 
> Have you tried SSE based copy_to_user? With SSE, you can just save the affected registers, without unexpected sideeffects.
> 
> --
> 	Manfred
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


