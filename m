Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270632AbRHJAgy>; Thu, 9 Aug 2001 20:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270633AbRHJAgo>; Thu, 9 Aug 2001 20:36:44 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:52734 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S270632AbRHJAgl>;
	Thu, 9 Aug 2001 20:36:41 -0400
Date: Fri, 10 Aug 2001 02:36:50 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200108100036.CAA09153@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, safemode@speakeasy.net
Subject: Re: kapm-idled shows 90+% cpu usage when idle
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001 19:33:42 -0400, safemode <safemode@speakeasy.net> wrote:
>Is this a true usage reading or just some quirk that's supposed to happen?   
>I really doubt that this kernel daemon should really be using  cpu.  It seems 
>to respond with a higher cpu usage when i'm idle.  It immediately goes away 
>when something else uses cpu.   If you need any more info just ask.   I'm 

Do you have CONFIG_APM_CPU_IDLE=y in your .config? If so, disable it.

There was a thread about this problem some months ago. I found
that on all of my APM-capable machines, including a Dell laptop,
CONFIG_APM_CPU_IDLE=y had a negative effect. The kernel ended up
in a tight loop performing tons of APM IDLE BIOS calls, since each
BIOS call returned immediately without having idled the CPU.

Leaving CONFIG_APM_CPU_IDLE unset lets the kernel use its own
"HLT when idle" code. On my main development box, idle CPU
temperature dropped >10 degrees C, and kapm-idled now uses 0% CPU.

/Mikael
