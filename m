Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUIEIBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUIEIBu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 04:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUIEIBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 04:01:50 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:31238 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S266324AbUIEIBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 04:01:49 -0400
Message-ID: <20040905120147.A9202@castle.nmd.msu.ru>
Date: Sun, 5 Sep 2004 12:01:47 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: linux-kernel@vger.kernel.org
Subject: Q about pagecache data never written to disk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's suppose an mmap'ed (SHARED, RW) file has a hole.
AFAICS, we allow to dirty the file pages without allocating the space for the
hole - filemap_nopage just "reads" the page filling it with zeroes, and
nothing is done about the on-disk data until writepage.

So, if the page can't be written to disk (no space), the dirty data just
stays in the pagecache.  The data can be read or seen via mmap, but it isn't
and never be on disk.  The pagecache stays unsynchronized with the on-disk
content forever.

Is it the intended behavior?
Shouldn't we call the filesystem to fill the hole at the moment of the first
write access?

	Andrey
