Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315848AbSEGOv4>; Tue, 7 May 2002 10:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315849AbSEGOvz>; Tue, 7 May 2002 10:51:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315847AbSEGOvy>; Tue, 7 May 2002 10:51:54 -0400
Date: Tue, 7 May 2002 10:53:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Paul Jakma <paulj@alphyra.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100: wait_for_cmd_done timeout (2.4.19-pre2/8)
In-Reply-To: <Pine.LNX.4.44.0205071454270.16371-100000@dunlop.admin.ie.alphyra.com>
Message-ID: <Pine.LNX.3.95.1020507104428.7036A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Paul Jakma wrote:

> hi,
> 
> i have a problem with a Dell poweredge with onboard Intel eepro NICs.
> 
> The network card basically doesnt work. The system logs are filled 
> with:
[SNIPPED...]



> looking at the code concerned:
> 
> static inline void wait_for_cmd_done(long cmd_ioaddr)
> {
>         int wait = 1000;
>         do  udelay(1) ;
>         while(inb(cmd_ioaddr) && --wait >= 0);
> #ifndef final_version
>         if (wait < 0)
>                 printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
> #endif
> }
> 

This procedure is called from numerous places in the code.
In line 1069 of eepro100.c, comment out the call to wait_for_cmd_done().
See if this fixes it. If it does, look in the header and send a patch
to the current maintainer. FYI, I use this driver with no problems
on 2.4.18 -- but I have commented-out that call because there, in fact,
might be no command to wait for and I got spurious messages.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

