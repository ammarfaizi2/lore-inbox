Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271932AbSISRYt>; Thu, 19 Sep 2002 13:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271977AbSISRYt>; Thu, 19 Sep 2002 13:24:49 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:61422 "EHLO
	beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S271932AbSISRYp>; Thu, 19 Sep 2002 13:24:45 -0400
Date: Thu, 19 Sep 2002 13:29:31 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: netdev@oss.sgi.com, Jason Lunz <lunz@falooley.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <edward_peng@dlink.com.tw>
Subject: Re: PATCH: sundance #2
In-Reply-To: <3D8A056C.2000605@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0209191316300.29420-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Jeff Garzik wrote:

> Thanks to Donald for his comments.  This patch addresses the first of 
> his two emails.
> 
> This patch is _cumulative_ with the last one I sent (sundance 1.04), so 
> do not discard that one.
> 
> Again additional testing is appreciated.  Keep the feedback coming, 
> there will be more sundance bugfixes (patch #3, #4, etc.)

+	- If no phy is found, fail to load that board
+	- Always start phy id scan at id 1 to avoid problems (Donald Becker)
+	- Autodetect where mii_preable_required is needed,
+	default to not needed.  (Donald Becker)
...
+
+/* Set iff a MII transceiver on any interface requires mdio preamble.
+   This only set with older tranceivers, so the extra
+   code size of a per-interface flag is not worthwhile. */
+static int mii_preamble_required = 0;

You can get rid of this as a module option, and make it a per-interface
setting. 
The transceiver on the Kendin chip requires this (rather old-fashioned)
access method, while none of the previous Sundance-based boards with
external transceivers did.

I added it as a module parameter as a back-up over-ride, but I'm certain
that the automatic detection works.

This is a module parameter because I recently had a bad experience
with a specific 3Com 3c905B chip rev.  It claimed to not need
transceiver preamble, but would not work without it.

> 				Theory of Operation

Whoever changed the transmit path should update the TOO.  

-	{"Sundance Technology Alta", {0x020113F0, 0xffffffff,},
-	 PCI_IOTYPE, 128, CanHaveMII},
+	{"D-Link DFE-550TX FAST Ethernet Adapter"},
+	{"D-Link DFE-550FX 100Mbps Fiber-optics Adapter"},

Yeah, you should probably throw away the rest of the changes.
You are probably going to want to keep the drv_flags field.  I know
that all of the current chips have the same flag (CanHaveMII), but...



-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

