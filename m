Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUHDUKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUHDUKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267402AbUHDUKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:10:10 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:17641 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267403AbUHDUKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:10:04 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, eric@cisu.net,
       kernel@kolivas.org, barryn@pobox.com, swsnyder@insightbb.com,
       linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
X-Message-Flag: Warning: May contain useful information
References: <200408021602.34320.swsnyder@insightbb.com>
	<410FA145.70701@kolivas.org> <20040804060625.GE10340@suse.de>
	<200408040614.30820.eric@cisu.net> <20040804130707.GN10340@suse.de>
	<20040804120633.4dca57b3.akpm@osdl.org> <210450000.1091647829@flay>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 04 Aug 2004 13:09:11 -0700
In-Reply-To: <210450000.1091647829@flay> (Martin J. Bligh's message of "Wed,
 04 Aug 2004 12:30:29 -0700")
Message-ID: <527jseis2g.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Aug 2004 20:09:11.0681 (UTC) FILETIME=[E857F710:01C47A5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Martin> I had a patch for a config option, ported forward by
    Martin> someone at IBM (I forget who, possibly Dave) from Andrea's
    Martin> original. I think we finally decided (in consultation with
    Martin> Andrea) we could drop the complicated stuff he had in the
    Martin> asm code, so it's pretty simple ... something like this:

Am I just being dense, or is this patch solving a different problem
from "do I really have to turn on HIGHMEM4G just to get the last 128MB
of my 1GB of RAM?"

It seems to me that none of the PAGE_OFFSET values offered (the patch
in allows PAGE_OFFSET to be set to 0xe0000000, 0xc0000000, 0x80000000
or 0x40000000, in addition to the 4G/4G value of 0x02000000) are
exactly what someone with 1 GB of RAM wants.  They'd be forced to go
down to a 2G/2G split which cheats userspace of quite a bit of address
space (admittedly with only 1 GB of RAM, a process bigger than 2 GB is
a bit of a stretch).  In any case a 2.75G/1.25G split as suggested
earlier works fine with 1 GB of RAM.

Also I notice that Con's patch modifies vmlinux.ld.S to update the
kernel base address, while this patch doesn't.  Is that intentional or
is does the patch depend on some other patches that use the defines in
page.h somehow as controlled by the following change?

+AFLAGS_vmlinux.lds.o += -include $(TOPDIR)/include/asm-i386/page.h

Thanks,
  Roland
