Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbUKXQ2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbUKXQ2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUKXQZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:25:50 -0500
Received: from alog0415.analogic.com ([208.224.222.191]:55936 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262659AbUKXQYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:24:16 -0500
Date: Wed, 24 Nov 2004 11:23:44 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Ole Laursen <olau@cs.aau.dk>
cc: linux-kernel@vger.kernel.org, d507a@cs.aau.dk
Subject: Re: Isolating two network processes on same machine
In-Reply-To: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>
Message-ID: <Pine.LNX.4.61.0411241113090.19813@chaos.analogic.com>
References: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Ole Laursen wrote:

> Hi,
>
> We need to test a peer-to-peer network application that is supposed to
> be scalable. To that end, we have a FreeBSD box with dummynet and a
> small cluster of Linux test machines. The box act as the gateway for
> the test machines and delay incoming packets for a while before
> throwing them back to the cluster to simulate latency on the Internet.
>
> By letting the test machines think they run on separate subnets, we
> have been able to fool them into forwarding their packets to the
> FreeBSD gateway even though everyone is connected to the same switch.
> This is working fine.
>
> The problem is that we need to run several instances of our network
> application on the same test machine since we have too few machines.
> But when we create two IP addresses on the same machine with
>
>  ifconfig eth0:0 10.0.0.2 netmask 255.255.255.0 broadcast 10.0.0.255
>  ifconfig eth0:1 10.0.1.2 netmask 255.255.255.0 broadcast 10.0.1.255
>
> and start two instances on the same machine with the two IP addresses,
> then they communicate directly with each other instead of going
> through the FreeBSD gateway. Can anyone see a way to solve this
> problem?
>


I was going to say, set the netmask small enough so that both
machines are on different networks and set default routes to
your gateway.... But there is a bug somewhere that doesn't
allow a netmask of anything but 0 in the last byte.

So, just add a host route....

route add -host 10.0.1.2 gw server


>
> (I've CC'ed the other guys in my group.)
>
> -- 
> Ole Laursen
> http://www.cs.aau.dk/~olau/
> -

FYI, probably nobody will admit to it being a bug, but it's
another example of policy spreading throughout the kernel.
If I set the netmask to 0.0.0.0 or 255.255.255.255, and
anything in-between, it should let me....

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
