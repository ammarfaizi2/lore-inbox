Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132340AbQKDBcX>; Fri, 3 Nov 2000 20:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132296AbQKDBcO>; Fri, 3 Nov 2000 20:32:14 -0500
Received: from lina.inka.de ([212.227.16.17]:49172 "EHLO matrix.inka.de")
	by vger.kernel.org with ESMTP id <S132375AbQKDBb7>;
	Fri, 3 Nov 2000 20:31:59 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] two swapping processes freeze 2.4.0-test10 (but not 2.2.18pre19)
Message-Id: <E13rsBQ-0004bX-00@calista.inka.de>
Date: Sat, 04 Nov 2000 02:31:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0011012222210.1296-100000@shimura.math.berkeley.edu> you wrote:
> I simultaneously run "top d1" and two of the test computations.  All is
> well (top updates smoothly) until physical RAM is exhausted.  However, as
> soon as swap is touched, then top freezes and does not update.  In this
> state, I can switch virtual consoles but not login to a new one; the
> machine is pingable but does not respond to ssh.  Once swap is exhausted,
> the OOM killer kicks in and kills one of the test computations; then all
> is well and everything works as expected.

Yes, i described the same behaviour. Rick answered, that the swap out
situation is stopping other processes, since the out of free memory
situation will also page out other active processes' pages.

I suggested a fix to actually start to page out only a own process pages if
the system is that short that it starts to page out very recently used
pages.

this will lead to the efect, that as long as there are unused pages on the
system one growing process can page out other pages "idle" pages. But as
soon as the growing process can only page out other processes (which will in
turn page in their own pages, ...) we should chnage page out strategy and
only page out the oldest pages of the growing process. Therefore the swap
penalty is fully on the growing process.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
