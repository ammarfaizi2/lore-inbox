Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRCTLZH>; Tue, 20 Mar 2001 06:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCTLY5>; Tue, 20 Mar 2001 06:24:57 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:29451 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129712AbRCTLYl>;
	Tue, 20 Mar 2001 06:24:41 -0500
Date: Tue, 20 Mar 2001 12:23:53 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Parity Error <bootup@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: switch_to()/doesnt %esp get replaced with %ebp on ret
Message-ID: <20010320122353.A7373@pcep-jamie.cern.ch>
In-Reply-To: <20010319150425.D19104@pcep-jamie.cern.ch> <E14fJjA-000Pf0-00@f6.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14fJjA-000Pf0-00@f6.mail.ru>; from bootup@mail.ru on Tue, Mar 20, 2001 at 01:51:00PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parity Error wrote:
> I dont know if you understood my doubt, but your pointer
> to bp accidentally or otherwise solved the mystery. 

We agree, and I like your explanation.

> Still, could some one enlighten me on why esi and edi are
> also similarly saved and restored ?

The compiler _may_ cache other values in those registers across the call
to switch_to.  Although this doesn't happen in your kernel, it does
sometimes happen and switch_to must be coded to assume that it does.

You can safely remove the esi & edi pushes and pops, if you put those
registers in the "clobber" list of the asm.  In theory that's best,
because then the compiler will save the register values itself only if
it needs to.

In practice, putting them in the clobber list sometimes results in worse
code, at least when I tried this in the 2.2 series.

You can't put ebp in the clobber list for some reason: GCC silently
ignores it.  (Maybe that's fixed now too, I don't know).

-- Jamie
