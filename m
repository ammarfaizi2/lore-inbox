Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUHMO32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUHMO32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 10:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUHMO32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 10:29:28 -0400
Received: from holomorphy.com ([207.189.100.168]:5780 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265833AbUHMO30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 10:29:26 -0400
Date: Fri, 13 Aug 2004 07:29:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040813142913.GF11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <20040812020424.GB11200@holomorphy.com> <20040812072058.GH11200@holomorphy.com> <20040813080116.GY11200@holomorphy.com> <20040813091640.GZ11200@holomorphy.com> <20040813093002.GA11200@holomorphy.com> <20040813094614.GB11200@holomorphy.com> <20040813100540.GC11200@holomorphy.com> <20040813102334.GD11200@holomorphy.com> <20040813103902.GE11200@holomorphy.com> <Pine.LNX.4.58.0408131015070.18353@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408131015070.18353@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004, William Lee Irwin III wrote:
>>               text    data     bss     dec     hex filename
>> mainline:    19973522        6607761 1878448 28459731        1b242d3 vmlinux
>> cool:        19839487        6585707 1878448 28303642        1afe11a vmlinux
>> C-func:      19923848        6582771 1878384 28385003        1b11eeb vmlinux
>> unlock:      19895498        6582746 1878384 28356628        1b0b014 vmlinux
>> unlock-irq:  19889858        6582721 1878384 28350963        1b099f3 vmlinux
>> read-unlock: 19883858        6582674 1878384 28344916        1b08254 vmlinux
>> irqrestore:  19855759        6582442 1878384 28316585        1b013a9 vmlinux
>> rdunlockirq: 19855255        6582369 1878384 28316008        1b01168 vmlinux
>> rdunlckrstr: 19855007        6582236 1878384 28315627        1b00feb vmlinux

On Fri, Aug 13, 2004 at 10:15:45AM -0400, Zwane Mwaikambo wrote:
> I was meaning to ask before, got ideas for lock profiling with this?

I don't have anything concrete, no. I suspect the same comments apply
generically to all architectures. One possible modification would be
for profile_tick() (in current -mm) to check for the text address being
in some ELF section dedicated to out-of-line locking functions and
unwind the stack one frame and account the tick to the caller.

The more problematic aspect of all this is that x86 is unique in its
code footprint for the unlock functions and IRQ masking being so small
as to merit inlining of these things. So the notion of a uniform API
that serves all architectures equally well is out the window.


-- wli
