Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVFUIyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVFUIyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVFUIPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:15:07 -0400
Received: from soufre.accelance.net ([213.162.48.15]:61392 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261626AbVFUHPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:15:24 -0400
Message-ID: <42B7BE86.6060502@xenomai.org>
Date: Tue, 21 Jun 2005 09:15:18 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] I-pipe: Core implementation
References: <42B35B07.7080703@xenomai.org> <20050618170139.GA477@openzaurus.ucw.cz> <42B7272F.2040503@xenomai.org> <42B74781.8000109@opersys.com>
In-Reply-To: <42B74781.8000109@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Philippe Gerum wrote:
> 
>>There's a fourth one (ipipe/x86.c) added by the arch-dependent patch, 
>>but yes, I agree that this could sound rather overkill to have this 
>>support in its own dir, especially a top-level one. The files under 
>>ipipe/ can be built as a loadable module, hence the current layout.
>>Would you see this belonging to, e.g., the driver tree instead?
> 
> 
> How about this instead:
> 
> Arch-indepedent parts:
> ----------------------
> include/linux/ipipe.h
> 
> kernel/ipipe/Kconfig      (formerly ipipe/Kconfig)
> kernel/ipipe/Makefile     (formerly ipipe/Makefile)
> kernel/ipipe/core.c       (formerly kernel/ipipe.c)
> kernel/ipipe/generic.c    (formerly ipipe/generi.c)
> 
> Arch-dependent parts:
> ---------------------
> include/asm-i386/ipipe.h
> 
> arch/i386/kernel/ipipe-core.c  (formerly arch/i386/kernel/ipipe.c)
> arch/i386/kernel/ipipe-root.c  (formerly ipipe/x86.c)
> 
> Seems to me that the above makes more sense. Albeit you would have
> parts of the module in kernel/ipipe/* and the rest in
> arch/*/kernel/ipipe*.

I'm pondering now if having the i-pipe buildable as a module is still 
relevant, like it was during the early Adeos times. This was mainly used 
to reduce the compile-debug-reboot cycle, so that we could just unload 
the module for testing some non-critical Adeos features which were not 
related to the interrupt pipeline. This becomes clearly irrelevant in 
the i-pipe case (any bug in the i-pipe would very likely make the box go 
south anyway).
Additionally, dealing with a dynamically loadable i-pipe adds a small 
but permanent overhead for testing if the pipeline is enabled during 
internal operations.

Any objection to make the pipeline a static-only feature?

-- 

Philippe.
