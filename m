Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRHaTS3>; Fri, 31 Aug 2001 15:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRHaTST>; Fri, 31 Aug 2001 15:18:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268970AbRHaTSG> convert rfc822-to-8bit; Fri, 31 Aug 2001 15:18:06 -0400
Date: Fri, 31 Aug 2001 15:18:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?Q?=22Hammond=2C_Jean-Fran=E7ois=22?= 
	<Jean-Francois.Hammond@mindready.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Scheduling in interrup
In-Reply-To: <F50B5436A4CED31190DA000629386F010168A9C7@CHOPIN>
Message-ID: <Pine.LNX.3.95.1010831151138.4225A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001, [iso-8859-1] "Hammond, Jean-François" wrote:

> Hi,
> 
> Here is the bug :
> 
> Scheduling in interrupt
> kernel BUG at sched.c:706!
> < all the registers are dump >
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> General information :
> 
> Kernel version : 2.4.8 without SMP
> GCC version : 2.96-81 (Red Hat 7.1)
> 
> I am developing in the kernel. I got two PC with one network card for each.
> The bug appear when trying to stress my network driver by sending a lot
> of packet to one node on the network. The PC that is sending packets
> seems to work fine, but the one that receiving packets get the bug after 
> a while. My interrupt handler does not have bottom half and my interrupt
> as the options : SA_INTERRUPT and SA_SHIRQ.
> 
> I got two possible answer. The first possible answer to this is my interrupt
> routine stays too long at the interrupt level. The second answer is I lock
> the
> interrupt for a long time.
> 
> Do you have any suggestion to this problem ?
> 
> Thanks,
> 

So, what is the interrupt service routine doing that it should not
be doing?

o	Are you attempting to access paged RAM?
o	Are you accessing anything that sleeps?
o	Are you enabling interrupts without protecting against
	re-entry first?
o	Etc.

Your ISR must be doing something that it should not be doing in
order to get this kind of error.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


