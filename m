Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSE0WXA>; Mon, 27 May 2002 18:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSE0WW7>; Mon, 27 May 2002 18:22:59 -0400
Received: from jalon.able.es ([212.97.163.2]:40352 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316773AbSE0WW6>;
	Mon, 27 May 2002 18:22:58 -0400
Date: Tue, 28 May 2002 00:22:53 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Use of CONFIG_M686
Message-ID: <20020527222253.GG1848@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Grepping through the sources or the kernel in search of CONFIG_M686
occurences, there are some places where it looks like that flag is
used as 'Anything bigger than a Pentium'. Now kernel has configs
for PIII, P4, probably PII.

It is the f00f bug handling. Files:

arch/i386/kernel/traps.c:

#ifndef CONFIG_M686 <=================== which also passes if PII, P4...
void __init trap_init_f00f_bug(void)
...

arch/i386/kernel/setup.c:

static void __init init_intel(struct cpuinfo_x86 *c)
{
#ifndef CONFIG_M686 <=================== again
    static int f00f_workaround_enabled = 0;
...


So thats why I asked if we could use a CONFIG_MPENTIUMPRO, and make
CONFIG_M686 a generic flag that is also defined for anything bigger
than a Pentium (that looks like the current usage).

So:
Pentium -> M586
PPro    -> MPENTIUMPRO M686
PII     -> MPENTIUMII  M686
PIII    -> MPENTIUMIII M686
P4      -> MPENTIUM4   M686


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #2 SMP dom may 26 11:20:42 CEST 2002 i686
