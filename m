Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314231AbSDVPrx>; Mon, 22 Apr 2002 11:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314234AbSDVPrw>; Mon, 22 Apr 2002 11:47:52 -0400
Received: from ns.tasking.nl ([195.193.207.2]:23051 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S314231AbSDVPrv>;
	Mon, 22 Apr 2002 11:47:51 -0400
Date: Mon, 22 Apr 2002 17:46:23 +0200
From: Frank van Maarseveen <fvm@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18: writeback of shared mmap'ed files broken?
Message-ID: <20020422174623.A25397@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A news server has two processes both accessing an "active" file.
This file is constantly being updated:

	cp /loc/news/lib/active /tmp/active
	sleep 1
	diff /loc/news/lib/active /tmp/active
		(differences)

However, its mtime does not change: it is days too old. Also, after
an unclean shutdown and reboot due to a power failure innd seemed to
operate on a very old version of the active file.

I don't think innd is calling msync() but IMHO that should not prohibit
the kernel from flushing out dirty pages at regular interval.

AFAIK there was a bug in the past with shared mmap'ed files but I thought
it was fixed a long time ago.

# lsof|grep lib/active
actived   30695   news  mem    REG        3,4    70078     209527 /loc/news/lib/active
innd      30696   news  mem    REG        3,4    70078     209527 /loc/news/lib/active
innd      30696   news   16u   REG        3,4    70078     209527 /loc/news/lib/active
# grep lib/active /proc/3069[56]/maps
4018b000-4019d000 r--s 00000000 03:04 209527     /loc/news/lib/active
40425000-40437000 rw-s 00000000 03:04 209527     /loc/news/lib/active


-- 
Frank
