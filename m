Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313596AbSEJLBc>; Fri, 10 May 2002 07:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313661AbSEJLBb>; Fri, 10 May 2002 07:01:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63677 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313596AbSEJLBa>;
	Fri, 10 May 2002 07:01:30 -0400
Date: Fri, 10 May 2002 03:49:22 -0700 (PDT)
Message-Id: <20020510.034922.112319314.davem@redhat.com>
To: ak@muc.de
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <m3elgk8ftq.fsf@averell.firstfloor.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: 10 May 2002 12:20:17 +0200

   It is basically impossible without hardware support/major stack changes to 
   do it securely for networking RX. The problem is that to put data directly
   from the NIC into an user space address range the NIC already needs
   to demultiplex the sockets before it starts to DMA. 
   
Sun's Cassini gigabit chips have the infrastructure.  It's a very
simple onboard header parser (it's not a real CPU, just some thick
ASIC logic).  You write small header parsing scripts plus provide it
with a socket cache table, it accumulates data into pages from the
streams for you.

Of course all of this is moot until we can actually write a driver
for one of these cards with such features (I'm working on it for
Cassini and things look good right now).

   For userspace you would need to put it into an page aligned buffer and
   change the page tables of the user space process, but especially on SMP
   that is usually slower than just copying. Managing the stuff in a shared
   memory segment is also likely not secure
   
Alexey already did hacks to make this work on xmit, we have all of the
infrastructure really due to the direct I/O bits.

   [There is a special hack in the stack to do it for network sniffing,
   but it is not general purpose enough for real protocols] 
   
RX TCP is very doable with the correct hardware.  I already have the
implementation in my head given something like Cassini HW.
