Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUG0O2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUG0O2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 10:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUG0O2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 10:28:00 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:28134 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266263AbUG0O15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 10:27:57 -0400
Date: Tue, 27 Jul 2004 10:31:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
In-Reply-To: <20040727132638.7d26e825.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0407271006290.23985@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407270432470.23989@montezuma.fsmlabs.com>
 <20040727132638.7d26e825.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Andi Kleen wrote:

> On Tue, 27 Jul 2004 05:29:10 -0400 (EDT)
> Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> > This is a follow up to the previous patches for ia64 and i386, it will
> > allow x86_64 to reenable interrupts during contested locks depending on
> > previous interrupt enable status. It has been runtime and compile tested
> > on UP and 2x SMP Linux-tiny/x86_64.
>
> This will likely increase code size. Do you have numbers by how much? And is it
> really worth it?

Yes there is a growth;

   text    data     bss     dec     hex filename
3655358 1340511  486128 5481997  53a60d vmlinux-after
3648445 1340511  486128 5475084  538b0c vmlinux-before

And this was on i386;

   text    data     bss     dec     hex filename
2628024  921731       0 3549755  362a3b vmlinux-after
2621369  921731       0 3543100  36103c vmlinux-before

Keith Owens managed to get increased throughput as the original patch was
driven by poor performance from a workload. I think it's worth it just for
the reduced interrupt latency, the code size issue can also be taken care
of, but that requires benchmarking as the change is a bit more drastic.
