Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTDOMAT (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbTDOMAS 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:00:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261296AbTDOL7C 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 07:59:02 -0400
Date: Tue, 15 Apr 2003 08:10:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to configure an ethernet dev as PtP ?
In-Reply-To: <20030415102109.4802ddd0.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.53.0304150759560.457@chaos>
References: <20030415102109.4802ddd0.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003, Stephan von Krawczynski wrote:

> Hello all,
>
> I tried to configure an ethernet device as a pointopoint link recently, just to
> find out that this does not work as one would expect via:
>
> ifconfig eth0 192.168.1.1 pointopoint 192.168.5.1 up
>
> I tried on kernel 2.4.21-pre6 and 2.2.19 (just to name two), both the same. It
> comes up as:
>
> eth0      Link encap:Ethernet  HWaddr 00:04:76:F7:E9:17
>           inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
>           UP BROADCAST MULTICAST  MTU:1500  Metric:1
>
> I do not understand why this does not work out just like another ptp-interface
> like isdn:
>
> isdn0     Link encap:Ethernet  HWaddr FC:FC:00:00:00:00
>           inet addr:192.168.1.1  P-t-P:192.168.5.1  Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP  MTU:1500  Metric:1
>
> Is there anything I mis-understood or a good reason for not being able to make
> eth pointopoint?
>
> I have the feeling this question is pretty brain-dead, but anyway, maybe some
> kind soul can drop a few words ...
> --
> Regards,
> Stephan

Because ethernet is not a point-to-point interface. At the hardware
level, ethernet talks from one hardware address to another hardware
address, i.e., the IEEE station address. You need ARP to find out
what that address is so you can't "get there from here." But, you
can do essentially the same thing, you set up a host route on
that interface.

Use a 'private' network address...

On one host:

ifconfig eth1 10.0.0.1 netmask 255.255.255.0 broadcast 10.0.0.255
route add -host my-router-ip-address dev eth1

On the other host:
ifconfig eth1 10.0.0.2 netmask 255.255.255.0 broadcast 10.0.0.255
route add -host my-client-ip-address dev eth1



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

