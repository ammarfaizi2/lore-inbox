Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288655AbSADPTa>; Fri, 4 Jan 2002 10:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288666AbSADPTV>; Fri, 4 Jan 2002 10:19:21 -0500
Received: from sgie000400.kiv-webservice.de ([195.226.81.253]:58377 "EHLO
	irc.kiv-host.de") by vger.kernel.org with ESMTP id <S288655AbSADPTL> convert rfc822-to-8bit;
	Fri, 4 Jan 2002 10:19:11 -0500
Message-ID: <4353BABFDF95D311BFC30004AC4CB22AAE343C@sdar000001.kiv-da.de>
From: "Stolle, Martin (KIV)" <MStolle@kiv.de>
To: "'Andre Margis'" <andre@sam.com.br>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: AW: AW: Informix 7.3 and Linux Kernel 2.4
Date: Fri, 4 Jan 2002 08:20:08 +0100 
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andre,

thanks for your help,

I used Kernel 2.4.17rc2-aa2 instead of 2.4.15pre9aa1 (i didn't know, whether
there
is the filesystem corruption bug in it).
I didn't use bouncing buffers and configured to allow I/O on high memory.

The backup is now about three times slower as before, the online work is
faster,
but the whole system works and it is not necessary any longer to reboot the
system.

It seems, that the mainline has a problem with a big count of buffers (~1M)

I'm sorry, that i didn't write again at once, but I had to test it first.

Thanks for all,

Martin


-----Ursprüngliche Nachricht-----
Von: Andre Margis [mailto:andre@sam.com.br]
Gesendet: Donnerstag, 27. Dezember 2001 13:18
An: Stolle, Martin (KIV)
Betreff: Re: AW: Informix 7.3 and Linux Kernel 2.4


Let's go

1) download 2.4.14 from kernel.org:  
http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.14.tar.bz2

2) apply 2.4.15-pre9 patch attached in this e-mail:

3) download 2.4.15-pre9aa1 from lernel.org:
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre9
aa1.bz2

Are you using LVM?

If this is true, is very high recommended, that you download the lastest 
version of LVM from sistina.com, and apply for the new kernel.

And I attached my .config, he is using the HIGHMEM64, but if you have less 
than 4GB of RAM, change this option in the kernel, you save 6% of CPU.

If you need any more, just ask


Regards,


Andre

Em Qui 27 Dez 2001 10:00, you wrote:
> Hello Andre,
>
> 1st,
> thanks for your help.
> where can I get Kernel 2.4.15pre9aa1?
>
> 2nd,
> I'll try to find the kernel and test it tonight, because the system
> is productive.
>
> Thanks a lot,
>
> Martin
>
> -----Ursprüngliche Nachricht-----
> Von: Andre Margis [mailto:andre@sam.com.br]
> Gesendet: Donnerstag, 27. Dezember 2001 12:46
> An: Stolle, Martin (KIV)
> Betreff: Re: Informix 7.3 and Linux Kernel 2.4
>
>
> Hi Martin,
>
>
> I had the same problem with kernel < 2.4.10. My configuration is a 8xPIII,
> 10GB Ram, running Sybase 11.9.2 and 3 TB Disk. I'm now using kernel
> 2.4.15pre9aa1, and the kswapd stays very calm, doesn't eat my machine.
>
> The shared memory is 2GB RAM, and I have 500 users connected to this
> machine.
>
> For historic, using kernel < 2.4.10, the kswapd eats all the machine, the
> database wait for the system to free resources, when I upgrade to
> 2.4.10-pre5, this things disapeared, but  once a week, the kswapd hangs
the
> kernel, and I need to make a forced reboot. When I upgrade to
> 2.4.15-pre9aa1,
> the kswapd stays calm and the kernel stays stable, no more reboots are
> necessary.
>
> I'm running this kernel since November, 22.
>
>
> I don't know if this can help you.
>
>
> Regards,
>
>
> Andre
>
> Em Qui 27 Dez 2001 04:06, Stolle, Martin (KIV) escreveu:
> > Hello,
> >
> > I have the following configuration
> >
> > SuSE Linux 7.3
> > Linux Kernel 2.4.x
> > 4GB-Configuration
> > 3 1/8GB RAM
> > 216 GB HD (6*36)
> > Glibc 2.2.4
> > Informix 7.30 for Linux 2.2.x / glibc 2.1.3 (of course, for this
> > Kernel series and Library release)
> > 400MB Shared Memory (non-resident)
> >
> >
> > IBM says, it works only with 2.2/glibc 2.1.3,
> > but we are forced by certain circumstances to use it under 2.4/glibc
>
> 2.2.x.
>
> > (the software we run doesn't work with higher versions of informix;
> > the number of users are too high to use it with lower memory)
> >
> >
> > At first, Informix works quite well, but after a while, especially
> > after some traffic on the computer (reading the harddisk by "find",
> > do a "update statistics" under informix or some exports, the system
> > starts thrashing.
> >
> > I found out, that it starts thrashing with kswapd using 50% of processor
> > power and oninit using another 50%, when low memory runs short.
> > From then, the system is very very slow.
> > The problem isn't so dramatic with kernel releases <=2.4.9, but with
>
> higher
>
> > releases, including 2.4.17, it is not tolerable.
> > 2.4.17 does not swap to disk, but is still very slow, but kswapd is
> > always active (without swapping to disk!).
> >
> > If i make the shared memory resident, the problem is worser than
without.
> >
> > There is always enough high memory free, before the problem occurs.
> >
> >
> >
> > I could work around the problem by rebooting the computer automatically
> > in the morning (so that the problem doesn't occur in normal operation).
> >
> > I don't know it, perhaps it is a silly question, but is it possible
> > to swap low memory different than high memory?
> >
> > Or how can I resolve the problem?
> >
> > Does anyone has an idea?
> >
> > Greetings,
> >
> > Martin Stolle
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
