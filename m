Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTFOO2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTFOO1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:27:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:1442 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262283AbTFOO1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:27:38 -0400
Importance: Normal
Sensitivity: 
Subject: Re: e1000 performance hack for ppc64 (Power4)
To: "David S. Miller" <davem@redhat.com>
Cc: ltd@cisco.com, anton@samba.org, haveblue@us.ibm.com,
       scott.feldman@intel.com, dwg@au1.ibm.com, linux-kernel@vger.kernel.org,
       "Nancy J Milliner" <milliner@us.ibm.com>,
       "Ricardo C Gonzalez" <ricardoz@us.ibm.com>,
       "Brian Twichell" <twichell@us.ibm.com>, netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF7D02DC37.06BCABE8-ON85256D46.004E9127@pok.ibm.com>
From: "Herman Dierks" <hdierks@us.ibm.com>
Date: Sun, 15 Jun 2003 09:40:41 -0500
X-MIMETrack: Serialize by Router on D01ML065/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 06/15/2003 10:40:49 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Look folks,   we run 40 to 48  GigE adapters in a p690 32 way on AIX and
they basically all run at full speed  so let me se you try that on most of
these other boxes you are talking about.     Same adapter, same hardware
logic.
I have also seen what many of these other boxes you talk about do when data
or structures are not aligned on 64 bit boundaries.
The PPC HW does not have those 64bit alignment  issues.   So, each machine
has some warts.  Have yet to see a perfect one.

If you want a lot of PCI adapters on a box, it takes a number of bridge
chips and other IO links to do that.
Memory controllers like to deal with cache lines.
For larger packets, like jumbo frames or large send (TSO), the few added
DMA's is not an issue as the packets are so large the DMA soon get aligned
and are not an issue.   With TSO being the default,   the small packet case
becomes less important anyway.   Its more an issue on 2.4 where TSO is not
provided.  We also want this to run well if someone does not want to use
TSO.

Its only the MTU 1500 case with non-TSO that we are discussing here so
copying a few bytes is really not a big deal as the data is already in
cache from copying into kernel.  If it lets the adapter run at speed, thats
what customers want and what we need.
Granted, if the HW could deal with this we would not have to, but thats not
the case today so I want to spend a few CPU cycles to get best performance.
Again, if this is not done on other platforms, I don't understand why you
care.

If we have to do this for PPC port, fine.   I have not seen any of you
suggest a better solution that works and will not be a worse hack to TCP or
other code.  Anton tried various other ideas before we fell back to doing
it the same way we did this in AIX.   This code is very localized and is
only used by platforms that need it.  Thus I don't see the big issue here.

Herman


"David S. Miller" <davem@redhat.com> on 06/14/2003 01:08:50 AM

To:    ltd@cisco.com
cc:    anton@samba.org, haveblue@us.ltcfwd.linux.ibm.com, Herman
       Dierks/Austin/IBM@IBMUS, scott.feldman@intel.com, dwg@au1.ibm.com,
       linux-kernel@vger.kernel.org, Nancy J Milliner/Austin/IBM@IBMUS,
       Ricardo C Gonzalez/Austin/IBM@ibmus, Brian
       Twichell/Austin/IBM@IBMUS, netdev@oss.sgi.com
Subject:    Re: e1000 performance hack for ppc64 (Power4)



   From: Lincoln Dale <ltd@cisco.com>
   Date: Sat, 14 Jun 2003 15:52:35 +1000

   can we have the TCP retransmit side take a performance hit if it needs
   to
   realign buffers?

You don't understand, the person who mangles the packet
must make the copy, not the person not doing the packet
modifications.

   for a "high performance app" requiring gigabit-type speeds,

...we probably won't be using ppc64 and e1000 cards, yes, I agree
:-)

Anton, go to the local computer store and pick up some tg3
 cards or a bunch of Taiwan specials :-)




