Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVEGOkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVEGOkR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 10:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVEGOkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 10:40:17 -0400
Received: from one.firstfloor.org ([213.235.205.2]:28136 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261322AbVEGOkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 10:40:12 -0400
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 Ctx switch times - 32bit vs 64bit
References: <200505052138.57821.kernel-stuff@comcast.net>
From: Andi Kleen <ak@muc.de>
Date: Sat, 07 May 2005 16:40:07 +0200
In-Reply-To: <200505052138.57821.kernel-stuff@comcast.net> (Parag Warudkar's
 message of "Thu, 5 May 2005 21:38:57 -0400")
Message-ID: <m1mzr7w14o.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> writes:

> I was experimenting with the attached program (taken from an IBM 
> Developerworks article) to find the context switch times on AMD64 machine.
>
> With a 64bit binary I get average 5 to 8 usec/cswitch, whereas the same 
> program compiled as 32bit consistently gives >= 10 usec/cswitch - sometimes 
> even 13 usec/cswitch.
>
> Are there more context switching overheads when running 32bit programs on a 
> 64bit kernel?

Should be nearly the same in theory, no. This means 32bit programs use %gs
as thread register which is a bit more costly to switch because
the kernel uses it internally too, but the difference should be less
than that.

I suspect your program is more testing the locks anyways, perhaps
there is some other difference in the glibc. e.g. 32bit glibc compiled
for pre 686 CPUs has slower locks.

oprofile might provide more clue where the overhead is.

-Andi
