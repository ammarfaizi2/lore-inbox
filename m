Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTLQAJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 19:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTLQAJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 19:09:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:37507 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263101AbTLQAJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 19:09:15 -0500
Date: Tue, 16 Dec 2003 19:12:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
cc: arjanv@redhat.com, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FDF898D.2060902@intel.com>
Message-ID: <Pine.LNX.4.53.0312161906340.23063@chaos>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> 
 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com>
 <1071494155.5223.3.camel@laptop.fenrus.com>  <3FDDBDFE.5020707@intel.com> 
 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org>  <3FDEDC77.9010203@intel.com>
  <3FDF3C6C.9030609@pobox.com> <1071596889.5223.7.camel@laptop.fenrus.com>
 <3FDF898D.2060902@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, Vladimir Kondratiev wrote:

> Arjan van de Ven wrote:
>
> >>>+	/* dummy read to flush PCI write */
> >>>+	readb(addr);
> >>>
> >>>
> >>This is going to choke some hardware, I guarantee.
> >>
> >>You always want to make sure your flush is of the same size at the
> >>write.  Reading a byte from an address that the hardware defines as
> >>"32-bit writes only" can get ugly real quick ;-)
> >>
> >>
> >
> >also reading back addr might not be the best choice in case some
> >registers have side effects on reading, it's probably better to read
> >back an address that is known to be ok to read (like the vendor ID
> >field)
> >
> >
> >
> Good idea!


You should not abitrarily flush all the writes with a read
after each write. The PCI/Bus is a FIFO, stuff will get to
the hardware in the order written. If you "flush" every write,
you will seriously hurt the performance. I don't like that
MACRO/Function, whatever it is with the switch shown previously.
All that code just for a "@(*^&$(*^(" write will screw up
performance. I've looked at the result of some the the MACRO
expansions, in particular the get_user, put_user, and copy_to/from
macros where there is a switch. It is not pre-processed out.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


