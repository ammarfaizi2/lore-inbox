Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTHaGa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 02:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbTHaGa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 02:30:27 -0400
Received: from [213.39.233.138] ([213.39.233.138]:44209 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262529AbTHaGa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 02:30:26 -0400
Date: Sun, 31 Aug 2003 08:30:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831063020.GA30196@wohnheim.fh-wedel.de>
References: <q2SH.AA.3@gated-at.bofh.it> <qfwI.15D.27@gated-at.bofh.it> <qgCn.2y4.11@gated-at.bofh.it> <E19tEfx-0002vL-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E19tEfx-0002vL-00@neptune.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 August 2003 00:58:33 +0200, Pascal Schmidt wrote:
> 
> All you have to do is drop the incoming packets if they exceed
> a certain bandwidth. That will stop the corresponding ack automatically
> since your TCP stack won't even see the packet.

You've cut away the part where I explained that you don't want to
throw away the incoming packet.  Yes, the stupid approach works, but
it is still stupid.

> I'm doing this on my ISDN line to limit the rest of the house to one
> third of the bandwidth even if they're all busy downloading tons of
> warez. I'm paying, I want the bandwidth when I need it. They can get
> it all when there's no traffic for my machine.
> 
> No problem with the HTB queueing discipline.

But latency just went boom.  On your side, your packets will come out
quickly because the queue is short.  But on your ISP's side, there is
a single queue for both your and the warez' traffic.  Your packets
will get thrown away just as much, as theirs.

> Yes, latency is a problem if you want to saturate your bandwidth. It is
> easy to guarantee some bandwith for latency critical stuff - just
> don't give out that piece of bandwith to something else. Of course,
> then most of the time that piece is wasted...

This works if your latency requirements are moderate or the pipe is
big.  Assume 5ms and ISDN and you have a window of 400 Bytes roughly.
Each time you happen to receive 400 Bytes of packets at the same time,
you hear a pause.  A single large packet is more than that.  Oops!

For Larry's T1 line, the numbers naturally go up, but it still doesn't
take a huge amount of packets.

> and it doesn't help with problems somewhere along the net.

Compared to ISDN or T1, the net usually has big pipes and people tend
to care about low latency, so that problem doesn't even exist compared
with the receiving end.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
