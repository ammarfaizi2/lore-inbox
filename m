Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274161AbRIXTId>; Mon, 24 Sep 2001 15:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274505AbRIXTIY>; Mon, 24 Sep 2001 15:08:24 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:21554 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274161AbRIXTIP>; Mon, 24 Sep 2001 15:08:15 -0400
Subject: Re: Linux 2.4.9-ac15
From: Robert Love <rml@tech9.net>
To: Kent Borg <kentborg@borg.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LMKL <linux-kernel@vger.kernel.org>
In-Reply-To: <20010924145944.A23589@borg.org>
In-Reply-To: <200109241610.f8OGAUk19897@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
	<E15lYYQ-00032z-00@the-village.bc.nu>  <20010924145944.A23589@borg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 24 Sep 2001 15:08:22 -0400
Message-Id: <1001358505.5382.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-24 at 14:59, Kent Borg wrote:
> Does CONFIG_APM depend upon CONFIG_MAGIC_SYSRQ?  Is it supposed to?

No, it shouldn't.  There must of been a bug in the new sysrq code merged
in.  Personally, I would just enable sysrq support for now.

> I tried doing a build of 2.4.9-ac15 plus
> patch-rml-2.4.10-pre12-preempt-kernel-1 (which did apply nicely with
> only one hunk moved only one line), but my build failed with:

Btw, this isn't the preemption patches fault, although I would recommend
you use the patches I make explicitly for Alan's tree. 2.4.9-ac14 will
apply cleanly and is at http://tech9.net/rml/linux

>   arch/i386/kernel/kernel.o: In function `apm':
>   arch/i386/kernel/kernel.o(.text+0xbd35): undefined reference to `__sysrq_lock_table'
>   arch/i386/kernel/kernel.o(.text+0xbd3c): undefined reference to `__sysrq_get_key_op'
>   arch/i386/kernel/kernel.o(.text+0xbd4d): undefined reference to `__sysrq_put_key_op'
>   arch/i386/kernel/kernel.o(.text+0xbd54): undefined reference to `__sysrq_unlock_table'
> 
> Which is apm.c failing on the likes of: 
> 
>   register_sysrq_key('o',&sysrq_poweroff_op);
> 
> and:
> 
>   unregister_sysrq_key('o',&sysrq_poweroff_op);
> 
> If I turn on CONFIG_MAGIC_SYSRQ, it builds happily.

I am not familar with the code, but either apm.c needs to wrap its sysrq
calls with ifdefs or the sysrq code needs to optimize away via defines
its various sysrq functions if it is not enabled.

The maintainer (Crutcher?) should see this.

> Previously 2.4.9-ac12 with the same rml preemption patch was happy to
> compile for me.  I have been using it on my Sony Vaio PCG-Z505LE
> happily.
> 
> 2.4.10 is also happy to compile without CONFIG_MAGIC_SYSRQ.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

