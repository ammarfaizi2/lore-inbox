Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSE0Wlx>; Mon, 27 May 2002 18:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316796AbSE0Wlw>; Mon, 27 May 2002 18:41:52 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:34542 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S316794AbSE0Wlv>; Mon, 27 May 2002 18:41:51 -0400
Message-ID: <3CF2B549.6020803@didntduck.org>
Date: Mon, 27 May 2002 18:38:01 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Use of CONFIG_M686
In-Reply-To: <20020527222253.GG1848@werewolf.able.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> Hi all...
> 
> Grepping through the sources or the kernel in search of CONFIG_M686
> occurences, there are some places where it looks like that flag is
> used as 'Anything bigger than a Pentium'. Now kernel has configs
> for PIII, P4, probably PII.
> 
> It is the f00f bug handling. Files:
> 
> arch/i386/kernel/traps.c:
> 
> #ifndef CONFIG_M686 <=================== which also passes if PII, P4...
> void __init trap_init_f00f_bug(void)
> ...
> 
> arch/i386/kernel/setup.c:
> 
> static void __init init_intel(struct cpuinfo_x86 *c)
> {
> #ifndef CONFIG_M686 <=================== again
>     static int f00f_workaround_enabled = 0;
> ...
> 
> 
> So thats why I asked if we could use a CONFIG_MPENTIUMPRO, and make
> CONFIG_M686 a generic flag that is also defined for anything bigger
> than a Pentium (that looks like the current usage).
> 
> So:
> Pentium -> M586
> PPro    -> MPENTIUMPRO M686
> PII     -> MPENTIUMII  M686
> PIII    -> MPENTIUMIII M686
> P4      -> MPENTIUM4   M686
> 
> 

I fixed that in 2.5 by introducing CONFIG_X86_F00F_BUG.

http://marc.theaimsgroup.com/?l=linux-kernel&m=101416800017102&w=4

-- 

						Brian Gerst

