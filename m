Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132732AbREBLWZ>; Wed, 2 May 2001 07:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132737AbREBLWP>; Wed, 2 May 2001 07:22:15 -0400
Received: from [195.6.125.97] ([195.6.125.97]:25357 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S132732AbREBLWA>;
	Wed, 2 May 2001 07:22:00 -0400
Date: Wed, 2 May 2001 13:19:20 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: Ofer Fryman <ofer@shunra.co.il>
Cc: liste noyau linux <linux-kernel@vger.kernel.org>,
        liste dev network device <netdev@oss.sgi.com>
Subject: Re: ioctl call for network device
Message-Id: <20010502131920.478e50be.sebastien.person@sycomore.fr>
In-Reply-To: <F1629832DE36D411858F00C04F24847A11DFE2@SALVADOR>
In-Reply-To: <F1629832DE36D411858F00C04F24847A11DFE2@SALVADOR>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, 2 May 2001 13:55:34 +0200 
Ofer Fryman <ofer@shunra.co.il> à écrit :

> The definition of ioctl is "extern int __ioctl __P ((int __fd, unsigned long
> int __request, ...));" on Linux 2.0.x, and I believe it is also on any other
> Linux version.

yes but I use an network device specific ioctl call wich perform interface-specific
ioctl commands.
the prototype of the ioctl reception in the module is (as described in rubini book,
O reilly, linux device drivers):

int (*do_ioctl) (struct device *dev, struct ifreq *ifr, int cmd);

so can I pass over the limitations of the definition ?
I do ioctl that use private ioctl flags (e.g. SIOCDEVPRIVATE)

> So If you can pass what ever pointer or number you want instead of struct
> ifreq, If you use Linux under 2.2.x you will need to use copy_fromfs to get
> the buffer info, otherwise you can access it directly from the kernel mode
> with the restriction of interrupt handlers and bottom-halfs. 
> 
> -----Original Message-----
> From: sebastien.person@sycomore.fr [mailto:sebastien.person@sycomore.fr]
> Sent: Wednesday, May 02, 2001 10:08 AM
> To: liste noyau linux
> Subject: ioctl call for network device
> 
> 
> Hi,
> 
> I've succeed to do an ioctl call and recept it in my module
> 
> ioctl(file_descriptor, cmd, struct ifreq)
> 
> but I believe that I'm oblige to use the struct ifreq and I can't
> pass any other arguments because an user can't acces kernel space
> so the ioctl call recopy data in the kernel space (this is what I've
> understood, maybe I'm wrong ...).
> 
> My problem is that I need to pass some int arguments (the best way was an
> int* ) but the struct ifreq doesn't permit me it, so could I add other
> arguments as we can do in an normal ioctl call ?
> 
> I hope this is the wrong place for this question.
> 
> sebastien person
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
