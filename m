Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268401AbRGXRzM>; Tue, 24 Jul 2001 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbRGXRyw>; Tue, 24 Jul 2001 13:54:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16258 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268401AbRGXRyr>; Tue, 24 Jul 2001 13:54:47 -0400
Date: Tue, 24 Jul 2001 13:54:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Damien TOURAINE <damien.touraine@limsi.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Call to the scheduler...
In-Reply-To: <3B5DB110.3080606@limsi.fr>
Message-ID: <Pine.LNX.3.95.1010724134717.32263A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Damien TOURAINE wrote:

> Hi !
> I would like to implement a system to actively wait something but 
> without eating a lot of CPU.
> Thus, I would like to know if there is any way to force the scheduler of 
> Linux to pre-empt the current process/thread, like the "sginap(0)" 
> function within IRIX.
> Moreover, I don't want to have to be root to execute such function.
> 
> Friendly
>     Damien TOURAINE
> 

Try sched_yield(). Accounting may still be messed up so the process
may be 'charged' for CPU time that it gave up. Also, usleep(n) works
very well with accounting working.

This works, does not seem to load the system, but `top` shows
99+ CPU time usage:

main()
{
    for(;;) sched_yield();

}

This works and `top` shows nothing being used:

main()
{

    for(;;) usleep(1);

}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


