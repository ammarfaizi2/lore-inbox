Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263588AbUECGMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUECGMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 02:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbUECGMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 02:12:12 -0400
Received: from sitemail3.everyone.net ([216.200.145.37]:60898 "EHLO
	omta12.mta.everyone.net") by vger.kernel.org with ESMTP
	id S263588AbUECGMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 02:12:10 -0400
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Sun, 2 May 2004 23:10:20 -0700 (PDT)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Huge Pages, more efficient?
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.185.81]
X-Eon-Sig: AQHDJlhAleJMAAvKhgEAAAAB,25ccc2351b0d55aae78ecd0c6469861f
Message-Id: <20040503061020.0D31A396F@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me all replies.

Unless I miss my guess, huge (4MiB) pages and regular (4KiB) pages
can be intermixed.  Is there some way that the kernel could use a
heuristic to detect when a range of VM pages is faulted accross
frequently, and can be made into a huge 4MiB page, and then
sacrifice the overhead to shift these pages together physically and
invalidate the 1024 old 4KiB pages in favor of the new 4MiB page?

Doing it this way would make huge pages out of ranges that had
loops accross their bounds and close-together small functions.  It
would leave the faulting in overhead of pages that weren't really
useful as huge pages at the normal impact, while relieving the
constant faulting impact around page bound crossing loops and close
together functions.

Another neat trick to try would be to add onto this with a
heuristic which simply looks for faults accross an edge of the
huge pages and determines if these are more common than would-be
faults to the opposite end of the huge page if it were several
4KiB pages.  This would allow the huge page to be panned accross
memory to adapt, with only the overhead of moving the adjacent
pages to the huge page.

I might note that the efficiency of this relies a lot on the
assumption that huge pages need to be page-aligned to a normal
page boundary and not a huge page boundary.  The second idea
requires this condition to work; the first would work without
it, but would be more efficient if it were true.

Can anyone at least enlighten me as to if huge pages must be
4KiB page or 4MiB page aligned?

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
