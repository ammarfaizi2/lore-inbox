Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbUDGQPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUDGQPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:15:53 -0400
Received: from zero.aec.at ([193.170.194.10]:33546 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263720AbUDGQPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:15:50 -0400
To: Paul Wagland <paul@wagland.net>
cc: linux-kernel@vger.kernel.org, gktnews@gktech.net
Subject: Re: amd64 questions
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it>
	<1IntE-7wn-39@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 07 Apr 2004 18:15:38 +0200
In-Reply-To: <1IntE-7wn-39@gated-at.bofh.it> (Paul Wagland's message of
 "Wed, 07 Apr 2004 17:50:18 +0200")
Message-ID: <m3isgb69xx.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Wagland <paul@wagland.net> writes:

> On Apr 7, 2004, at 13:29, Andi Kleen wrote:
>
>> A few programs (namely iptables and ipsec tools) need to be used
>> as 64bit programs because the 32bit emulation doesn't work for them.
>> ipchains works though.
>
> I seem to recall reading that the DM based programs also need to be 64
> bit, since their 32 bit stuff was also broken?

That was already fixed, but the fix may not be in mainline yet
[and I think it broke ppc64 too]. But right, DM has problems too.

> The question I have is whether or not this is a kernel bug that should
> be fixed? As I understand the DM case, fixing it so that 32bit works,
> then breaks the 64bit interfaces, requiring re-compiles of the DM
> programs.

It is a subsystem bug really. These subsystems were all designed to
not require emulation, but the designers weren't aware of all the
requirements for this and broke it for AMD64/IA64. Unfortunately the
interfaces were done in a way that it would be very complicated and a
lot of work to write an emulation layer, because they're extremly
emulation unfriendly. Maybe it would be still possible to write an
emulation layer, but easier is it to just use static 64bit executables 
or hacked 32bit executables.

I don't have any plans to write emulation layers for such hopeless
cases on my own, but just declared these subsystems as broken.

The problem is always the long long alignment. AMD64/IA64 have different
alignment for long long than i386. The emulation was originally tested
on some RISC port, where the alignment is the same.

-Andi

