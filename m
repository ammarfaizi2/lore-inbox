Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWBQOgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWBQOgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWBQOgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:36:20 -0500
Received: from natipslore.rzone.de ([81.169.145.179]:51149 "EHLO
	natipslore.rzone.de") by vger.kernel.org with ESMTP
	id S1751438AbWBQOgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:36:19 -0500
From: Stefan Rompf <stefan@loplof.de>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ANNOUNCE: new DHCP client for linux 2.6.x
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Date: Fri, 17 Feb 2006 15:37:07 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602171537.07320.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                                  dhcpclient

   A DHCP client for linux 2.6, using modern kernel features, (c) 2006
   Stefan Rompf.

Motivation

   Using a notebook, I'm often traveling between different networks.
   After replugging, I always needed to issue a ifdown/ifup sequence
   because the DHCP client did not realize the temporary disconnection.
   This is an unneeded limitation because since 2.6, the kernel notifies
   userspace of these disconnection/reconnection events. Actually is was
   me who implemented this feature.

   Beginning with 2.6.17, the linux kernel will allow userspace to
   influence this signalling, so that for example a wpa supplicant can
   tell the dhcpclient that an association has finished and the client
   should try to get an IP address.

   Of course, you need software that support this feature. Unfortunately,
   most existing DHCP clients implemented their statemachine using
   siglongjmp() or one huge function, so there was no easy way extending
   them. So I wrote a new one.

Features

     * RFC2131 compatible DHCP client, tested with ISC dhcpd directly and
       via a Cisco IOS relay agent, Cisco IOS DHCP server and dnsmasq.
     * uses netlink for interface configuration
     * does act on link state messages
     * calls a script on every state change to allow updating resolv.conf
       etc
     * small, compiles with [1]uclibc

Status

   Currently, this is alpha software. It shouldn't be used in production
   environment, but I'm looking forward for people who like to test it in
   different environments and for (reasonable ;-) feature suggestions!

Support

   The webpage is at [2]http://www.flamewarmaster.de/software/dhcpclient/

   There is a mailing list available on
   [3]http://www.flamewarmaster.de/mailman/listinfo/dhcpclient/

References

   1. http://www.uclibc.org/
   2. http://www.flamewarmaster.de/software/dhcpclient/
   3. http://www.flamewarmaster.de/mailman/listinfo/dhcpclient/
