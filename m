Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130242AbRBSQ2E>; Mon, 19 Feb 2001 11:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130226AbRBSQ1y>; Mon, 19 Feb 2001 11:27:54 -0500
Received: from adsl-64-163-64-74.dsl.snfc21.pacbell.net ([64.163.64.74]:6149
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S129393AbRBSQ1q>; Mon, 19 Feb 2001 11:27:46 -0500
Message-Id: <200102191627.f1JGRE621842@konerding.com>
To: Ansari <mike@khi.sdnpk.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Running Bind 9 on Redhat 7 
In-Reply-To: Your message of "Mon, 19 Feb 2001 20:00:48 +0500."
             <3A913520.3011C7D6@khi.sdnpk.org> 
Date: Mon, 19 Feb 2001 08:27:14 -0800
From: dek_ml@konerding.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ansari writes:
>Hi !!
>
>I am configuring Bind 9 on Redhat 7 but unable to start the named.
>Here is my /var/log message log:
>
>
>Feb 20 09:49:58 ns2 named[2003]: starting BIND 9.0.0
>Feb 20 09:49:58 ns2 named[2005]: loading configuration from
>'/var/named/named.bo
>ot'
>Feb 20 09:49:58 ns2 named[2005]: the default for the 'auth-nxdomain'
>option is n
>ow 'no'
>Feb 20 09:49:58 ns2 modprobe: modprobe: Can't locate module net-pf-10
>Feb 20 09:49:58 ns2 named[2005]: no IPv6 interfaces found
>Feb 20 09:49:58 ns2 named[2005]: listening on IPv4 interface lo,
>127.0.0.1#53
>Feb 20 09:49:58 ns2 named[2005]: socket.c:1183: unexpected error:
>Feb 20 09:49:58 ns2 named[2005]: setsockopt(10, SO_TIMESTAMP) failed
>Feb 20 09:49:58 ns2 named[2005]: listening on IPv4 interface eth0,
>209.58.33.71#
>53
>Feb 20 09:49:58 ns2 named[2005]: socket.c:1183: unexpected error:
>Feb 20 09:49:58 ns2 named[2005]: setsockopt(12, SO_TIMESTAMP) failed
>Feb 20 09:49:58 ns2 named[2005]: socket.c:1183: unexpected error:
>Feb 20 09:49:58 ns2 named[2005]: setsockopt(9, SO_TIMESTAMP) failed
>Feb 20 09:49:58 ns2 named[2005]: dns_master_load: db.127.0.0:1: no TTL
>specified
>Feb 20 09:49:58 ns2 named[2005]: dns_zone_load: zone
>0.0.127.IN-ADDR.ARPA/IN: da
>tabase db.127.0.0: dns_db_load failed: no ttl
>Feb 20 09:49:58 ns2 named[2005]: loading zones: no ttl
>Feb 20 09:49:58 ns2 named[2005]: exiting (due to fatal error)
>Feb 20 09:50:00 ns2 CROND[2010]: (root) CMD (   /sbin/rmmod -as)

There are several things wrong here.

First I should point out RedHat 7.1beta comes with BIND 9 as a package.
Second if you're using BIND 8 named config files and you don't have a top line which
looks like:
$TTL 86400

before your SOA record, then you will see the message about "no ttl".

Thirdly, and this is really the only kernel-related one, it appears that
named is asking for support for TIMESTAMP on the socket and it's failing.
I don't know why that is, as it looks like the TIMESTAMP socket option is supported
in 2.4 (presumably 2.2 as well).  

Dave
