Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAPTz5>; Tue, 16 Jan 2001 14:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAPTzr>; Tue, 16 Jan 2001 14:55:47 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:45197
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S129631AbRAPTz2>; Tue, 16 Jan 2001 14:55:28 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCAA@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'beowulf@beowulf.org'" <beowulf@beowulf.org>
Subject: Ethernet Bonding Performance under kernel 2.4.0
Date: Tue, 16 Jan 2001 14:48:31 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've a system comprosed of two PIII machines, equipped with Znyx 346Q 4port
ethernet cards (tulip driver) which I'd like to connect together in a bonded
configuration.  For various reasons, we require 2.4.0 kernels on our
machines - currently we are using 2.4.0-test9.  

The setup is simple:  each port on a 346Q in one machine is connected to the
corresponding port on the 346Q in the other machine via a crossover cable.

	+-------+      +-------+
	|       |------|       |
 -----| Box A |------| Box B |-----
	|       |------|       |
      |       |------|       |
	+-------+      +-------+

Problem #1
----------
Initally, after bootup, the performance of each of the four networks between
the two PCs is subpar.  Transfer rates will vary from a few hundred KB/s to
perhaps a few MB/s, and the transfer time is appreciably long.  This, on a
forced 100TX-FD link.  After a few minutes however, things appear to settle
down, and I can achieve 11.2MB/s when transferring a large binary file via
ftp (rate as reported by ncftp).  The de4x5 driver shows the same behaviour.

Problem #2
----------
I built the bonding driver, and using a copy of ifenslave.c which I found
for kernel 2.3.50, I was able to make a bonded channel.  The trouble I found
is that the performance was not at all what I expected.  Using the first eth
port, I achieved a throughput (FTP transfer of a large binary file) of 10.4
MB/s (11.2MB/s if set to full duplex).  Using 2 ports, the performance
dropped to about 3.5MB/s.  Adding a third port brings the throughput to
about 5.2MB/s and adding the fourth port only takes it up to 5.75MB/s.

The de4x5 driver shows the same drop in performance as the tulip driver.

Using the TEQL (trivial link equalizer) (instructions from the Adv-routing
howto) provides the same measurements exactly.

Thoughts?

Cheers!
Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
