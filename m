Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbQLLVix>; Tue, 12 Dec 2000 16:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQLLVim>; Tue, 12 Dec 2000 16:38:42 -0500
Received: from mail2.rdc3.on.home.com ([24.2.9.41]:41433 "EHLO
	mail2.rdc3.on.home.com") by vger.kernel.org with ESMTP
	id <S129460AbQLLVid>; Tue, 12 Dec 2000 16:38:33 -0500
Message-ID: <3A3693A8.E0BA83B7@home.com>
Date: Tue, 12 Dec 2000 16:07:52 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: " Paul C. Nendick" <pauly@enteract.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.16 SMP: mtrr errors
In-Reply-To: <F7C565F7C41@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> > kernel: mtrr: base(0xd4000000) is not aligned on a size(0x1800000) boundary
> > last message repeated 2 times
> 
> For some strange reason X thinks that you have 24MB of memory on the G450.
> You can either create 32MB write-combining region at 0xd4000000, or
> teach X that your device occupies 32MB and not 24 (you should do it anyway,
> region size can be only power of two)...

Petr, the Matrox card splits the memory between the two video screens
when running in a multi-head configuration and "pretends" that it is two
distinct cards. Thus, a 32 mb card will register an mtrr for 24mb and
for 8mb seperately when in this mode.

At line 1190 in arch/i386/kernel/mtrr.c the switch on Intel falls
through hitting the error message for Centaur. I know the comment says
to fall through, but is this correct? I've inserted a break at the end
of the Intel switch before and have not had problems, but I left it out
in the latest couple of kernels because of all the mtrr work being done,
waiting to see if there was resolution.

John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
