Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUGZMt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUGZMt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 08:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUGZMrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 08:47:51 -0400
Received: from main.gmane.org ([80.91.224.249]:22232 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265263AbUGZMrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 08:47:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: Re: clearing filesystem cache for I/O benchmarks
Date: Mon, 26 Jul 2004 08:47:06 -0400
Message-ID: <87y8l7orzp.fsf@osu.edu>
References: <87smbfr5qe.fsf@osu.edu> <E1BouTC-0001Dx-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp065-025-157-254.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:05ooKzZX3F4ouRvPLAiqQ/VZDas=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels <ecki-news2004-05@lina.inka.de> writes:

> In article <87smbfr5qe.fsf@osu.edu> you wrote:
>> Thanks, that looks pretty useful, at least to force the I/O to make it
>> outside the kernel.  I'm still getting cache hits for some read tests
>> though
>
> This might be due to read ahead... how  do you check the cache hits, 

There must be cache hits since my poor old IDE disk from 1998 can only
perform at around 13 MB/sec for sustained sequential reads.  The
performance I was getting was 150 MB/sec for sustained sequential
reads, which led me to think it was cache hits for certain, since
there is no way my disk can be that fast.

> what read patterns do you have?

The test setup is simply this:

1) create a target file for benchmarking, say 32 Megabytes (my system
   RAM is 256MB, enough to cache all of that 32MB file)
2) run hdparm -f <device> to clear cache
3) read the target file from beginning to end into a user memory
   buffer (e.g. 32k in size), ignoring the read data (i.e. there are
   no data operations I make on the read data, this is a pure I/O test)

Because of #3, I'm not doing anything to the read data (I'm just
overwriting it with the next read) so I wouldn't imagine there is much
time from one read to the next to leverage any readahead.
-- 
Benjamin Rutt

