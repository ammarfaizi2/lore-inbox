Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265478AbUFWMhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUFWMhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbUFWMhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:37:04 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:34831 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265478AbUFWMgq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:36:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: Re: 2.6.7-rc2-mm2 udp multicast problem (sendto hangs)
Date: Wed, 23 Jun 2004 15:36:10 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <20040622164000.110f2a63@phoebee> <200406231334.57816.vda@port.imtp.ilyichevsk.odessa.ua> <20040623140023.4cd7aa3e@phoebee>
In-Reply-To: <20040623140023.4cd7aa3e@phoebee>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406231536.10112.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 June 2004 15:00, Martin Zwickel wrote:
> On Wed, 23 Jun 2004 13:34:57 +0300
>
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> bubbled:
> > On Wednesday 23 June 2004 12:56, Martin Zwickel wrote:
> > > if I use MSG_DONTWAIT with sendto, I get temporarily unavailable
> > > resources (many!):
> > >
> > > sendto(sendfd): Resource temporarily unavailable
> > >
> > > but isn't udp supposed to not block?
> >
> > Think about what will happen if you will try to spew
> > udp packets continuously:
> >
> > while(1)
> > 	sendto(...);
> >
> > They will pile up in queue and eventually it will fill up.
> > Then kernel may either drop excess packets silently
> > or return you EAGAIN.
>
> Yes, but why does the kernel not send out the queue?(I don't know if the
> queue is empty or full when my sendto stops)
> Without MSG_DONTWAIT, sendto waits endlessly. But on what?

strace, gdb and/or (SysRq-T with ksymoops) will tell you.

> Normally the kernel should put the queued packets on the line and accept
> new ones, or did I misunderstand this?

Hm, yes. What does tcpdump tell you?

> My program sends out many udp packets, and sometimes it just stops until
> the kernel receives a network packet or I access the local network(with arp
> command).

arp does not access network. I think it just prints current arp cache.

> So if I run arp in an endless loop(while :; do arp; done), sendto runs
> smooth.
>
> For me it smells like a bug ;)

Possible. We need more details. Also CC network folks :)
--
vda
