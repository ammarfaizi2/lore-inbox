Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271958AbRIINa6>; Sun, 9 Sep 2001 09:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271961AbRIINas>; Sun, 9 Sep 2001 09:30:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3332 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271958AbRIINaf>; Sun, 9 Sep 2001 09:30:35 -0400
Subject: Re: "Cached" grows and grows and grows...
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sun, 9 Sep 2001 14:34:11 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mcelrath@draal.physics.wisc.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010909151509.6a0c7d68.skraw@ithnet.com> from "Stephan von Krawczynski" at Sep 09, 2001 03:15:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15g4ix-00073A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> only on "the other side of the street". This is a meminfo from a 2.4.9-ac9
> kernel working one day, and then going crazy on too low mem. "Going crazy" here
> means that kswapd took virtually over the cpu(s) and swapped the hell out the
> machine:
> (BTW you can see that swap did not really grow, but seems to get in and out
> permanently)

That buffers count looks like you have something leaking. Probably a file
system. When kswapd is busy like that it is trying to free buffer cache.
The lack of freeing implies something is still holding those buffer cache
entries in memory. 

> You are right: page cache shrunk.
> You are wrong: it does _not_ work, because now buffers increased and obviously
> cannot be shrunk to allow "normal" applications to run. I could not even
> shutdown the machine correctly. It looks like a deadlock in vm to me.

Nope. The VM 

> I switched back to Linus' tree, because it does have problems, but is not dead
> within one day.

Thats good, Linus tree currently lasts about 30 minutes for me. I'd be
interested to know what your workload is and what drivers/filesystem you
are using so I can look for leaks.

Alan
