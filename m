Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130826AbQKCT3A>; Fri, 3 Nov 2000 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131202AbQKCT2v>; Fri, 3 Nov 2000 14:28:51 -0500
Received: from neuron.moberg.com ([209.152.208.195]:57870 "EHLO
	neuron.moberg.com") by vger.kernel.org with ESMTP
	id <S130826AbQKCT2n>; Fri, 3 Nov 2000 14:28:43 -0500
Message-ID: <3A03120A.DFC62AD5@moberg.com>
Date: Fri, 03 Nov 2000 14:29:14 -0500
From: george@moberg.com
Organization: Moberg Research, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can EINTR be handled the way BSD handles it? -- a plea from a user-land 
 programmer...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Considering that the threading library for Linux uses signals to make it
work, would it be possible to change the Linux kernel to operate the way
BSD does--instead of returning EINTR, just restart the interrupted
primitive?

For example, if I'm using read(2) to read data from a file descriptor,
and a signal happens, the signal handler runs, and read(2) returns EINTR
after the system call finishes.  Then I'm supposed to catch this and
re-try the system call.

I assume that this is true for _any_ system call which makes the process
block, right?

Can we _PLEASE_PLEASE_PLEASE_ not do this anymore and have the kernel do
what BSD does:  re-start the interrupted call?

Please?  If this is something that would be acceptable for integration
into a mainline kernel, I would do my best to help with a patch.

If I'm wrong about this, please enlighten me.  Also, please cc: me off
the list, as I don't get the list directly.

Thank you for your consideration.
--
George T. Talbot
<george at moberg dot com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
