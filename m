Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130035AbRBUAJA>; Tue, 20 Feb 2001 19:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130337AbRBUAIk>; Tue, 20 Feb 2001 19:08:40 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:36622 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S130035AbRBUAIc>; Tue, 20 Feb 2001 19:08:32 -0500
From: "Vibol Hou" <vibol@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: netdev issues (3c905B)
Date: Tue, 20 Feb 2001 16:06:28 -0800
Message-ID: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some problems on a heavily loaded web server.  The first is that the
kernel is spitting out a bunch of "NETDEV WATCHDOG: eth0: transmit timed
out" errors.  I do not recall this happening in 2.4.0 under the same
conditions.

Another problem that I seem to have, of which I have had reports from
clients, is that the server has problems talking to clients using modems
This didn't occur before with the 2.2 series kernel (all other things held
constant).  It seems each time a client tries to load up any site on the
server, the connection will just die (or stall).  This does not apply to
high-bandwidth connections (DSL and up) since everything seems fine on DSL
and faster, but I tried connecting using my dial-up account with Earthlink,
and the reports seem to be true.  Can those of you on a 56k modem try
connecting to http://khmerconnection.com and see if the page loads?  Apache
isn't the only service affected.  It seems *any* TCP communication runs like
a turtle (even SSH.  takes minutes to login, then minutes to echo each
letter.  doesn't do this on a DSL connection from the same computer).

The card that is exhibiting this problem is a 3c905B (lspci below):

00:08.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation: Unknown device 9055
        Flags: bus master, medium devsel, latency 80, IRQ 17
        I/O ports at e400 [size=128]
        Memory at e8001000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at e4000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

dmesg shows hordes of these at high peak usage (300KBps+):

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0cd8 media 8880 dma 0000003a.
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, full 0; dirty 9256291(3) current 9256291(3).
  Transmit list 00000000 vs. f7de5230.
  0: @f7de5200  length 80000042 status 00010042
  1: @f7de5210  length 8000004a status 8001004a
  2: @f7de5220  length 80000036 status 80010036
  3: @f7de5230  length 80000036 status 00010036
  4: @f7de5240  length 80000042 status 00010042
  5: @f7de5250  length 80000036 status 00010036
  6: @f7de5260  length 800005ea status 000105ea
  7: @f7de5270  length 800005ea status 000105ea
  8: @f7de5280  length 8000003a status 0001003a
  9: @f7de5290  length 8000003e status 0001003e
  10: @f7de52a0  length 8000003a status 0001003a
  11: @f7de52b0  length 8000003e status 0001003e
  12: @f7de52c0  length 8000003e status 0001003e
  13: @f7de52d0  length 8000004a status 0001004a
  14: @f7de52e0  length 8000004a status 0001004a
  15: @f7de52f0  length 8000003e status 0001003e
eth0: Resetting the Tx ring pointer.

Any ideas?

Thanks,
--
Vibol Hou

