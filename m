Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131698AbRAVLYS>; Mon, 22 Jan 2001 06:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132106AbRAVLYI>; Mon, 22 Jan 2001 06:24:08 -0500
Received: from [203.36.158.121] ([203.36.158.121]:48015 "EHLO kabuki.eyep.net")
	by vger.kernel.org with ESMTP id <S131698AbRAVLXx>;
	Mon, 22 Jan 2001 06:23:53 -0500
Subject: Re: Firewall netlink question...
From: Daniel Stone <daniel@kabuki.eyep.net>
To: scaramanga@barrysworld.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010122102600.A4458@lemsip.lan>
In-Reply-To: <20010122073343.A3839@lemsip.lan>  
	<Pine.LNX.4.21.0101221045380.25503-100000@titan.lahn.de>  
	<20010122102600.A4458@lemsip.lan>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 22 Jan 2001 22:28:41 +1100
Mime-Version: 1.0
Message-Id: <E14Kf9W-0008PJ-00@kabuki.eyep.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2001 10:26:00 +0000, Scaramanga wrote:
> Looking at the code it seemed to do the same thing as the old netlink, but
> with more complexity, to what end though, i couldnt tell, was only a brief
> skim.

So you can do whatever you want with it.

> > $ sed -n -e '1874,1876p' /usr/src/linux-2.4.0/Documentation/Configure.help
> > CONFIG_IP_NF_QUEUE
> >   Netfilter has the ability to queue packets to user space: the
> >   netlink device can be used to access them using this driver.
> > 
> > $ lynx /usr/share/doc/iptables/html/packet-filtering-HOWTO-7.html
> > 
> 
> Yeah, after some quick googling and freshmeating, i came accross a daemon
> that picked up these QUEUEd packets and multiplexed them to various child
> processes, which seemed very innefcient, the documentation said something
> about QUEUE not being multicast in nature, like the old firewall netlink.

This is true. This is called ipqmpd or something similar and written by
Harald Welte, yes?
Your best option is to either check out libipq (can be found in the
directory of the same name in the iptables sources), which provides
clean C interfaces, or the PERL interface, available from
http://www.intercode.com.au/jamesm/

> What was wrong with the firewall netlink? My re-implementation works great
> here. I can't see why anything else would be needed, QUEUE seems twice as
> complex. Unless with QUEUE the userspce applications can make decisions on
> what to do with the packet? In which case, it would be far too inefficient
> for an application like mine, where all i need is to be able to read the
> IP datagrams..

It can modify and then reinject the packet if it so wishes.

> Am I missing something totally obvious?

It just does more stuff. A plane is far more complex than a car, but
with an added feature - it also flies above the ground.

> Regards

-- 
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
