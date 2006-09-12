Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWILPjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWILPjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWILPjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:39:36 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:52620 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S1751333AbWILPjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:39:36 -0400
Date: Tue, 12 Sep 2006 17:39:32 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] 2.6.18-rc6: hda is allready "IN USE" when booting / pi futex
Message-ID: <20060912153932.GA14388@core>
References: <20060907133357.GA30888@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907133357.GA30888@core>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 03:33:57PM +0200, Christian Leber wrote:

> ide0: I/O resource 0x3F6-0x3F6
> hda: ERROR, PORTS ALREADY IN USE
> ide0 ad 0x1f0-0x1f7,0x3f6 on irq 14
> hdb: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
> ide1: I/O resource 0x376-0x376 not free
> ide0: ports already in use, skipping probe
> register_blkdev: cannot get major 3 for ide0
> 
> the probablity for this is about 70%, so with some patience i can use
> the box, but that also means it's very odd.
> Between the tries i allways switch it completly off.
> 
> It's a Dell Latitude C810 laptop with a Pentium 3m 1133 Mhz with Intel 82815
> chipset that has a ICH2M south-bridge.

I wasted a day to track it down, unfortunally it's for me completly
unclear how this commit s related to IDE, it could be some
timing issue, but that is just guessing.

With  77ba89c5cf28d5d98a3cae17f67a3e42b102cc25 (linux-2.6 tree) i don't have a
problem (i booted it 21 times until now and it allways worked) and 
b29739f902ee76a05493fb7d2303490fc75364f4 is the first bad commit.

So this seems to be the "offender":
Author: Ingo Molnar <mingo@elte.hu>
Date:   Tue Jun 27 02:54:51 2006 -0700

    [PATCH] pi-futex: scheduler support for pi


For convenience the diff is also here:
http://debian.christian-leber.de/idebad.patch
I have really no remote idea what is happening.

BTW: I have seen this problem too on a box with a intel BX440, but only
one time.

Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
