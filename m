Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318792AbSIISr3>; Mon, 9 Sep 2002 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318833AbSIISr3>; Mon, 9 Sep 2002 14:47:29 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:23496 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S318792AbSIISr1>; Mon, 9 Sep 2002 14:47:27 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Daniel Phillips'" <phillips@arcor.de>,
       "'Andrew Morton'" <akpm@digeo.com>
Cc: <root@chaos.analogic.com>, "'David S. Miller'" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 11:49:02 -0700
Message-ID: <01a801c25831$913c5fd0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E17oTBg-0006qd-00@starship>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Daniel Phillips
Sent: Monday, September 09, 2002 11:23 AM
To: Andrew Morton; imran.badr@cavium.com
Cc: root@chaos.analogic.com; 'David S. Miller';
linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..


On Monday 09 September 2002 20:08, Andrew Morton wrote:
> Imran Badr wrote:
> >
> > The virt_to_bus() macro would work only for kernel logical addresses. I
am
> > trying to find a portable way to figure out the kernel logical address
of a
> > user buffer so that I could use virt_to_bus() for DMA. The user address
is
> > mmap'ed from kmalloc'ed buffer in the mmap() entry of my driver. Now
when
> > the user wants to send this data to the PCI device, it makes an ioctl
call
> > and give the user address to the driver. Now driver has to figure out
the
> > kernel logical address for DMA.
>
> You can obtain this info by walking the user's pagetables with
> get_user_pages().  That give `struct page' pointers, with which
> all things are possible.

>As long as you can be sure they won't spontaneously vanish on you.

>--
>Daniel
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



down(&current->mm->mmap_sem) would help.

Imran.




