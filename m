Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313572AbSDEVG7>; Fri, 5 Apr 2002 16:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313577AbSDEVGt>; Fri, 5 Apr 2002 16:06:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6712 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313572AbSDEVGd>; Fri, 5 Apr 2002 16:06:33 -0500
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org> <20020405080115.GA409@ucw.cz>
	<m1k7rmpmyq.fsf@frodo.biederman.org> <20020405084733.GG609@ucw.cz>
	<m1g02aplmm.fsf@frodo.biederman.org> <20020405090846.GL609@ucw.cz>
	<m1bscypjiu.fsf@frodo.biederman.org> <20020405105911.GA3116@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2002 13:59:59 -0700
Message-ID: <m14ripq2sw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> writes:

> For such purposes, it would be wonderful if somebody could teach gas
> how to assemble absolute code and make real location of code and base
> for calculation of symbols independent. 

Agreed.  This is what is really wanted for gas to know that %ds
points to the start of .text or some other section.  This would allow
gas to resolve section relative addresses without asking for
assistance from the linker.  Or if it did ask for assistance the
linker could give the desired answer...

> It probably could be done with
> sections and a cleverly written ldscript (modulo ld bugs), but it's
> nowhere near elegant.

I have two ideas to clear up the picture a little, and still retain
the full usefulness of the .o files.  Since the code is relocatable
it is simply nonsense to directly use any of the addresses it
exports.  All that is interesting are the load addresses, and relative
offsets.

replace ``foo - start'' with: ``D(foo)'' where the macro does the
work.

Or use a linker script of the form:
.bootsect 0 : AT(0x90000) {
	*(.bootsect)
}
.setup 0 : AT(0x90200) {
	*(.setup)
}

The ld bugs I have seen have mostly been related to choosing file
offsets to store the data, and ELF program headers, so I this
shouldn't tickle any of ld's bugs.

Which form do you prefer?

Eric

