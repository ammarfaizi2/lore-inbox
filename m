Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTKMQkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTKMQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:40:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:47523 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264366AbTKMQk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:40:27 -0500
Date: Thu, 13 Nov 2003 08:40:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jochen Voss <voss@seehuhn.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
In-Reply-To: <20031113112740.GA4719@seehuhn.de>
Message-ID: <Pine.LNX.4.44.0311130836150.8093-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Nov 2003, Jochen Voss wrote:
> 
>     smp_read_mpc(arch/i386/kernel/mpparse.c):
>       The argument mpc points to a 'struct mp_config_table',
>         which is filled with zero bytes (compare memory dump
>         below).
>       The 'if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4))' test
>         fails because of this and calls 'panic'.
>       The kernel never returns from the call to 'panic'.
> 
> Herbert Xu produced a patch, which converts the crash into an error
> message, so the symptoms are cured for me.

Ok. That panic is obviously crud from a lazy initial developer, and yes, 
it's always silly (and very very wrong) to crash if you can just continue.

Can you send the (tested) patch over?

> Now for my questions: As far as I can see it, the invalid
> SMP mptable is a BIOS bug on my machine.  Do you think so,
> too?  Or are there other possibilities?

I think it's a Linux bug too, although I'll agree that it was triggered by 
some really bad BIOS behaviour. I bet the laptop vendor doesn't care: they 
probably depend on ACPI to set the thing up on Windows, and Windows is 
likely to just ignore the MP table (properly) when it doesn't need it (or 
when it is corrupt).

> Do you think it would be helpful to contact Toshiba (my
> laptop's vendor) about this?

I really think that the Linux behaviour i smore of a bug than the BIOS 
behaviour. There's no excuse for panicing just because some signature 
for a data block that we don't even strictly need isn't there.

			Linus

