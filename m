Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTLJBvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 20:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTLJBvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 20:51:12 -0500
Received: from watson.far.bakerst.org ([209.167.125.194]:56194 "EHLO
	moran.bakerst.org") by vger.kernel.org with ESMTP id S262695AbTLJBvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 20:51:11 -0500
Subject: Re: 2.4.23 masquerading broken? key.oif = 0;
From: Neal Stephenson <neal@bakerst.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Very Little
Message-Id: <1071021069.16543.14.camel@moran.bakerst.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 20:51:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have this problem with 2.4.23. It is new problem, my setup was
working fine on 2.4.22 and 2.4.22-ac4. I tried the patch of moving
key.oif=0 without success. The problem occurs as soon as the machine
comes up.

	I use the iproute tools with rules and tables and mark packets with
iptables so that port 80 traffic goes out through ppp0 rather than the
default eth1. ppp0 has another iptable rule that masquerades everything.
I see the packet enter through eth0 and it never reaches another
interface, at least as far as I can tell with tcpdump. A brief
description of my network is eth0 is my local network, ppp0 is my
personal high speed, and eth1 is my permanent DSL connection. 


	I can send my .config or routing tablef if wanted. The brief is

CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y

	along with ip netfilter essentially all modules. Some relevant iptable
and ip commands

iptables -t mangle -A PREROUTING --protocol tcp --destination-port 80 -j
MARK --set-mark 0x932
iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE

ip rule add pri 424 iif eth0 fwmark 0x932 table symp

	and this is what shows up in dmesg

MASQUERADE: Route sent us somewhere else.

	Any suggestions appreciated,

		Neal

