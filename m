Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422950AbWJ0Dts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422950AbWJ0Dts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 23:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423745AbWJ0Dts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 23:49:48 -0400
Received: from [84.77.121.105] ([84.77.121.105]:20683 "EHLO
	merak.nimastelecom.com") by vger.kernel.org with ESMTP
	id S1422950AbWJ0Dtr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 23:49:47 -0400
Message-ID: <454181D1.1040904@newipnet.com>
Date: Fri, 27 Oct 2006 05:49:37 +0200
From: Carlos Velasco <lkml@newipnet.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Networking messed up, bad checksum, incorrect length
References: <E1GdIWp-0002qX-00@gondolin.me.apana.org.au>
In-Reply-To: <E1GdIWp-0002qX-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu escribió:

> These packets look like normal TSO packets.  Linux will send a
> packet containing more data than fits in a packet to the NIC.  The
> NIC will then segment the packet for us.
> 
> If that is not possible, you can try disabling TSO with ethtool -K.

I see...
I have tracked the change to 2.6.18.
Using kernel 2.6.17.14 and below makes tcpdump/libpcap to display the
real packets.
Could this be a change in the tg3 driver to support TSO committed in 2.6.18?

And a question... how this TSO affects netfilter?

> In order to see what really goes out, you'll need to run a packet
> dump beyond the NIC.

They are here:

Sniffer traces taken through port mirroring in the switch
(ethereal with filter: host flash.cnio.es):
http://www.nimastelecom.com/smtptraces/smtptrace_portmirror.pcap


But still wondering how could this affect Netfilter... my real problem
is that Netfilter drops ACK packets because it doesn't see the
connection established/related.

I will try to do some more research.

Regards,
Carlos Velasco
CCNP & CCDP Cisco Certified Network Professional


