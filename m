Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRHJIZc>; Fri, 10 Aug 2001 04:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266158AbRHJIZM>; Fri, 10 Aug 2001 04:25:12 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:6663 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S266040AbRHJIZF>;
	Fri, 10 Aug 2001 04:25:05 -0400
Message-ID: <3B738353.26AB3B13@yahoo.com>
Date: Fri, 10 Aug 2001 02:46:43 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.19 i586)
MIME-Version: 1.0
To: Paul <pstroud@bellsouth.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mulitple 3c509 cards 2.4.x Kernel
In-Reply-To: <3B6ADBA7.2FC0AE2A@bellsouth.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I have a x86 server with multiple(2) 3c509 cards. When I build the 3c509
> driver
> into the kernel. It will only pick up a single card. The cards are
> NOT in pnp mode
> according to isapnp on boot. I have added:
> 
> append = "ether=3,0x300,0,0,eth0 ether=10,0x280,0,0,eth1"
> 
> to the lilo file and still only one card is detected. The io ports and

The 3c509 is an anomaly in comparison to other ISA cards, in that
you DONT want to specify I/O (or irq) values.  3Com used a scheme that
allows relatively safe ISA probes, and specifying an I/O base will
do nothing but interfere with that.  (This is documented btw)

In your case, a simple

append = "ether=0,0,eth1"

should do the trick (assuming the ether= parsing is currently 
functional... :)

Paul.


