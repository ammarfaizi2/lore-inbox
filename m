Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbRBWRvf>; Fri, 23 Feb 2001 12:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131504AbRBWRv0>; Fri, 23 Feb 2001 12:51:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23680 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131447AbRBWRvK>; Fri, 23 Feb 2001 12:51:10 -0500
Date: Fri, 23 Feb 2001 12:50:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sean Hunter <sean@dev.sportingbet.com>
cc: Matt Johnston <mlkm@caifex.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID generation
In-Reply-To: <20010223171440.K10620@dev.sportingbet.com>
Message-ID: <Pine.LNX.3.95.1010223123332.3967A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Sean Hunter wrote:

> I have already written a 2.2 implementation which does not suffer from these
> problems.  It was rejected because Alan Cox (and others) felt it only provided
> security through obscurity.
> 
> Sean

The following is a simple random generator that will never give two
consecutive like numbers (therefore it's not really random). It's
pretty good for things like non-guessible PIDs, TCP/IP ports, etc.
Just mask off the length that you don't need. It this was called 
occasionally from some timer or other interrupt, you don't even know its
starting value. With the current magic number, it's period is 0xfffnnnnn.
Several years ago, I ran an exhaustive search program (133MHz CPU) looking
for a magic number to produce a longer period. I'm told that there
is a magic number that will give a period of 0xffffffff.


static int rnn = 0;

static int rnd()
{
    int ret;
    __asm__ __volatile__(
    "\tmovl (rnn), %%eax\n"
    "\trorl $3,  %%eax\n" 
    "\taddl $0x586c3ec3, %%eax\n"
    "\tmovl %%eax, (rnn)\n"
		: "=eax" (ret) );
    return ret;
}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


