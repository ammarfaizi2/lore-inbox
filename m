Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbTAFOtC>; Mon, 6 Jan 2003 09:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbTAFOtC>; Mon, 6 Jan 2003 09:49:02 -0500
Received: from elin.scali.no ([62.70.89.10]:60680 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S266930AbTAFOtB>;
	Mon, 6 Jan 2003 09:49:01 -0500
Date: Mon, 6 Jan 2003 16:00:37 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: NAPI and tg3
In-Reply-To: <Pine.LNX.4.44.0301041613350.2946-100000@sp-laptop.isdn.scali.no>
Message-ID: <Pine.LNX.4.44.0301061538420.15870-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2003, Steffen Persvold wrote:

> Hi guys,
> 
> I have access to 8 Dell 2650s with onboard Broadcom BCM5701 chips. They 
> are quipped with Dual 2.4 GHz Xeon processors and 1GB of RAM. I'm running 
> RedHat 7.3, but with a stock 2.4.20 kernel.
> 
> As I understand it the tg3 driver is using NAPI on the 2.4.20 kernel 
> (dev->poll). I've been experiencing bad performance (low bandwidth) on 
> cluster applications running with LAM for example, but the problem 
> manifest itself if you run two bandwidth needy applications in parallel 
> on two machines (i.e two processes on each machine, one per processor) 
> using Gbe. 
> 
> I've disabled the NAPI mode and went back to the old interrupt method and 
> this works much better (i.e the bandwidth is now evenly distributed 
> between the two applications).
> 
> What could be the cause of this problem ? Is it NAPI itself (doing RX 
> under scheduler control) or is it something else (for example lock 
> contention).
> 
> Any ideas ?

Hi again,

I discovered that if I renice the ksoftirqd processes to level 0, the 
performance was actually better with the NAPI enabled driver compared to 
the one without (as was intended my NAPI IIRC). With the default nice 
level (19) on the ksoftirqd processes, the performance on multithreaded 
programs was pretty lousy with the NAPI enabled driver.

Any reason why the ksoftirqd shouldn't be nice level 0 by default ? Is 
this already fixed in 2.4.21-pre series ?

Regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

