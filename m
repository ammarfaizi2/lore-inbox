Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUBWUTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUBWUTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:19:55 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:62924 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262015AbUBWUTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:19:02 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Feb 2004 20:18:25 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems [NOT resolved]
Message-ID: <403A6011.5674.103225D9@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > Linux233 kernel: NETDEV WATCHDOG: eth1: transmit timed out
> > > > > Linux233 kernel: eth1: link up, 10Mbps, half-duplex, lpa 0x0000
> > > > > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > > > > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > > > > Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > > > > Linux233 kernel: nfs: server 486Linux OK
> > > > > Linux233 kernel: nfs: server 486Linux OK
> > > > > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > > > > Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > > > > Linux233 kernel: nfs: server 486Linux OK
> > 
> > Well, I am at a loss now or any idea what to do next.  I have tried 
> > everything this morning to build this an eliminate the problem.  
> > Whatever I do, kernel builds nice, boots nice and no problems... 
> > except for these NIC timeouts - it makes 2.6.3 totally unusable for 
> > me.
> > 
> > I state again, these _very_same_ cards work perfectly under any other 
> > kernel I have ever used over the last 3 years (like I am back on 
> > 2.6.2 right now).
> 
> "This is usually irq routing related...  Try booting with 'noapic' or 
> similar. Jeff"
> 
> OK, this was the solution.  I am right bloody idiot.  Good call Jeff.
> 
> I believed I had APIC turned off (I didn't).  So I then compiled 
> kernel with debugging set in 8139too.c, and thought I would be real 
> cool and catch the problem and submit a kernel patch (Yea, right!).  
> I also looked at what I done.
> 
> I was booting with append=noapic... then read a bit... it needed to 
> be a string, append="noapic".
> 
> It all works great now on 2.6.3.
> 
> Sorry to bother you guys when nothing is wrong, and I apologise for 
> me being a dipstick twice over :/

I spoke too bloody soon.  The problem still exists, but on a lesser 
scale:

Feb 23 19:25:39 Linux233 kernel: nfs: server 486Linux not responding, 
still trying
Feb 23 19:25:41 Linux233 kernel: NETDEV WATCHDOG: eth0: transmit 
timed out
Feb 23 19:25:41 Linux233 kernel: nfs: server 486Linux OK
Feb 23 19:28:27 Linux233 kernel: nfs: server 486Linux not responding, 
still trying
Feb 23 19:28:31 Linux233 kernel: NETDEV WATCHDOG: eth1: transmit 
timed out
Feb 23 19:28:31 Linux233 kernel: eth1: link up, 10Mbps, half-duplex, 
lpa 0x0000
Feb 23 19:28:35 Linux233 kernel: nfs: server 486Linux not responding, 
still trying
Feb 23 19:28:35 Linux233 kernel: NETDEV WATCHDOG: eth0: transmit 
timed out
Feb 23 19:28:35 Linux233 kernel: nfs: server 486Linux OK

I lose 10 seconds on network when this happens, and eth0 going AWOL 
then seems to make eth1 go awol straight after.

The cards all work FINE on 2.6.2/1/0 (2.4.1.->.24)...  what has 
changed so much to cause this, so at least I can supply some info.

:/

Nick

-- 
"I am not Spock", said Leonard Nimoy.
"And it is highly illogical of humans to assume so."

