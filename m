Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271845AbRJCJXj>; Wed, 3 Oct 2001 05:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRJCJX3>; Wed, 3 Oct 2001 05:23:29 -0400
Received: from [195.72.14.134] ([195.72.14.134]:59404 "HELO ipv6.isternet.sk")
	by vger.kernel.org with SMTP id <S271845AbRJCJXP>;
	Wed, 3 Oct 2001 05:23:15 -0400
Date: Wed, 3 Oct 2001 11:23:42 +0200
From: Jan Oravec <wsx@wsx6.net>
To: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: IPv6 neighbor solicitation -> no response
Message-ID: <20011003112342.B50545@ipv6.isternet.sk>
Reply-To: Jan Oravec <wsx@wsx6.net>
In-Reply-To: <20010930145627.A32407@ipv6.isternet.sk> <200110011923.XAA14289@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110011923.XAA14289@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Mon, Oct 01, 2001 at 11:23:27PM +0400
X-Operating-System: UNIX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After upgrade from 2.2 to 2.4 kernel machine stopped answering IPv6 neighbor solicitation requests on pointtopoint interfaces.
> 
> What kind of pointopont interface?
sit tunnel (IPv6 over IPv4)
> 
> > 14:50:05.762924 fe80::201:2ff:fe0f:b5a2 > fe80::3e8c:1d09: icmp6: neighbor sol: who has fe80::3e8c:1d09
> 
> Are you sure that machine really has this address: fe80::3e8c:1d09?
Yes, I am sure, because I am receiving packets from fe80::3e8c:1d09 thru this tunnel...


Here is the example (another Linux (2.4.8), so address isn't fe80::3e8c:1d09):
$ /sbin/ifconfig sit1
sit1      Link encap:IPv6-in-IPv4
          inet6 addr: fe80::c348:987/10 Scope:Link
          inet6 addr: 3ffe:80e8:2::2/64 Scope:Global
          inet6 addr: fe80::a00:1/10 Scope:Link
          inet6 addr: fe80::c0a8:6401/10 Scope:Link
          UP POINTOPOINT RUNNING NOARP  MTU:1480  Metric:1
          RX packets:6050 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6097 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1083250 (1.0 Mb)  TX bytes:629382 (614.6 Kb)

(server has multiple network cards, so it has multiple link-local addresses)

When I am trying to send packets there (from another side of tunnel):
11:13:45.520765 fe80::201:2ff:fe0f:b5a2 > fe80::c348:987: icmp6: neighbor sol: who has fe80::c348:987
11:13:46.520777 fe80::201:2ff:fe0f:b5a2 > fe80::c348:987: icmp6: neighbor sol: who has fe80::c348:987
11:13:47.520796 fe80::201:2ff:fe0f:b5a2 > fe80::c348:987: icmp6: neighbor sol: who has fe80::c348:987

packets arrive OK, I get answer from fe80::c348:987, but I don't receive answer from neighbor solicitation.
other OS I tried (FreeBSD, Linux 2.2) are answering correctly:

11:21:41.527954 fe80::201:2ff:fe0f:b5a2 > fe80::201:2ff:fea8:2f55: icmp6: neighbor sol: who has fe80::201:2ff:fea8:2f55
11:21:41.541748 fe80::201:2ff:fea8:2f55 > fe80::201:2ff:fe0f:b5a2: icmp6: neighbor adv: tgt is fe80::201:2ff:fea8:2f55


Regards,

Jan
