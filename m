Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130994AbQKCUVT>; Fri, 3 Nov 2000 15:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbQKCUVJ>; Fri, 3 Nov 2000 15:21:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2308 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131522AbQKCUU5>; Fri, 3 Nov 2000 15:20:57 -0500
Date: Fri, 3 Nov 2000 15:20:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: george@moberg.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land  programmer...
In-Reply-To: <3A03120A.DFC62AD5@moberg.com>
Message-ID: <Pine.LNX.3.95.1001103151639.4372A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000 george@moberg.com wrote:

> Considering that the threading library for Linux uses signals to make it
> work, would it be possible to change the Linux kernel to operate the way
> BSD does--instead of returning EINTR, just restart the interrupted
> primitive?
> 
It's just how the default for signal() is set up by the 'C' runtime
library. Instead of using signal, use sigaction(), set the SA_RESTART
flag and you have BSD action.

It is also possible to compile existing applications using

-D_BSD_SIGNALS  (this is from memory, it might not be exactly correct).

New applications should not use signal(), then should use sigaction()
which gives POSIX-defined fine control over the signal handler.


Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
