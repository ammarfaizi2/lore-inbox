Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTLOWpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTLOWpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:45:10 -0500
Received: from adsl-67-113-198-75.dsl.lsan03.pacbell.net ([67.113.198.75]:46589
	"EHLO river.thesalmons.org") by vger.kernel.org with ESMTP
	id S264256AbTLOWpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:45:05 -0500
Date: Mon, 15 Dec 2003 14:44:40 -0800
Message-Id: <200312152244.hBFMiej6011977@river.thesalmons.org>
To: linux-kernel@vger.kernel.org
From: John Salmon <jsalmon@thesalmons.org>
Subject: question about max_readahead for ide devices in 2.4?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Several "tuning" recommendations suggest that sequential accesses of
large files, and hence the performance of busy web servers, can be improved
by changing the maximum readahead value with, e.g.,

echo 511 > /proc/sys/vm/max-readahead

But it looks to me like get_max_readahead in filemap.c ignores the
value set by /proc/sys in favor of max_readahead[major][minor] whenever
max_readahead[major] is non-NULL.  And furthermore that 
max_readahead[major] IS initialized to non-NULL for ide devices in
init_gendisk.  (N.B. I'm looking at 2.4 sources).

Conclusion: echoing a value into /proc/sys/vm/max-readahead won't change the
readahead behavior for already-probed IDE devices.

Is this correct, or am I missing something?

Thanks,
John Salmon
