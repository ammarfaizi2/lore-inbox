Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSLCVwM>; Tue, 3 Dec 2002 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266319AbSLCVwM>; Tue, 3 Dec 2002 16:52:12 -0500
Received: from dux1.tcd.ie ([134.226.1.23]:9766 "HELO dux1.tcd.ie")
	by vger.kernel.org with SMTP id <S266318AbSLCVwJ> convert rfc822-to-8bit;
	Tue, 3 Dec 2002 16:52:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Salman <assembly@gofree.indigo.ie>
To: "Henrique Gobbi" <henrique.gobbi@cyclades.com>
Subject: Re: device driver modules
Date: Tue, 3 Dec 2002 21:58:23 +0000
User-Agent: KMail/1.4.3
References: <3DECBCA7.2010502@earthlink.net> <200212031534.02102.assembly@gofree.indigo.ie> <01cd01c29afc$1dab5900$61a1ba40@Henrique>
In-Reply-To: <01cd01c29afc$1dab5900$61a1ba40@Henrique>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
Message-Id: <200212032158.23802.assembly@gofree.indigo.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henrique,

thanks alot. your explanation answered some important questions of mine.

I need to get deep into this though, and yet understand how to interpret the 
(unsigned32 variable) "cmd" into a function name in my drivers and etc.

120	int stat = ioctl(dev, cmd, arg);
(gdb) p cmd
$1 = 1615069522
(gdb) p dev
$2 = 5
(gdb) p arg
$3 = (void *) 0x8050d30

can you advise me on what to read ? or where to go from here ?
do you know of any resources on the internet regarding kernel, system calls, 
etc ? or which group/mailing list would be the optimum choice for me ?

thanks,

Salman


On Tuesday 03 December 2002 18:45, you wrote:
> Hi !!!
>
> User space application talk to the lower level software (kernel space)
> using ioctl commands. You can take a look at you application code and
> you're probably going to see a lot of ioctl called. To understand the ioctl
> you've got to look at the driver and the application simultaneously.
> There's a routine in the driver that treats all ioctl's the application is
> issuing, for example:
> if your application call something like:
>     ioctl (fd, COMMAND, ...)
>
> you must look for the word COMMAND in your driver and then you can discover
> what your driver is doing when your application call this ioctl comman.
>
> I hope it helps
> regards
> henrique
>
> ----- Original Message -----
> From: "Salman" <assembly@gofree.indigo.ie>
> To: <linux-kernel@vger.kernel.org>
> Sent: Tuesday, December 03, 2002 7:34 AM
> Subject: device driver modules
>
> > Hi !
> >
> > I'm working with a device driver which comes in 2 modules.
> >
> > One directly talking to the hardware and kernel, and the other sitting on
>
> top
>
> > of it, in user mode providing a nice interface for user applications and
>
> etc.
>
> > Basically the top layer should directly communicate with bottom layer for
>
> any
>
> > action.
> > I'm going through code of top layer, and it never calls the lower layer
> > functions ! a sample code traverses as follows (i used source navigator
> > to
>
> go
>
> > through code)
> >
> > ConnectRemoteSegment -> kcConnectR -> SISCI_IOCTL -> unixIoctl -> ioctl
> >
> > all above fucntions are within the top layer code.
> > none are even listed in /proc/ksyms
> > and the ioctl function simply doesn't exist, not even in kernel source
>
> code.
>
> > I know i'm missing a major concept here, can someone guide me how to
> > understand what's going on.
> >
> > Thanks,
> >
> > Salman
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

