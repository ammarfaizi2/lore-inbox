Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbTLPGix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 01:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbTLPGix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 01:38:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:31154 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265112AbTLPGiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 01:38:51 -0500
Date: Mon, 15 Dec 2003 22:39:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Salmon <jsalmon@thesalmons.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about max_readahead for ide devices in 2.4?
Message-Id: <20031215223903.19687b79.akpm@osdl.org>
In-Reply-To: <200312152244.hBFMiej6011977@river.thesalmons.org>
References: <200312152244.hBFMiej6011977@river.thesalmons.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Salmon <jsalmon@thesalmons.org> wrote:
>
> 
> 
> Several "tuning" recommendations suggest that sequential accesses of
> large files, and hence the performance of busy web servers, can be improved
> by changing the maximum readahead value with, e.g.,
> 
> echo 511 > /proc/sys/vm/max-readahead
> 
> But it looks to me like get_max_readahead in filemap.c ignores the
> value set by /proc/sys in favor of max_readahead[major][minor] whenever
> max_readahead[major] is non-NULL.  And furthermore that 
> max_readahead[major] IS initialized to non-NULL for ide devices in
> init_gendisk.  (N.B. I'm looking at 2.4 sources).
> 
> Conclusion: echoing a value into /proc/sys/vm/max-readahead won't change the
> readahead behavior for already-probed IDE devices.
> 
> Is this correct, or am I missing something?

That's correct - it's all a bit weird.   You should use

	blockdev --setra 511 /dev/hda

for IDE devices.  Not sure about scsi.  You may as well set
/proc/sys/vm/max-readahead to the same thing.
