Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293492AbSCASOt>; Fri, 1 Mar 2002 13:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293472AbSCASNE>; Fri, 1 Mar 2002 13:13:04 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:17540 "EHLO q-ag.de")
	by vger.kernel.org with ESMTP id <S293467AbSCASMk>;
	Fri, 1 Mar 2002 13:12:40 -0500
Message-ID: <3C7FC488.F5D348DC@colorfullife.com>
Date: Fri, 01 Mar 2002 19:12:24 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.5-pre1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Nathan Walp <faceprint@faceprint.com>
CC: Dave Jones <davej@suse.de>, Benjamin Pharr <ben@benpharr.com>,
        linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu> <20020222022149.N5583@suse.de> <20020222063721.GA8879@faceprint.com>
Content-Type: multipart/mixed;
 boundary="------------68E05C2B8D1A065B4B604276"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------68E05C2B8D1A065B4B604276
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Nathan Walp wrote:
> 
> On Fri, Feb 22, 2002 at 02:21:49AM +0100, Dave Jones wrote:
> >  > It compiled fine. When I booted up everything looked normal with the
> >  > exception of a
> >  > eth1: going OOM
> >  > message that kept scrolling down the screen. My eth1 is a natsemi card.
> >
> >  That's interesting. Probably moreso for Manfred. I'll double check
> >  I didn't goof merging the oom-handling patch tomorrow.
> 
> Ditto here on my natsemi.  It hasn't really spit out the error since
> boot, about 12 hours ago.  Card has been mainly idle, only used to
> connect via crossover cable to my laptop, which hasn't been used much in
> that time.

Please apply the attached oneliner, it fixes the problem. The error was
spotted by Tim or Jeff.

--
	Manfred
--------------68E05C2B8D1A065B4B604276
Content-Type: text/plain; charset=us-ascii;
 name="patch-natsemi-typo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-natsemi-typo"

--- 2.5/drivers/net/natsemi.c	Fri Mar  1 17:16:38 2002
+++ build-2.5/drivers/net/natsemi.c	Fri Mar  1 19:11:52 2002
@@ -1380,7 +1380,7 @@
 		np->rx_ring[entry].cmd_status =
 			cpu_to_le32(np->rx_buf_sz);
 	}
-	if (np->cur_rx - np->dirty_tx == RX_RING_SIZE) {
+	if (np->cur_rx - np->dirty_rx == RX_RING_SIZE) {
 		if (debug > 2)
 			printk(KERN_INFO "%s: going OOM.\n", dev->name);
 		np->oom = 1;

--------------68E05C2B8D1A065B4B604276--


