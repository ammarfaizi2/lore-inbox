Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbSJ2RD5>; Tue, 29 Oct 2002 12:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSJ2RD5>; Tue, 29 Oct 2002 12:03:57 -0500
Received: from waste.org ([209.173.204.2]:34725 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262358AbSJ2RD4>;
	Tue, 29 Oct 2002 12:03:56 -0500
Date: Tue, 29 Oct 2002 11:10:12 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Entropy from disks
Message-ID: <20021029171011.GD28665@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed:

http://linux.bkbits.net:8080/linux-2.5/cset@1.858?nav=index.html|ChangeSet@-2d

Since you're touching the disk entropy code, please read this, which
is one of the few papers on the subject:

http://world.std.com/~dtd/random/forward.ps

The current Linux PRNG is playing fast and loose here, adding entropy
based on the resolution of the TSC, while the physical turbulence
processes that actually produce entropy are happening at a scale of
seconds. On a GHz processor, if it takes 4 microseconds to return a
disk result from on-disk cache, /dev/random will get a 12-bit credit.

My entropy patches had each entropy source (not just disks) allocate
its own state object, and declare its timing "granularity".

There's a further problem with disk timing samples that make them less
than useful in typical headless server use (ie where it matters): the
server does its best to reveal disk latency to clients, easily
measurable within the auto-correlating domain of disk turbulence.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
