Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280851AbRKBVbx>; Fri, 2 Nov 2001 16:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280844AbRKBVbo>; Fri, 2 Nov 2001 16:31:44 -0500
Received: from zeke.inet.com ([199.171.211.198]:59900 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S280849AbRKBVb1>;
	Fri, 2 Nov 2001 16:31:27 -0500
Message-ID: <3BE310A2.B8D52A07@inet.com>
Date: Fri, 02 Nov 2001 15:31:14 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: pcnet32 - promiscuous mode bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To those interested in pcnet32,

In pcnet32_set_multicast_list(), the driver sets the promiscuous bit in
the init_block mode field.  This is copied to CSR15 during
initialization.

However, that bit is only read/write accessible when the device is in
the suspend or stopped state, so setting the promiscuous bit will have
no effect on an already UP interface.

Thus, to get the interface to actually be in promiscuous mode, one must:
ifconfig -i eth0 promisc
ifdown eth0 ; ifup eth0
tcpdump will now see promiscuous packets
and to turn it off,,
ifconfig -i eth0 -promisc
ifdown eth0 ; ifup eth0

It also appears that tcpdump 3.6.2 isn't triggering that code at all...
What does the driver need to support for tcpdump?

Anyone have a fix for this?

Eli 
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
