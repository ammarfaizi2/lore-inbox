Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290618AbSBLAMl>; Mon, 11 Feb 2002 19:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290627AbSBLAMb>; Mon, 11 Feb 2002 19:12:31 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:55170 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S290618AbSBLAMZ>; Mon, 11 Feb 2002 19:12:25 -0500
Message-ID: <3C685E20.8070707@oracle.com>
Date: Tue, 12 Feb 2002 01:13:20 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: [BUG] Panic in 2.5.4 during bootup after POSIX conformance	testing by UNIFIX
In-Reply-To: <Pine.LNX.4.30.0202111453330.28560-200000@mustard.heime.net> 	<3C67D9CB.2030806@oracle.com> <1013454372.6781.418.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> Can both of you try the attached patch (thanks to Mikael Pettersson),
> and tell me if it solves your problem?

Yup, it does :)

Now I'm only IrDA and sound disabled - which isn't bad, since at least
  the streak of 5 kernels in a row either not compiling or oopsing on
  boot (my longest _ever_) has been interrupted ;)

> 
> --- linux-2.5.4/include/asm-i386/smplock.h.~1~  Mon Feb 11 12:21:46 2002
> +++ linux-2.5.4/include/asm-i386/smplock.h      Mon Feb 11 16:55:18 2002
> @@ -15,7 +15,7 @@
>  #else
>  #ifdef CONFIG_PREEMPT
>  #define kernel_locked()                preempt_get_count()
> -#define global_irq_holder      0
> +#define global_irq_holder      0xFF    /* XXX: NO_PROC_ID */
>  #else
>  #define kernel_locked()                1
>  #endif

--alessandro

  "If your heart is a flame burning brightly
    you'll have light and you'll never be cold
   And soon you will know that you just grow / You're not growing old"
                               (Husker Du, "Flexible Flyer")

