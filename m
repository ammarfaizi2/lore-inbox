Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBVLcp>; Thu, 22 Feb 2001 06:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRBVLcf>; Thu, 22 Feb 2001 06:32:35 -0500
Received: from ns1.bmlv.gv.at ([193.171.152.34]:45069 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S129111AbRBVLcD>;
	Thu, 22 Feb 2001 06:32:03 -0500
Message-Id: <3.0.6.32.20010222123207.009138d0@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Thu, 22 Feb 2001 12:32:07 +0100
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@mail.bmlv.gv.at>
Subject: some char * optimizations in kernel
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

looking through the sources I found several pieces like
lib/vsprintf.c, line 111:
	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";

As tested with egcs-2.91.60 even with -O3 there is a difference
between 
	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
and
	const char digits[]="0123456789abcdefghijklmnopqrstuvwxyz";

in the resulting assembler code.


Usage of this pointer results in it being loaded in a register, and then
pushed on the stack (for subrouting using); if it's an array, the address
is pushed directly.

Furthermore, in the "char *"-case the pointer is stored in memory.



As I'm not at home I can't give a complete reference of all these cases.
(But it's trivial [at least for me :-)] using perl).

So if this changes are approved and I have the time I can post a diff in
the next few days.


BTW: For which size of patch is it possible to get included in the "Hall of
fame" (has helped with linux kernel)?
And, btw too, where can I find a maintainer of a specific file? eg., one of
these cases is in init/version.c which has "Copyright (C) 1992  Theodore
Ts'o" - but I have to guess it's tytso@valinux.com.
Is there something like Documentation/maintainers?



Regards,

Phil

