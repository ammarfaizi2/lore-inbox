Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315853AbSEGPHC>; Tue, 7 May 2002 11:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSEGPHC>; Tue, 7 May 2002 11:07:02 -0400
Received: from firewall.esrf.fr ([193.49.43.1]:49589 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S315853AbSEGPHA>;
	Tue, 7 May 2002 11:07:00 -0400
Date: Tue, 7 May 2002 17:06:22 +0200
From: Samuel Maftoul <maftoul@esrf.fr>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: eepro100: wait_for_cmd_done timeout (2.4.19-pre2/8)
Message-ID: <20020507170621.A3155@pcmaftoul.esrf.fr>
In-Reply-To: <Pine.LNX.4.44.0205071454270.16371-100000@dunlop.admin.ie.alphyra.com> <Pine.LNX.3.95.1020507104428.7036A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 10:53:16AM -0400, Richard B. Johnson wrote:
> On Tue, 7 May 2002, Paul Jakma wrote:
> 
> > hi,
> > 
> > i have a problem with a Dell poweredge with onboard Intel eepro NICs.
> > 
> > The network card basically doesnt work. The system logs are filled 
> > with:
> [SNIPPED...]
> 
> 
> 
> > looking at the code concerned:
> > 
> > static inline void wait_for_cmd_done(long cmd_ioaddr)
> > {
> >         int wait = 1000;
> >         do  udelay(1) ;
> >         while(inb(cmd_ioaddr) && --wait >= 0);
> > #ifndef final_version
> >         if (wait < 0)
> >                 printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
> > #endif
> > }
> > 
> 
> This procedure is called from numerous places in the code.
> In line 1069 of eepro100.c, comment out the call to wait_for_cmd_done().
> See if this fixes it. If it does, look in the header and send a patch
> to the current maintainer. FYI, I use this driver with no problems
> on 2.4.18 -- but I have commented-out that call because there, in fact,
> might be no command to wait for and I got spurious messages.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> 
>                  Windows-2000/Professional isn't.
I have the same message but only when I'm using my ieee-1394 devices (
firewire ) .
I copy from NFS to ieee-1394 HD and approximatively at 256 meg of copied
data from network I have the message (wait_for_cmd_timeout), and I'm not
able use the network, nor the mounted HD.

I need to say the system is running 2.4.18 SMP ( 2 proc ) with 2go of
RAM (higmeme 4-GB from suse ) ( It's a scientific data analysis and extraction system ).

What should I do ? 
Should I remove the code you told me to remove ?
        Sam
