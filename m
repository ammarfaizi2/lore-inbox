Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQKAMok>; Wed, 1 Nov 2000 07:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbQKAMoa>; Wed, 1 Nov 2000 07:44:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30980 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129029AbQKAMo0>; Wed, 1 Nov 2000 07:44:26 -0500
Date: Wed, 1 Nov 2000 07:44:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: mdaljeet@in.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: system call handling
In-Reply-To: <CA25698A.00434741.00@d73mta05.au.ibm.com>
Message-ID: <Pine.LNX.3.95.1001101073637.6028A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000 mdaljeet@in.ibm.com wrote:

> Hi,
> 
> By looking into the structure of GDT as used by linux kernel(file
> include/asm/desc.c, kernel ver 2.4), it appears as if linux kernel does not
> use the "call gate descriptors" for system call handling. Is this correct?
> 

You could use a call-gate to get from one priv level to another but
Linux uses a software trap (int 0x80). It provides good locality
of the kernel entry code which helps keep caches warm. If you used
call-gates, their entry points would be scattered all over kernel
space. Further, you'd  have a lot of them (as many as there are
kernel functions).

If you designed it with just one call-gate, with one entry point,
you would have exactly what we have now except you would execute
a `call	CALL_GATE` instead of `int 0x80`. This turns out to be
6 of one and 1/2 dozen of another when it comes to performance.

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
