Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSEIETC>; Thu, 9 May 2002 00:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315608AbSEIETB>; Thu, 9 May 2002 00:19:01 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41998
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315607AbSEIETA>; Thu, 9 May 2002 00:19:00 -0400
Date: Wed, 8 May 2002 21:16:30 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Lincoln Dale <ltd@cisco.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <5.1.0.14.2.20020509122919.01645ff0@mira-sjcm-3.cisco.com>
Message-ID: <Pine.LNX.4.10.10205082055530.924-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lincoln,

You are right on the money!
There is about 35-40% throughput killjoy "copy-from-kernel-to-userspace".
It is easy to demo if you have a bus analizer and can do accounting on the
data io less the command block overhead.

CR3's are your friend, not ...

On Thu, 9 May 2002, Lincoln Dale wrote:

> At 01:42 PM 8/05/2002 +0100, Alan Cox wrote:
> >The SCSI layer is significant overhead even in 2.5.
> 
> i did some benchmarking on a high-end dual P3 Xeon (Serverworks chipset ) 
> with QLogic 2300 (2gbit/s) 64/66 Fibre Channel controllers.
> 
> using the '/dev/sgX' interface to issue scsi reads/writes allowed me to hit 
> the magical limit of 200mbyte/sec throughput.  (basically just about 
> linerate).  (simultaneous "sg_read if=/dev/sgX mmap=1 bs=512 count=35M"; 
> sg_read from the sg-tools package)
> 
> doing the same test thru the block-layer was basically capped at around 
> 135mbyte/sec.  (simultaneous "dd if=/dev/sdX of=/dev/null bs=512 count=35M").
> 
> whether the bottleneck was copy-from-kernel-to-userspace (ie. exhaustion of 
> Front-Side-Bus / memory bandwidth) or related to block-layer overhead and 
> scsi layer overheads, i haven't yet validated, but at a ~35% performance 
> difference is relatively significant nontheless.
> 
> cpu utlization on the sg interface was under 10%.  using 'dd' on the sd 
> interface, both gigahertz P3 Xeons had 0% idle time.
> 
> 
> cheers,
> 
> lincoln.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

