Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVLQUub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVLQUub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLQUub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:50:31 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:47936 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964955AbVLQUua convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:50:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jei2dnr7Tf7hjoBjlgJwn+f0WxM6/6XzQCmg5bAyVg+beidyOD0XzNr2JQlf/ycUKYcR8wEJ4CtHemkTfYybvgjo5aRdtlO2EAD15/EvHATxcCx8hdis/+AvnNZh0D+hjSaahZqg2n/JIp5hKKkVGBI95R0UYkD1Ug4CPfBwHEc=
Message-ID: <5a4c581d0512171250j1572c086j4fa56c41d19fa0ae@mail.gmail.com>
Date: Sat, 17 Dec 2005 21:50:29 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.15-rc5-git3] hpet.c causes FC4 GCC 4.0.2 to bomb with unrecognizable insn
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051217123636.cdd53270.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0512130507n698846ao719c389f3c3ee416@mail.gmail.com>
	 <20051217123636.cdd53270.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/05, Andrew Morton <akpm@osdl.org> wrote:
> Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> >
> >  CC      drivers/char/hpet.o
> > drivers/char/hpet.c: In function `hpet_calibrate':
> > drivers/char/hpet.c:803: Unrecognizable insn:
> > (insn/i 95 270 264 (parallel[
> >             (set (reg:SI 0 eax)
> >                 (asm_operands ("") ("=a") 0[
> >                         (reg:DI 1 edx)
> >                     ]
> >                     [
> >                         (asm_input:DI ("A"))
> >                     ]  ("drivers/char/hpet.c") 452))
> >             (set (reg:SI 1 edx)
> >                 (asm_operands ("") ("=d") 1[
> >                         (reg:DI 1 edx)
> >                     ]
> >                     [
> >                         (asm_input:DI ("A"))
> >                     ]  ("drivers/char/hpet.c") 452))
> >             (clobber (reg:QI 19 dirflag))
> >             (clobber (reg:QI 18 fpsr))
> >             (clobber (reg:QI 17 flags))
> >         ] ) -1 (insn_list 92 (nil))
> >     (nil))
> > drivers/char/hpet.c:803: confused by earlier errors, bailing out
> > make[2]: *** [drivers/char/hpet.o] Error 1
> > make[1]: *** [drivers/char] Error 2
> > make: *** [drivers] Error 2
> >
>
> Same compiler works OK here, so it's presumably "fixed" by some some good
> .config luck.
>
> If we can find a decent workaround in-kernel it's worth putting it in.
> It's quite possible that inlined hpet_time_div() - please try uninlining
> it.
>

Coincidence - I was about to post the fact that my earlier report
 was due to a pilot error (TM).

I had installed the compat-gcc packages due to legacy software
 which expected /usr/bin/gcc to be the FC2 2.96 GCC, then I
 forgot to point /usr/bin/gcc back to FC4 4.0.2 GCC.

So there is a compiler which bombs, but it's this one:

[asuardi@sandman ~]$ /usr/bin/gcc296 -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux7/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-126)

Sorry for the false alarm about GCC 4.0.2. According to the
 current Documentation/Changes the 2.96 compiler seems to
 be expected to build these kernels, so perhaps there still is
 something to be looked into.

If anyone is interested I can try uninlining hpet_time_div()
 and rebuild with 2.96 then report back.

Thanks,

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
