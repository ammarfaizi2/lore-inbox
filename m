Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289212AbSANMQV>; Mon, 14 Jan 2002 07:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289224AbSANMQL>; Mon, 14 Jan 2002 07:16:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1298 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289212AbSANMQD>; Mon, 14 Jan 2002 07:16:03 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Mon, 14 Jan 2002 12:27:28 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), yodaiken@fsmlabs.com,
        phillips@bonn-fries.net (Daniel Phillips),
        arjan@fenrus.demon.nl (Arjan van de Ven), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201141248220.29048-100000@serv> from "Roman Zippel" at Jan 14, 2002 01:00:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Q6D2-0001aZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm really trying to avoid this, I'm more than happy to discuss
> theoretical or practical problems _if_ they are backed by arguments,
> latter are very thin with Victor. Making pointless claims only triggers
> above reaction. If I did really miss a major argument so far, I will
> publicly apologize.

You seem to be missing the fact that latency guarantees only work if you
can make progress. If a low priority process is pre-empted owning a
resource (quite likely) then you won't get your good latency. To
handle those cases you get into priority boosting, and all sorts of lock
complexity - so that the task that owns the resource temporarily can borrow
your priority in order that you can make progress at your needed speed.
That gets horrendously complex, and you get huge chains of priority
dependancies including hardware level ones.

The low latency patches don't make that problem go away, but they achieve
equivalent real world latencies up to at least the point you have to do
priority handling of that kind. 

Alan
