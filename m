Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSHBXux>; Fri, 2 Aug 2002 19:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSHBXux>; Fri, 2 Aug 2002 19:50:53 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:47841 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316582AbSHBXuw>; Fri, 2 Aug 2002 19:50:52 -0400
Message-Id: <5.1.0.14.2.20020802164143.04da52f8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 02 Aug 2002 16:54:02 -0700
To: jajcus@bnet.pl
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: "new style" netdevice allocation patch for TUN driver
  (2.4.18 kernel)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020801133506.GA22073@serwus.bnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

>I had a lot of problem with tun devices created with both openvpn and
>vtund. When I wanted to shut down my system when the devices were in
>use (eg. TCP connection established on tun0 interface), even if the
>tunneling daemon was killed, it stopped while trying to deconfigure
>network. And "unregister_netdevice: waiting for tun0 to become free"
>message was displayed again and again. I tried to resolve this problem
>using Google, but I have only found out, that this is behaviour of 2.4
>kernels, and that it is proper. After further investigation, in kernel
>sources, I found out, that there are "old style" and "new style" network
>devices, and that only the "old style" devices have this problem.
>I had similar problem with VLAN devices some time ago, so I checked VLAN
>driver sources too. As I suspected, it was "new style" device now.
>The patch below is my try to make tun device "new style" too. It seems
>to work for me, but I am not sure if it is 100% proper. This is patch
>against 2.4.18 sources.
You're fixing the wrong problem. It seems that some subsystem is not releasing
tun device during shutdown/deregistration. (See comment in 
net/core/dev.c:unregister_netdev).
You're not gonna see "waiting for" warning anymore if you change to new 
style allocation.
But you're gonna leak tun devices because destructor is not called unless 
refcount is zero.

>Sorry, for spamming all those addresses, but I am not sure which one is
>correct. Driver on URL given in MAINTAINERS file seems to be a bit
>outdated.
URL is ok. Mailing list has to be update though.

Max

