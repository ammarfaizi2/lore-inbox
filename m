Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbQKBW66>; Thu, 2 Nov 2000 17:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129925AbQKBW6i>; Thu, 2 Nov 2000 17:58:38 -0500
Received: from c100.clearway.com ([199.103.231.100]:19471 "EHLO
	mercury.clearway.com") by vger.kernel.org with ESMTP
	id <S129830AbQKBW6g>; Thu, 2 Nov 2000 17:58:36 -0500
From: Paul Marquis <pmarquis@iname.com>
To: root@chaos.analogic.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <3A01F191.10652E1F@iname.com>
Date: Thu, 02 Nov 2000 17:58:25 -0500
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.15pre3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Re: select() bug
In-Reply-To: <Pine.LNX.3.95.1001102173819.18044A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the code sample, there is a loop that is run four times.  During
each iteration, a call to select() and write() is done, while every
other iteration does a read().  Between the 1st and 2nd calls to
write(), as well as the 3rd and 4th, select() fails, but all write()'s
and read()'s succeed.  There is no code bug.

Richard B. Johnson wrote:
> On Thu, 2 Nov 2000, Alan Cox wrote:
> 
> > > that are log file handlers are dead.  If select() reports it can't
> > > write immediately, Apache terminates and restarts the child process,
> > > creating unnecessary load on the system.
> >
> > Is there anything saying that select has to report ready the instant a byte
> > would fit. Certainly its better for performance to reduce the context switch
> > rate by encouraging blocking
> >
> 
> It looks as though, when select() is reporting that the pipe is
> NOT writable, the code writes anyway -- then complains that it
> could be written.
> 
> This is a code bug. The pipe can certainly become writable during
> the time interval between when it was checked by select() and the
> attempt to write the byte.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Paul Marquis
pmarquis@iname.com

If it's tourist season, why can't we shoot them?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
