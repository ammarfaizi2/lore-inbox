Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135378AbRAWAux>; Mon, 22 Jan 2001 19:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135566AbRAWAun>; Mon, 22 Jan 2001 19:50:43 -0500
Received: from quechua.inka.de ([212.227.14.2]:11038 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S135378AbRAWAua>;
	Mon, 22 Jan 2001 19:50:30 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Turning off ARP in linux-2.4.0
Message-Id: <E14KrfH-0001Mw-00@sites.inka.de>
Date: Tue, 23 Jan 2001 01:50:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101222059.MAA04984@tech1.nameservers.com> you wrote:
> Now for the long version of the problem.  I am using the TurboLinux 
> ClusterServer 6.0 product.  This product uses what they refer to as
> an advanced traffic manager that has the ip address of the web site
> aliased to eth0.  Thus this machine arps for the ip address and when it
> gets the http requests, it passes those requests to the nodes which have
> the same ip addressed aliased to their lo interface with arping turned off.

Well, the easises way of course is to have the internal cluster network on
another network card than the external load balancer. This will remove the arp
queries on their interface. But of course the back channel will be a bit more
delayed.

Another option is to ifconfig -arp the eth0 interface. I browsed through the
IPv4 code and did not find any other goto out which can be configured besides
the input FIB, which messing with is a bad thing since it wont accept the
packet at all.

so ifconfig -arp is the only option i could find which will help you. You need
to hardcode the arp entries for the real ip's of those web servers to reach
them.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
