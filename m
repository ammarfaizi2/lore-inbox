Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbRBYHQi>; Sun, 25 Feb 2001 02:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbRBYHQ2>; Sun, 25 Feb 2001 02:16:28 -0500
Received: from mail.myrealbox.com ([192.108.102.201]:19155 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S129902AbRBYHQP>;
	Sun, 25 Feb 2001 02:16:15 -0500
Subject: Re:  Re: 2.2.18: weird eepro100 msgs
From: angelcode <angelcode@myrealbox.com>
To: lists@cyclades.com, ionut@moisil.cs.columbia.edu,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Date: Sun, 25 Feb 2001 07:14:09 GMT
MIME-Version: 1.0
Message-ID: <983085249.280angelcode@myrealbox.com>
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing the same kind of messages with an eepro100 
but they don't happen when the module is loaded.  They 
happen after it has been running for a few days.  I am 
running 2.4.1.  I haven't seen any real problems but these 
messages still scare me.  

Micah

> 
> On Fri, 2 Feb 2001, Ivan Passos wrote:
> > 
> > On Fri, 2 Feb 2001, Ion Badulescu wrote:
> > 
> > > On Fri, 2 Feb 2001 15:01:05 -0800 (PST), Ivan Passos 
<lists@cyclades.com> wrote:
> > > 
> > > > Sometimes when I reboot the system, as soon as the 
eepro100 module is
> > > > loaded, I start to get these msgs on the screen:
> > > > 
> > > > eth0: card reports no resources.
> > > > eth0: card reports no RX buffers.
> > > > eth0: card reports no resources.
> > > > eth0: card reports no RX buffers.
> > > > eth0: card reports no resources.
> > > > eth0: card reports no RX buffers.
> > > > (...)
> > > 
> > > Does the following patch, taken from 2.4.1, help?
> > 
> > I'm currently testing. I'll get back to you soon (have 
to reboot the
> > system a lot to make sure it's really solved ... :)).
> 
> Yes, the patch did solve the problem.
> 
> Alan, could you please include this patch on your 
2.2.19pre series (if
> it's not already included)??
> 
> Ion, thanks again for your help!!
> 
> Later,
> Ivan
> 
> --- linux-2.2.18/drivers/net/eepro100-old.c	Fri Feb  
2 15:30:23 2001
> +++ linux-2.2.18/drivers/net/eepro100.c	Fri Feb  2 
15:33:19 2001
> @@ -751,6 +751,7 @@
>  	   This takes less than 10usec and will easily 
finish before the next
>  	   action. */
>  	outl(PortReset, ioaddr + SCBPort);
> +	inl(ioaddr + SCBPort);
>  	/* Honor PortReset timing. */
>  	udelay(10);
>  
> @@ -839,6 +840,7 @@
>  #endif  /* kernel_bloat */
>  
>  	outl(PortReset, ioaddr + SCBPort);
> +	inl(ioaddr + SCBPort);
>  	/* Honor PortReset timing. */
>  	udelay(10);
>  
> @@ -1062,6 +1064,9 @@
>  	/* Set the segment registers to '0'. */
>  	wait_for_cmd_done(ioaddr + SCBCmd);
>  	outl(0, ioaddr + SCBPointer);
> +	/* impose a delay to avoid a bug */
> +	inl(ioaddr + SCBPointer);
> +	udelay(10);
>  	outb(RxAddrLoad, ioaddr + SCBCmd);
>  	wait_for_cmd_done(ioaddr + SCBCmd);
>  	outb(CUCmdBase, ioaddr + SCBCmd);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-
info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


