Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129839AbQKBWnR>; Thu, 2 Nov 2000 17:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129843AbQKBWnI>; Thu, 2 Nov 2000 17:43:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1797 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129839AbQKBWmu>; Thu, 2 Nov 2000 17:42:50 -0500
Date: Thu, 2 Nov 2000 17:42:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Paul Marquis <pmarquis@iname.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() bug
In-Reply-To: <E13rSpZ-0001z2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1001102173819.18044A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Alan Cox wrote:

> > that are log file handlers are dead.  If select() reports it can't
> > write immediately, Apache terminates and restarts the child process,
> > creating unnecessary load on the system.
> 
> Is there anything saying that select has to report ready the instant a byte
> would fit. Certainly its better for performance to reduce the context switch
> rate by encouraging blocking
> 

It looks as though, when select() is reporting that the pipe is
NOT writable, the code writes anyway -- then complains that it
could be written.

This is a code bug. The pipe can certainly become writable during
the time interval between when it was checked by select() and the
attempt to write the byte.


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
