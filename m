Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbTIYWVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 18:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbTIYWVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 18:21:09 -0400
Received: from imr2.ericy.com ([198.24.6.3]:38289 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S261912AbTIYWVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 18:21:05 -0400
Date: Thu, 25 Sep 2003 18:18:29 -0400 (EDT)
From: Suresh Krishnan <suresh.krishnan@ericsson.ca>
X-X-Sender: lmcsukr@localhost.localdomain
Reply-To: suresh.krishnan@ericsson.ca
To: linux-kernel@vger.kernel.org
cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pedro Roque <roque@di.fc.ul.pt>
Subject: Interface forgets IPv6 address
In-Reply-To: <7B2A7784F4B7F0409947481F3F3FEF830C58B45A@eammlex037.lmc.ericsson.se>
Message-ID: <Pine.LNX.4.44.0309251814410.23622-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am trying to bring an interface down temporarily and bring it back up. 
I have one IPv4 address and 1 IPv6 address (global scope) and the IPv6 
link local address. The problem I have is that, after I bring the 
interface back up, the IPv6 global scope address is lost from the interface 
configuration. Is this expected behaviour? 

Here is the sequence of commands to reproduce my problem 
(I have tried it on multiple kernel versions, multiple IPv6 stacks and 
having IPv6 as a module as well as compiled in the kernel ). 

Initial state
=============
[root@spock home]#uname -a
Linux spock 2.4.20-19.9 #1 Tue Jul 15 17:18:13 EDT 2003 i686 i686 i386 
GNU/Linux
[root@spock home]#ip address
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
    inet6 ::1/128 scope host 
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:08:74:cc:ef:ea brd ff:ff:ff:ff:ff:ff
    inet 142.133.72.18/26 brd 142.133.72.63 scope global eth0
    inet6 2001::1/64 scope global 
    inet6 fe80::208:74ff:fecc:efea/64 scope link 
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop 
    link/sit 0.0.0.0 brd 0.0.0.0

Interface down state
====================
[root@spock home]#ifconfig eth0 down
[root@spock home]#ip address
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
    inet6 ::1/128 scope host 
2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:08:74:cc:ef:ea brd ff:ff:ff:ff:ff:ff
    inet 142.133.72.18/26 brd 142.133.72.63 scope global eth0
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop 
    link/sit 0.0.0.0 brd 0.0.0.0

Interface back up
=================
[root@spock home]#ifconfig eth0 up 
[root@spock home]#ip a
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
    inet6 ::1/128 scope host 
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:08:74:cc:ef:ea brd ff:ff:ff:ff:ff:ff
    inet 142.133.72.18/26 brd 142.133.72.63 scope global eth0
    inet6 fe80::208:74ff:fecc:efea/64 scope link 
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop 
    link/sit 0.0.0.0 brd 0.0.0.0

TIA
Suresh

