Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbRAKVK1>; Thu, 11 Jan 2001 16:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRAKVKR>; Thu, 11 Jan 2001 16:10:17 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:49929 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129896AbRAKVKD>;
	Thu, 11 Jan 2001 16:10:03 -0500
Date: Thu, 11 Jan 2001 22:09:43 +0100
From: Frank de Lange <frank@unternet.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010111220943.F3269@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D9D87.8A868F6A@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 11, 2001 at 10:48:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, just one last addition to what has nearly become my own thread...

I now am fairly certain that the problem (network stalls on multiprocessor systems) is not BP6 or NE2K-PCI specific. I found several postings which relate to similar problems on dissimilar hardware. Another interesting one is:

Re: PROBLEM : Networking stops working with kernel 2.4.0-test11 
  (http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg18722.html)

"...I have an almos identical system as you, 2x200MMX motherboard (Gigabyte
       586DX) also Voodoo3 (2000 pci) the same nic Realtek 8029AS, also a bt848
       tv card, also SCSI (Aic-7880 onboard, but not used).

       I have reported it some time ago, and now all I get with
       2.4.0-test11-pre4 and I think a additional patch is  NETDEV WATCHDOG:
       eth0: transmit timed out, and something in the console about lost irq?

       I can't reproduce it with a uniprocesor kernel, and I have a 3c503 card
       wich uses the 8390 module, so I suppose that the problem it's not in the
       8390, and it seems to be smp related...."


ne2k-pci freezes with APIC error on 2.4.0-testX SMP
  (http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg14468.html)

"...

       When doing massive NFS transfers (2.4 machine as the client) on my SMP
       box
       (Abit BP6 2x celeronA 533mhz (non-overclocked) 64Mb ram, latest
       apt-get-ed
       debian woody) my ne2k-pci card (Realtek Semiconductor Co., Ltd.
       RTL-8029(AS)
        (rev 0)) suddenly stops working. test5 spits that in syslog:..."

More to be found when searching the archives. This problem has been around for
a long, long time (probably since the current level of apic-support was added,
somewhere around 2.3.1x?). It has been reported by several people, several
times. I feel like rigging every apic-related piece of code with a zillion
bells and printk's but that would surely only create more mayhem as this whole
thing seems to be timing-related...

Anyone got any idea's on how to tackle this? Anyone who is 'intimate with' the
apic-related code? It'll take me some time to dive into that part, so if there
is anyone who already has taken the plunge, do tell...

Cheers//Frank

[ who is still running apic-less, without problems [
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
