Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTAILa1>; Thu, 9 Jan 2003 06:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbTAILa1>; Thu, 9 Jan 2003 06:30:27 -0500
Received: from users.linvision.com ([62.58.92.114]:61630 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S265863AbTAILaZ>; Thu, 9 Jan 2003 06:30:25 -0500
Date: Thu, 9 Jan 2003 12:38:58 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030109123857.A15625@bitwizard.nl>
References: <20030108130850.GQ22951@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108130850.GQ22951@wiggy.net>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 02:08:50PM +0100, Wichert Akkerman wrote:
> 
> 13:57:39.812123 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9352713 win 32616 <nop,nop,timestamp 846062 369670698>
> 13:57:39.823581 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9352713:9353921(1208) ack 1 win 5712 <nop,nop,timestamp 369670698 846028> [class 0x2]
> 13:57:39.823636 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9353921 win 32616 <nop,nop,timestamp 846063 369670698>

The packet is acked about 50 us after reception. Wicked! 

> 13:57:39.835144 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9353921:9355129(1208) ack 1 win 5712 <nop,nop,timestamp 369670698 846028> [class 0x2]
> 13:57:39.835197 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9355129 win 32616 <nop,nop,timestamp 846064 369670698>

Same here. 

> 13:57:39.844277 2001:968:1::2.8000 > tornado.wiggy.net.33035: P 9355129:9355601(472) ack 1 win 5712 <nop,nop,timestamp 369670701 846062> [class 0x2]
> 13:57:39.844326 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9355601 win 32616 <nop,nop,timestamp 846065 369670701>

> 13:57:40.221776 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9355601:9356809(1208) ack 1 win 5712 <nop,nop,timestamp 369670739 846065> [class 0x2]
> 13:57:40.221846 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9356809 win 32616 <nop,nop,timestamp 846103 369670739>

> 13:57:40.233558 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9356809:9358017(1208) ack 1 win 5712 <nop,nop,timestamp 369670739 846065> [class 0x2]
> 13:57:40.233613 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9358017 win 32616 <nop,nop,timestamp 846104 369670739>

> 13:57:40.245110 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9358017:9359225(1208) ack 1 win 5712 <nop,nop,timestamp 369670739 846065> [class 0x2]
> 13:57:40.245160 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846105 369670739>

same. same. same. 

> 13:57:40.282351 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670744 846103>

But now: No ack! Funny. 

> 13:57:40.284307 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9360433:9360653(220) ack 1 win 5712 <nop,nop,timestamp 369670744 846103>

Another packet, no ack!

> 13:57:40.297307 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9360653:9361861(1208) ack 1 win 5712 <nop,nop,timestamp 369670745 846104>
> 13:57:40.297376 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846111 369670744,nop,nop,sack sack 1 {9360653:9361861} >

Another packet, but this time it SACKs  the just-recieved packet. It looks
as if the two packets inbetween somehow were not recognized as belonging
with this connection. 

> 13:57:40.308222 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9362081:9363289(1208) ack 1 win 5712 <nop,nop,timestamp 369670745 846104> [class 0x2]
> 13:57:40.308271 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846112 369670744,nop,nop,sack sack 2 {9362081:9363289}{9360653:9361861} >

new packet, recognized ok, buffered, and acked!

> 13:57:40.310424 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9361861:9362081(220) ack 1 win 5712 <nop,nop,timestamp 369670745 846105>
> 13:57:40.310471 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846112 369670744,nop,nop,sack sack 1 {9360653:9363289} >
> 13:57:40.325396 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9363289:9363509(220) ack 1 win 5712 <nop,nop,timestamp 369670750 846111> [class 0x2]
> 13:57:40.325447 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846113 369670744,nop,nop,sack sack 1 {9360653:9363509} >

Two more packets, and still more hints towards the other machine that 
we're missing 9359225-9360653

> 13:57:40.568652 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670773 846113>

So, it retransmits the first. but we don't see it as beloging to
this connection or something, so it gets ignored. 

> 13:57:41.121608 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670829 846113>
> 13:57:42.242095 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670941 846113>
> 13:57:44.481379 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369671165 846113>
> 13:57:48.963035 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369671613 846113>

again, again, again. 


It looks as if somehow those two packets 9359225:9360433 and 9360433:9360653 get 
mangled in a way as to invalidate the checksum. This would cause "silent drop" 
of these packets before they were acked.... 

Can you check the stats counters, to see if they are indeed dropped?

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
