Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTAJOyT>; Fri, 10 Jan 2003 09:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbTAJOyS>; Fri, 10 Jan 2003 09:54:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42881 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265051AbTAJOyS>; Fri, 10 Jan 2003 09:54:18 -0500
Date: Fri, 10 Jan 2003 10:04:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mihnea Balta <dark_lkml@mymail.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hooks just to get rid of copy_[to/from]_user() and syscall overhead?
In-Reply-To: <200301101645.39535.dark_lkml@mymail.ro>
Message-ID: <Pine.LNX.3.95.1030110100100.17174A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Mihnea Balta wrote:

> Hi,
> 
> I have to implement a system which grabs udp packets off a gigabit connection, 
> take some basic action based on what they contain, repack their data with a 
> custom protocol header and send them through a gigabit ethernet interface on 
> broadcast.
> 
> I know how to do this in userspace, but I need to know if doing everyting in 
> the kernel would show a considerable speed improvement due to removing 
> syscall and memory copy overhead. The system will be quite stressed, having 
> to deal with around 15-20000 packets/second.
> 
> I didn't want to start this e-mail with an excuse, so I delayed it until here 
> :). I appologise if this isn't the right place to ask, it seemed that way to 
> me. I wasn't able to find sufficient and coherent information about this 
> issue on the internet or on this mailing list's archives, so I decided to ask 
> you people directly.
> 
> Thanks for your time,
> Mihnea Balta
> 

I think you should do everything in kernel space, with a user-mode
interface for non-realtime control, i.e., what characteristics
of UDP packets are being "filtered". You just make a module that
contains what you need, with an ioctl() hook to control it.

That way, data from your gigabit interface(s) never has to get to
"user-space" at all.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


