Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUIMPay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUIMPay (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUIMP34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:29:56 -0400
Received: from relay.pair.com ([209.68.1.20]:9993 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268368AbUIMPXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:23:47 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4145BB30.60309@kegel.com>
Date: Mon, 13 Sep 2004 08:22:24 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix allnoconfig on arm with small tweak to kconfig?
References: <414551FD.4020701@kegel.com> <20040913091534.B27423@flint.arm.linux.org.uk>
In-Reply-To: <20040913091534.B27423@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Sep 13, 2004 at 12:53:33AM -0700, Dan Kegel wrote:
> 
>>'make allnoconfig' generates a broken .config on arm because
>>none of the boolean CPU types get selected.
>>ARCH_RPC *does* get selected ok, and I can make CPU_SA110 the
>>default if ARCH_RPC, but that doesn't help, since allnoconfig
>>sets all booleans that are exposed to the user to false, so
>>CPU_SA110 remains false.
> 
> 
> allnoconfig is broken.  It doesn't generate a legal configuration on
> this platform.

I think that's what I said.  I guess you're saying it more forcefully;
you seem to be implying "the basic idea of allnoconfig is broken."

> There are cases where you have the choice of selecting several options
> and you may select one or more.  Zero options selected is not valid.
> Unfortunately, Kconfig does not provide a way to express this.

I think that's also what I said.

>>I tried it (see patch below), but couldn't get it to work in first
>>few tries.  Can someone who understands kconfig have a look?
> 
> 
> I don't think hacking around allnoconfig works - it means that we
> have to decide on a default for every configuration.  ARCH_RPC is
> only one such small case.  There's loads more.

I guess it depends on your goals.  My goal is to use allnoconfig
as a toolchain regression test.  For each arch, I want an easy way
to build some kernel (any kernel!) for that arch.  ARCH_RPC
is the default on arm (yes, I know you think the whole
concept of defaults on arm is broken), so it's the only one that
needs fixing.

Any feedback from people who don't think allnoconfig is a useless idea?

Thanks,
Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
