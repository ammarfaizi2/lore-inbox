Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277612AbRJHXcM>; Mon, 8 Oct 2001 19:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277611AbRJHXcD>; Mon, 8 Oct 2001 19:32:03 -0400
Received: from spog.gaertner.de ([194.45.135.2]:40976 "EHLO spog.gaertner.de")
	by vger.kernel.org with ESMTP id <S277605AbRJHXbr>;
	Mon, 8 Oct 2001 19:31:47 -0400
From: Joerg Schumacher <schuma@gaertner.de>
Message-Id: <200110082332.BAA16370@aunt.gaertner.de>
Subject: PF_PACKET: packets out of order 
To: linux-kernel@vger.kernel.org
Date: Tue, 9 Oct 2001 01:32:16 +0200 (MET DST)
X-NCC-RegID: de.gaertner
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

NeTraMet v44b10 uses pcap(3) and complains about timestamps jumping 
backwards.  Looks like a PF_PACKET socket doesn't receive the packets 
in the correct order.  Some timestamps from a "tcpdump -tt":

   RX:  1001465480.175100 [...] 
   TX:  1001465480.179111 [...] 
   RX:  1001465480.177315 [...] 
                   ^^^^^^
   TX:  1001465480.180514 [...]
   RX:  1001465480.179706 [...]
	   
Some more figures (obtained with a quick hack using libpcap-2001.09.25 
on two different machines):

   2.2.19:
        stats:    100000 packets received
                       0 packets dropped
        good:      90222 packets
        bad:        9778 packets
        max delta: 15850 usec

   2.4.1:
        stats:    100000 packets received
                       0 packets dropped
        good:      99538 packets
        bad:         462 packets
        max delta:   471 usec
    
Any plans to fix this in the kernel?  


Regards,
Joerg 

-- 
 Gaertner Datensysteme                         38114 Braunschweig 
 Joerg Schumacher                              Hamburger Str. 273a
 Tel: 0531-2335555                             Fax: 0531-2335556
