Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTHWMU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTHWMU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:20:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:9196 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263751AbTHWMUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:20:42 -0400
Date: Sat, 23 Aug 2003 14:20:39 +0200 (MEST)
Message-Id: <200308231220.h7NCKdrC017875@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: kenton.groombridge@us.army.mil, patrick@dreker.de
Subject: Re: nforce2 lockups
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003 10:41:46 +0900, kenton.groombridge@us.army.mil wrote:
>I had done this before but without the nolapic option.  That appears to have been the solution.  Ran a whole day without one lockup where before 10 minutes was rarely achieved.
...
>It looks like the nolapic kernel parameter was just recently introduced.  I tried it in both the 2.4.22-rc2 kernel and the 2.6.0-test3 kernel with success in both.
>
>Would still like apic to be completely fixed in the nforce2 chipsets, but I am just happy to have a working system again.

"nolapic" does not exist in standard 2.4.22-rc2 or 2.6.0-test3 kernels.
The patch which added nolapic support was included in 2.6.0-test3-bk8,
and 2.6.0-test<2or3>-mm<something> before that.

Passing nolapic to a kernel which doesn't recognise it causes it to
simply be passed through to init, with no error message.
So either you used non-standard versions of 2.4.22-rc2/2.6.0-test3,
or nolapic wasn't the thing that fixed your nforce2 board.

"noapic" (note: no "l") might very well fix your board, but that's
a completely different animal: it disables the I/O-APIC, which
handles board-level interrupt routing. In a kernel that supports it,
"nolapic" effectively also disables the I/O-APIC.

acpi=off or pci=noacpi might also fix the board, if ACPI is busted.

/Mikael
