Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTDDDJd (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 22:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTDDDJd (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 22:09:33 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:25853
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261304AbTDDDJZ (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 22:09:25 -0500
Date: Thu, 3 Apr 2003 22:16:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function needs mb() - oopsable
In-Reply-To: <Pine.LNX.4.50.0304031951180.30262-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0304032213400.30262-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0304030937360.27631-100000@home.transmeta.com>
 <Pine.LNX.4.50.0304031951180.30262-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Zwane Mwaikambo wrote:

> I'm compiling with rmb before the APIC EOI, which is after the local 
> variable assignments (i'll post the results in a bit, slow build box).

I just got this which can only be as a result of the changes (the kernel 
has otherwise passed this test case over 10 times over a period of 2 
days). It could be due to me hitting another interrupt whilst in that 
handler (we have interrupts enabled in smp_call_function_interrupt) but 
i'm trying to think of other ways we could otherwise trigger a GPF.

general protection fault: 0000 [#1]
CPU:    1
EIP:    0060:[<08410005>]    Not tainted
EFLAGS: 00210002
EIP is at 0x8410005
eax: 40a2d700   ebx: c010a24a   ecx: c033d1d4   edx: 40a2d760
esi: 40a2d760   edi: 00daf9f8   ebp: 000000c6   esp: c39f9fd4
ds: 007b   es: 007b   ss: 0068
Process rhn-applet (pid: 1507, threadinfo=c39f8000 task=c8316040)
Stack: c4e94f88 bfffec78 000000d6 0000007b 0000007b fffffffb 40a23ef9 
00000073 
       00200216 bfffec48 0000007b 
Call Trace:

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

-- 
function.linuxpower.ca
