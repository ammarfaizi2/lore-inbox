Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285632AbRLRJpU>; Tue, 18 Dec 2001 04:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285640AbRLRJpK>; Tue, 18 Dec 2001 04:45:10 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:18442 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S285632AbRLRJow>; Tue, 18 Dec 2001 04:44:52 -0500
Message-ID: <3C1F10AA.A2D5367@loewe-komp.de>
Date: Tue, 18 Dec 2001 10:47:22 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Ahmed, Zameer" <Zameer.Ahmed@gs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?
In-Reply-To: <FBC7494738B7D411BD7F00902798761908BFF190@gsny49e.ny.fw.gs.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ahmed, Zameer" schrieb:
> 
> Hi,
>         Is there a way to turn off nagle compression in the kernel for 2.2.x
> and 2.4.x kernels? For the same custom app used under Solaris and Linux.
> Turning off nagle algorithm boosted perf on Solaris, I tried commenting out
> 
> #bool 'IP: Disable NAGLE algorithm (normally enabled)' CONFIG_TCP_NAGLE_OF
> 
> from the net/ipv4/Config.in 2.2.19 kernel and still the degradation in
> network performance for packts in midsize persists
> I tried the 2.4.16 kernel. This gave me very slight improvement, but not
> quite what is expected.
> 

there is a setsockopt() - apply it to the fd returned from accept()

man 7 tcp

SOCKET OPTIONS
       To  set  or get a TCP socket option, call getsockopt(2) to
       read or setsockopt(2) to write the option with the  socket
       family  argument set to SOL_TCP.  In addition, most SOL_IP
       socket options are valid on TCP sockets. For more informa­
       tion see ip(7).

       TCP_NODELAY
              Turn the Nagle algorithm off. This means that pack­
              ets are always sent as  soon  as  possible  and  no
              unnecessary  delays  are introduced, at the cost of
              more packets in the  network.  Expects  an  integer
              boolean flag.
