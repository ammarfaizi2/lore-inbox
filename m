Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWFLRIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWFLRIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWFLRIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:08:14 -0400
Received: from mail2.utc.com ([192.249.46.191]:4835 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S1751095AbWFLRIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:08:13 -0400
Message-ID: <448D9F70.2040400@cybsft.com>
Date: Mon, 12 Jun 2006 12:08:00 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.17-rc6-rt3
References: <20060610082406.GA31985@elte.hu>
In-Reply-To: <20060610082406.GA31985@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------000202090703030306010905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202090703030306010905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the 2.6.17-rc6-rt3 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-only release: lots of fixes from Thomas Gleixner (for 
> the softirq problem that caused those ping latency weirdnesses, for 
> hrtimers and timers problems and for the RCU related bug that was 
> causing instability and more), John Stultz, Jan Altenberg and Clark 
> Williams. MIPS update from Manish Lachwani. Futex fix from Dinakar 
> Guniguntala. It also includes the RT-scheduling SMP fix that could fix 
> the scheduling problem reported by Darren Hart.
> 
> I think all of the regressions reported against rt1 are fixed, please 
> re-report if any of them is still unfixed.
> 
> to build a 2.6.17-rc6-rt3 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17-rc6.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.17-rc6-rt3
> 
> 	Ingo

This one still doesn't boot for me on a dual Xeon 2.60. Config is
attached and oops is included below.

*****************************************************************************
*
    *
*  REMINDER, the following debugging option is turned on in your
.config:   *
*
    *
*        CONFIG_DEBUG_RT_MUTEXES
     *
*
    *
*  it may increase runtime overhead and latencies.
    *
*
    *
*****************************************************************************
Freeing unused kernel memory: 200k freed
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
BUG: unable to handle kernel paging request at virtual address f3010000
 printing eip:
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c0132f9c>]    Not tainted VLI
EFLAGS: 00010297   (2.6.17-rc6-rt4 #10)
EIP is at lookup_symbol+0x11/0x35
eax: 00000001   ebx: e083185c   ecx: c02f20c4   edx: c02f0000
esi: f3010000   edi: e083185c   ebp: df597e80   esp: df597e74
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process modprobe (pid: 1419, threadinfo=df596000 task=dec3ac90
stack_left=7744 worst_left=-1)
Stack: e083b580 00000bf0 e083185c df597e9c c0132fe5 df597eb4 df597eb0
e083b580
       00000bf0 e083185c df597ec4 c0133c93 00000001 00000012 e082dde8
00000000
       df597ed8 e0839200 00000bf0 e082dde8 df597ee8 c01341fa e083b580
00000000
Call Trace:
 [<c01036a1>] show_stack_log_lvl+0x82/0x8a (36)
 [<c0103821>] show_registers+0x139/0x1a1 (32)
 [<c0103a15>] die+0x118/0x1df (60)
 [<c0110cf3>] do_page_fault+0x45c/0x532 (76)
 [<c010336b>] error_code+0x4f/0x54 (72)
 [<c0132fe5>] __find_symbol+0x25/0x1b7 (28)
 [<c0133c93>] resolve_symbol+0x27/0x5f (40)
 [<c01341fa>] simplify_symbols+0x83/0xf3 (36)
 [<c0134e31>] load_module+0x668/0x9e2 (184)
 [<c0135210>] sys_init_module+0x42/0x1a4 (20)
 [<c01027fb>] sysenter_past_esp+0x54/0x75 (-8116)
Code: eb 11 8b 75 f0 41 83 c2 28 0f b7 46 30 39 c1 72 c9 31 c0 5a 59 5b
5e 5f 5d c3 55 89 e5 57 56 53 89 c3 39 ca 73 22 8b 72 04 89 df <ac> ae
75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 04 89
EIP: [<c0132f9c>] lookup_symbol+0x11/0x35 SS:ESP 0068:df597e74




-- 
   kr

--------------000202090703030306010905
Content-Type: application/x-gzip;
 name="config-2.6.17-rc6-rt3.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config-2.6.17-rc6-rt3.gz"

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
--------------000202090703030306010905--
