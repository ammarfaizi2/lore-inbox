Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317535AbSFKUoU>; Tue, 11 Jun 2002 16:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSFKUoU>; Tue, 11 Jun 2002 16:44:20 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:30700 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317535AbSFKUoS>;
	Tue, 11 Jun 2002 16:44:18 -0400
Date: Tue, 11 Jun 2002 13:44:18 -0700
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andi Kleen <ak@muc.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Multicast netlink for non-root process
Message-ID: <20020611134418.A22893@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I'm developping an application that need to monitor every
network interface of the system. Network interfaces are
virtual/dynamic and go up and down all the time, so to keep track of
my interface list, I'm listening for RTM_NEWLINK events on the
RTnetLink socket (RTMGRP_LINK multicast group).

	Problem : this works only as ROOT.
	And my mother told me that having my application running as
root is bad for my health.

	The cause is here :
----------- net/netlink/af_netlink.c - l322 ------------------

static int netlink_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
{
[...]
	/* Only superuser is allowed to listen multicasts */
	if (nladdr->nl_groups && !capable(CAP_NET_ADMIN))
		return -EPERM;
--------------------------------------------------------------

	Why ?
	Why ?
	Why ?

	Have a good day...

	Jean
