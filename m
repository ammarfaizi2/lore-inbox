Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261546AbSIXFR7>; Tue, 24 Sep 2002 01:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSIXFR7>; Tue, 24 Sep 2002 01:17:59 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:55815 "EHLO
	crawl.var.cx") by vger.kernel.org with ESMTP id <S261546AbSIXFR6>;
	Tue, 24 Sep 2002 01:17:58 -0400
Date: Tue, 24 Sep 2002 07:23:06 +0200
From: Frank v Waveren <fvw@var.cx>
To: linux-kernel@vger.kernel.org
Subject: isofs forcing cruft on volset# > 1
Message-ID: <1032843561MGN.fvw@jareth.var.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the isofs driver forces the 'cruft' option (which does some
nasty stuff like setting maximum filesize to 16mb to salvage malformed
filesystems) on filesystems that have a volume set sequence number
which is not 0 or 1. (linux/fs/isofs/inode.c:1273)

This has been brought up twice here, and gotten no replies. Could
someone please give a reason why we can't accept volume set sequence
numbers, even if we're not exporting them to userspace in any way?

If no-one has a any reasons why not I'll ask hpa to remove the check
or as Stanislav Brabec (utx@penguin.cz) suggested replace it by
testing if the highest byte of the sequence number is set, if this
helps detect some broken images (though I am hesitant to mark any
valid filesystem as cruft just on some heuristic that may be wrong,
even though having more than 16777215 CD's in a set does seem unlikely).

-- 
Frank v Waveren                                      Fingerprint: 0EDB 8787
fvw@[var.cx|stack.nl|dse.nl|chello.nl] ICQ#10074100     09B9 6EF5 6425 B855
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7179 3036 E136 B85D
