Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWCaAXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWCaAXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCaAXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:23:10 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:26341 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751173AbWCaAXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:23:08 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] splice support #3
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, Christoph Hellwig <hch@infradead.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 31 Mar 2006 02:08:47 +0200
References: <5W5ei-5kR-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FP7PM-0003E3-PE@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:

> Ok, this should be it, I hope. Fixed the remaining issues spotted by
> akpm, and also thanks to KAMEZAWA Hiroyuki for pointing out that the
> page moving logic could get confused.

a) JFTR: When I first read of splice, I imagined the splice call would
replace the remote side of a pipe with any of the own fds (after flushing
the buffer). E.g. cat could optionally call splice on the last input file
and stdout, and on success, exit before the work is done. Is something like
this planned?

(Yes, I didn't pay much attention.)

b) Having read Christoph's comment, I think the planned splice syscall
should overlay the sendfile sysctl (keeping the historic name). Off cause
the offset parameter will give you strange results (*) if you're expecting
an input file, but I doubt there are programs using sendfile randomly,
hoping it would fail on pipes.

If you do that, users can generically call sendfile and it will DTRT if
possible.



*) Obviously offset = n on pipe-in_fd will either
 - skip n bytes from a pipe/socket, and it will be decremented by the
   number of skipped bytes after returning from the syscall.
or
 - be incremented by the number of copied bytes (no skipping happens).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
