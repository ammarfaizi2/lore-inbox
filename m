Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbSKDRiJ>; Mon, 4 Nov 2002 12:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbSKDRiI>; Mon, 4 Nov 2002 12:38:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50819 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262197AbSKDRiI>; Mon, 4 Nov 2002 12:38:08 -0500
Date: Mon, 4 Nov 2002 12:46:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: <simon@baydel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: halt and schedule
In-Reply-To: <3DC640AB.12893.F77CB@localhost>
Message-ID: <Pine.LNX.3.95.1021104124402.12666A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002,  wrote:

> 
> I have been changing 2.4.19 to run on some new hardware, X86 
> based. The system boots and runs off a ramdisk. I am having 
> problems which I see as pauses. The system starts up and loads 
> the kernel. All seems ok until the ramdisk is mouned and INIT is 
> started. From this point on the system appears to stop responding 
> for a few seconds and then start again. Eventually, when logged in 
> command input can be slow with pauses between entering a 
> character and the console displaying the character.
> 
> 
> I have tried to debug this and found that the kernel is in the 
> cpu_idle() routine which is repeatedly calling default_idle() and
> safe_halt(). If you then type a character on the console, using a
> scope, you can see the interrupt being serviced and a character 
> being taken from the RX fifo, quickly. However there is no
> response for some seconds. I have also noticed that if you keep the
> thing busy with a benchmark or something simple like ls -lR there is
> no pause.  
> 
> I noticed that to get out of this loop the kernel is looking for a
> process to schedule. It is as if the process is not being scheduled 
> as soon as it could be.
> 
> One point to consider is that this board has no RTC or CTC just the 
> timer wired to a 10ms interrupt.
> 
> I suspect that this is a hardware problem but I don't really know
> where to start looking. Can anyone help ?
> 
> Many thanks
> 
> Simon.

Temporarily get rid of the hlt instruction. That will allow
the scheduler to spin. On a real CPU, an interrupt (any interrupt)
is supposed to get you out of a halt. Something seems broken
on your box, but you should be able to get it to "work" by
removing the halt.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


