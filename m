Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265593AbRGCI1M>; Tue, 3 Jul 2001 04:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265594AbRGCI1C>; Tue, 3 Jul 2001 04:27:02 -0400
Received: from PO9.ANDREW.CMU.EDU ([128.2.10.109]:49033 "EHLO
	po9.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S265593AbRGCI0y>; Tue, 3 Jul 2001 04:26:54 -0400
Message-ID: <IvEM6Gxz0001IavmYU@andrew.cmu.edu>
Date: Tue,  3 Jul 2001 04:25:54 -0400 (EDT)
From: James R Bruce <bruce+@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: serial port O_SYNC functionality in 2.4.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As far as I can tell from observed operation and from perusing the
code, O_SYNC doesn't seem to be supported by the serial driver in
2.4.5.  Writes are forced as far as the serial.c's circular queue, but
O_SYNC seems to be ignored from there on, so any application trying to
do small synchronous writes to the serial port will end up backing it
up PAGE_SIZE bytes rather than getting synchronous operation (which is
incidentally what I was trying to do when I ran into this :).

I'm unfamiliar with the serial driver so I'm not sure the right way to
fix it is, but perhaps using a smaller value for WAKEUP_CHARS from
drivers/char/serial.c when the port is opened with O_SYNC
functionality might do the trick (i.e. 0 rather than 256).

Hopefully someone familiar with that part of the code please can tell
me what should be done... or if a patch or configuration option can
already get that functionality in another way.

Thanks,
  Jim Bruce

