Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUIOR2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUIOR2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUIORZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:25:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18562 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267230AbUIORYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:24:00 -0400
Date: Wed, 15 Sep 2004 13:23:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0409151314040.8346@chaos>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Linus Torvalds wrote:

>
> This is a background mail mainly for driver writers and/or architecture
> people. Or others that are just interested in really low-level hw access
> details. Others - please feel free to ignore.
>
[SNIPPED mostly....]


> For example, if you don't know (or, more importantly - don't care) what
> kind of IO interface you use, you can now do something like
>
> 	void __iomem * map = pci_iomap(dev, bar, maxbytes);
> 	...
> 	status = ioread32(map + DRIVER_STATUS_OFFSET);
                          ^^^^^^^^^^^^^^^^

Doesn't this rely on the non-standard GNUism that you can
perform pointer-arithmetic on a void-pointer? Which is illegal,
immoral, and fattening. I'd much rather see char-pointers so
it's valid to perform the offset math. That way, in the future,
a new tool that follows (ANSI, IEEE, POSIX) rules doesn't barf.
I suggest a new pointer type like (BASE *) or (BAR *) that
hides the (unsigned char *) necessary to not barf, plus
minimize side-effects.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

