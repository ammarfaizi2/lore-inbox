Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269432AbRGaTUw>; Tue, 31 Jul 2001 15:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269431AbRGaTUe>; Tue, 31 Jul 2001 15:20:34 -0400
Received: from leeor.math.technion.ac.il ([132.68.115.2]:15546 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S269432AbRGaTUM>; Tue, 31 Jul 2001 15:20:12 -0400
Date: Tue, 31 Jul 2001 22:20:10 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Erik De Bonte <erikd@lithtech.com>
Cc: "'Philippe Troin'" <phil@fifi.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Determining IP:port corresponding to an ICMP port unreachable
Message-ID: <20010731222010.A29535@leeor.math.technion.ac.il>
In-Reply-To: <AF020C5FC551DD43A4958A679EA16A1501349560@mailcluster.lith.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <AF020C5FC551DD43A4958A679EA16A1501349560@mailcluster.lith.com>; from erikd@lithtech.com on Tue, Jul 31, 2001 at 12:03:14PM -0700
Hebrew-Date: 12 Av 5761
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001, Erik De Bonte wrote about "RE: Determining IP:port corresponding to an ICMP port unreachable":
> Nadav Har'El said:
> > But for non-connected()ed sockets, you can only find out the host
> > sending the ICMP message.
> 
> Why?  The remote port is in the ICMP message (64-bits of the undeliverable
> message's header are in there), right?  Why can't the kernel net code
> extract the port and give it to me?  It's obviously possible, since Winsock
> does it.**

I outlined the problem with the standard socket API (note I said API, not
theoretical possibility to look at the packet content) in my previous message,
including a pointer to Stevens' book which explains the issue far better
than I can.

Anyway, since the IP_RECVERR is a "hack" to get more information which is
not available with the standard API, it's theoretically possible to add to it
anything, including the destination IP address and port on the original
packet. Read ip(7) carefully: it would appear that either the SOCK_EE_OFFENDER
macro or the actual data (not anciliary data) received from the error queue
can help you.

Too bad that this IP_RECVERR seems to be a completely non-standard Linux-only
feature...

-- 
Nadav Har'El                        |         Tuesday, Jul 31 2001, 12 Av 5761
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |Jury: Twelve people who determine which
http://nadav.harel.org.il           |client has the better lawyer.
