Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285367AbRLXV5O>; Mon, 24 Dec 2001 16:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbRLXV5F>; Mon, 24 Dec 2001 16:57:05 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:59916 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S285367AbRLXV4u>;
	Mon, 24 Dec 2001 16:56:50 -0500
Date: Mon, 24 Dec 2001 22:56:48 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <20011224225648.I2461@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011224211726.H2461@lug-owl.de> <1062462662.1009226676@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062462662.1009226676@[195.224.237.69]>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-24 20:44:37 -0000, Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
wrote in message <1062462662.1009226676@[195.224.237.69]>:
> >That would give a different result: "functional TCP connections" or
> >"non-functional TCP connections". Mine are between that. If data gets
> >sent in small chunks, everything is fine, but if it's a larger
> >transfer (more than one ethernet frame may transport???), write()
> >stalls (or non-blocking write returns), but data is kept in
> >Send-Q rather than being sent down to the client.

Well, some testing done. I've written a small microserver bound to
port 1111/tcp via inetd:
--------------------------------------
#!/bin/sh

LEN="`cat /root/size`"

dd bs=$LEN if=/dev/zero count=1 2>/dev/null
sleep 1
exit 0
------------------------------------

I can control it's output by a file. It seems that I can always
transmit up to ~920 bytes at a time, but never more than 940.
All values in between these borders are more-or-less functional,
depending their size (smaller packets == high chance to reach client,
larger packets == small chance to reach destination).

> Just to check the completely obvious:
> 
> Difficult / impossible to tell without a tcpdump, but last time I
> saw something like this, one end was silently dropping packets
> exactly equal to the MTU size (or up to 3 bytes smaller), but
> transmitting all other packets (in this instance it was a bizarre
> 802.11 problem).

It's quite a problem to do tcpdumping on a host from which you
never can get more than ~920 bytes at a time, neither by ftp, nor
by ssh or telnet or whatever:-)

Well, I've tcpdumped now, and it seemy my old WaveSwitch is
to blame. The "bad" server actually transmits everything
(and also tries retransmits etc.), but that never leaves the
switch again... I've changed the switch port as well as the
cable. It seems the switch and that network card don't
like each other...

I've now replaced the network card, everything is fine now.

I've never seen a NIC failing partially, I've learned a lot
this evening...

Thank you very much (to all who send me notes) and have a nice
X-Mas...

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
