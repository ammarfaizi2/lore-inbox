Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154365AbPGXNfQ>; Sat, 24 Jul 1999 09:35:16 -0400
Received: by vger.rutgers.edu id <S154327AbPGXNfI>; Sat, 24 Jul 1999 09:35:08 -0400
Received: from ppp-165-120.villette.club-internet.fr ([195.36.165.120]:1727 convert rfc822-to-8bit "EHLO localhost.localdomain") by vger.rutgers.edu with ESMTP id <S154320AbPGXNe0>; Sat, 24 Jul 1999 09:34:26 -0400
Date: Sat, 24 Jul 1999 15:51:08 +0200 (MET DST)
From: Gerard Roudier <groudier@club-internet.fr>
To: Linux <linux-kernel@vger.rutgers.edu>, linux-scsi@vger.rutgers.edu
Subject: Joking PCI bridges: still another one.
Message-ID: <Pine.LNX.3.95.990724151242.1018A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-kernel@vger.rutgers.edu


I just read the following about a non-Intel, non-IBM, non-SUN, non-HP, and
non-Digital PCI-HOST bridge (guess vendor :) ):

 Ordering is guaranteed when interrupts are used. An interrupt handler 
 is not executed until all writes initiated by the interrupting device
 have completed.
 (+ some confusing explanations about the fact that it is the only
  mechanism PCI device drivers must rely on for transaction ordering)

As opposite, we can read from PCI:

 Interrupt requests do not appear as transactions on PCI bus (they are 
 sideband signals), and, therefore, have no ordering relationship to any 
 transactions. Furthermore, the system is not required to use the 
 Interrupt Acknowledge bus transaction to service interrupts. So 
 interrupts are not synchronizing events, and device drivers cannot 
 depend on then to flush posting buffers.

(I didn't read anything about this 'non' PCI-HOST bridge that address
Interrupt Acknowledge Transactions)

Based on my current investigations, it may be the case that numerous PCI
device drivers of ours may encounter problems on some non-Intel and
non-IBM bridge-based systems, due to bridge not implementing the standard
about transaction ordering rules.

As I wrote in some previous posting, I plan to propose serious work-arounds 
for joking PCI bridges:) for the stuff I maintain (ncr/sym driver) before
the end of August if we survive August the 11'th obviously:-).
This may consist in a few number of lines mostly trivial, or to end up
with crossing fingers for some situations, but I need to investigate
the issue prior to do the changes in the code.

It will be interesting, in my opinion, to allow PCI device drivers to have
knowledge about the PCI-HOST bridge of the system or to have access to
some quirk flags associated with that bridge. 

Regards,
   Gérard.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
