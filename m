Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291310AbSBGU75>; Thu, 7 Feb 2002 15:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291298AbSBGU7q>; Thu, 7 Feb 2002 15:59:46 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:28643 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S291307AbSBGU7d>; Thu, 7 Feb 2002 15:59:33 -0500
Message-ID: <3C62EC67.FCB9958A@nortelnetworks.com>
Date: Thu, 07 Feb 2002 16:06:47 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: "Perches, Joe" <joe.perches@spirentcom.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
In-Reply-To: <Pine.LNX.3.95.1020207151325.10014A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 7 Feb 2002, Chris Friesen wrote:

> > The possibility of random dropping of packets in the kernel means that an
> > infinite loop on sendto() will chew up the entire machine even if you've only
> > got a 10Mbit/s link.  This seems just wrong.
> >
> 
> This is the basic reason why the return-value of sento() should be
> ignored, even though Alan doesn't agree. Basically, if you give
> valid parameters to sendto() (correct socket, pointer to correct
> structure, etc), you can just ignore the return value. Its not useful
> in the overall scheme. If you must make sure that a UDP packet got
> to a receiver, then the receiver must (somehow) hand-shake with you.
> How you do the handshake is entirely up to you. UDP stands for
> User Datagram Protocol. It's a quick-fling out the spicket. How you
> handle lost messages is up to the user.

Okay, I buy the fact that sendto can't guarantee that the packet got anywhere. 
Fine.  Now what about sending packets out faster than the output device can
possibly handle them?  We know the device is busy, it's under our control.  It
seems to me to be logical to block the sender until the congestion goes away, or
return with an error code if the sender is non-blocking.  This may not play nice
with the current kernel networking code (qdisc and all that) but doesn't it seem
like a good idea in principle?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
