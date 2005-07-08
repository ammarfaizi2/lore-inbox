Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVGHLPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVGHLPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVGHLPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:15:32 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8936 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262589AbVGHLOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:14:06 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-os@analogic.com, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo?
Date: Fri, 8 Jul 2005 14:13:04 +0300
User-Agent: KMail/1.5.4
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42CBCEDD.2020401@tls.msk.ru> <42CD1860.1030804@tls.msk.ru> <Pine.LNX.4.61.0507070801080.9558@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0507070801080.9558@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081413.04418.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 July 2005 15:34, Richard B. Johnson wrote:
> >> Only the 127.0.0.0 network should be routed through the loop-back
> >> device.
> >
> > Again: All the IP addresses mentioned are local to this box.
> >
> > If you ping an IP address on your eth0, the traffic will "go"
> > over loopback.  You can verify it using tcpdump:
> >
> 
> If you ping an IP address on your computer, the traffic will go
> through lo. However, I think that the IP address shown is
> the result of an instrumentation error because it is impossible
> to put, for instance your 192.168.1.1, through a 127.0.0.0 network,
> the ONLY route through lo. This shows that 'local' traffic bypasses
> the lo route filtering altogether. You can verify this by
> deleting the lo route altogether, you can still ping the local
> addresses.
> 
> Somebody else mentioned that lo was 'perfectly happy' to
> carry whatever. The fact that something bogus appears on
> lo can be a sign of a misconfiguration error, just as
> the reserved 127.0.0.0 network must never appear on ethernet.

Care to tcpdump your own lo?

> In the case of 0.0.0.0 (a possible broadcast), there is
> no "local" address that could cause a bypass via lo. Instead,
> any such traffic should have been on the ethernet wire. This
> shows the possible configuration error that I mentioned.
> 
> 
> > 1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
> >    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>                      ^^^^^^^^^^^^^^^^
> >    inet 127.0.0.1/8 scope host lo
> 
> This looks as though there is no netmask set. My configuration
> shows:

BS. 00:00:00:00:00:00's above aren't netmasks.

> lo        Link encap:Local Loopback
>            inet addr:127.0.0.1  Mask:255.0.0.0
>            inet6 addr: ::1/128 Scope:Host
>            UP LOOPBACK RUNNING  MTU:16436  Metric:1
> 
> This is a possible configuration error.

Yours is ifconfig output, whereas
"link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00"
line above was from ip, not ifconfig.
--
vda

