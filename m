Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSGQAuv>; Tue, 16 Jul 2002 20:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317923AbSGQAuu>; Tue, 16 Jul 2002 20:50:50 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:14066 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317859AbSGQAuu>;
	Tue, 16 Jul 2002 20:50:50 -0400
Date: Wed, 17 Jul 2002 02:53:34 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207170053.CAA01050@harpo.it.uu.se>
To: balbir.singh@wipro.com, hahn@physics.mcmaster.ca
Subject: Re: Pentium IV cache line size
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002 16:58:11 -0400 (EDT), Mark Hahn wrote:
>	- Place each synchronization variable alone, 
>	separated by 128 byte or in a separate cache line.
>
>see also table 1.1.  I'm not sure it matters whether you consider lines 128B
>or 64B; the fact that cacheline reads always happen at 128B is probably
>the dominant concern.  table 1.1 page 7-18 ("placement of shared
>synchonization variable") repeats this.

For SW synchronisation variables this makes sense.

However, I've been in contact with some people doing high-speed routing
with Linux boxes, and they had major performance problems on a dual P4/Xeon.
Somehow, the 128 byte alignment affected how the gigabit NIC driver they
used programmed the NIC, with the effect that buffering of PCI writes
(or something like that, this is from memory) didn't work and performance
dropped like a rock. They manually set the alignment back to 64 bytes in
the NIC driver and performance increased to expected levels.

/Mikael
