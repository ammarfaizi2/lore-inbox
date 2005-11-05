Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVKENrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVKENrq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 08:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVKENrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 08:47:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13322
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1750863AbVKENrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 08:47:45 -0500
Date: Sat, 5 Nov 2005 14:47:27 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: disable tsc with seccomp
Message-ID: <20051105134727.GF18861@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This changeset is backing out an useful feature I implemented some month
ago:

        http://kernel.org/hg/linux-2.6/?cs=2fd4e5f089df

Anything that can strengthen security is needed, the covert channels are
theoretically possible and this is a fact, you don't need hyperthreading
for that.

I tried to convince you a few times privately but I failed, and now that
you made mainline less secure, I have to raise the topic on l-k since
all other attemps to convince you privately already failed.

As I told you a few times, in real life any admin that doesn't notice a
task running at 100% cpu load for months means there are more serious
problems in that server, than the risk of covert channel. Because of
that, covert channels remains mostly a theoretical problem in servers.

But with the CPUShare usage of seccomp, running untrusted bycode for
months at 100% cpu load is the norm, so we must disable all high
precision timing information that we can disable.

Infact we should disable MISC_ENABLE too at runtime (if possible).

Furthermore i386 still has the tsc disable with seccomp, so the fact my
patch is still applied to i386 and has been backed out only of x86-64 is
a nosense. Either we back out both (and I strongly disagree with that),
or we keep both applied (this is what I'm suggesting). Current status
makes no sense to me.

If the end result of this discussion will be that both patches are
backed out, I'll rewrite them with a config option (turned off by
default). So the CPUShare users that wants to be safer, can enable it
when compiling the kernel (plus crossing fingers in the hope that
distros would also enable it before compiling their kernels). A config
option would make it acceptable even in the worst case I hope.

I think it would have been nicer from your part to at least make it a
config option instead of dropping it right away, especially after I
explicitly asked you not to drop it.

Thanks.
