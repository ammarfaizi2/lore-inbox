Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSLGWKP>; Sat, 7 Dec 2002 17:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSLGWKP>; Sat, 7 Dec 2002 17:10:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:50654 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264818AbSLGWKO>;
	Sat, 7 Dec 2002 17:10:14 -0500
Message-ID: <3DF2738A.2447599@digeo.com>
Date: Sat, 07 Dec 2002 14:17:46 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Rickard <mjr318@psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with 3c59x module (3com 3c595 NIC)
References: <20021207164300.2a35f18d.mjr318@psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 22:17:46.0882 (UTC) FILETIME=[78A1B620:01C29E3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Rickard wrote:
> 
> I'm running kernel 2.4.19 on a system with a 3com 3c595 NIC, using the
> 3c59x module.  The system will run as normal for a period of time
> (generally a pretty long period of time, e.g. 30 days or so) before I
> will get an Oops regarding this module.  After the oops however, the
> system will generally run as expected, although in several cases the NIC
> has been unresponsive following this.
> 
> ...
> eth0: Transmit error, Tx status register 90.

That's a transmit underrun - data is not being fed into the NIC
across the PCI bus fast enough.  Possibly something has gone
wrong with the busmastering logic on the mainboard, or the NIC.

The driver will reset the transmitter when this happens, as per the
manual.  There's not much else we can do.

> ...
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0108704>]    Not tainted

This may not be related to the driver at all.  A ksymoops trace
of this info is needed.

The 595 is a very old and slow NIC, and sometimes has problems
interworking on the PCI bus.  You'd be best off getting a new
card, frankly.
